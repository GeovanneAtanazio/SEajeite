import 'package:mobx/mobx.dart';
import 'package:screen_state/screen_state.dart';

import 'package:seajeite/app/shared/util/constants.dart';
import 'package:seajeite/app/shared/util/local_notifier.dart';
import 'package:seajeite/app/shared/model/notification_model.dart';
import 'package:seajeite/app/shared/preferences/notification_preference.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final LocalNotifier _notifier;
  final NotificationPreference _notificationPreference;
  Screen _screen;

  _HomeControllerBase(this._notifier, this._notificationPreference);

  @observable
  var startTime = DateTime.now();
  @observable
  double interval = NOTIFY_INTERVAL.toDouble();
  @observable
  double qtdLimit = NOTIFY_TIMES.toDouble();

  @action
  setInterval(double newInterval) => interval = newInterval;

  @action
  setQtdLimit(double newTimes) => qtdLimit = newTimes;

  @action
  restartTime() => startTime = DateTime.now();

  Future<void> saveNotificationSetting() async {
    var notificationSettings =
        NotificationModel(interval.toInt(), qtdLimit.toInt());
    await _notificationPreference.setNotificationSettings(notificationSettings);
  }

  @action
  Future<void> getNotificationSetting() async {
    var notificationSettings =
        await _notificationPreference.getNotificationSettings();
    if (notificationSettings != null) {
      setInterval(notificationSettings.interval.toDouble());
      setQtdLimit(notificationSettings.qtdLimit.toDouble());
    }
  }

  Future<void> startListening(onData) async {
    _screen = Screen();

    await _notifier.cancelNotifications();
    await setNotifications();

    try {
      _screen.screenStateStream.listen(onData);
    } on ScreenStateException catch (e) {
      print(e);
    }
  }

  String getTimer(Function animationReset) {
    int totalSeconds = DateTime.now().difference(startTime).inSeconds;
    int minutes = (totalSeconds / 60 - 0.499).round();

    if (minutes > (interval * qtdLimit) - 0.5) {
      cancelNotifications();
      restartTime();
      return "00:00";
    }

    String seconds = (totalSeconds % 60).toString();
    return (minutes.toString().length < 2
            ? "0" + minutes.toString()
            : minutes.toString()) +
        ":" +
        (seconds.length < 2 ? "0" + seconds : seconds);
  }

  Future<void> setNotifications() async {
    await getNotificationSetting();
    await _notifier.notifyPeriodic(
      interval.toInt(),
      qtdLimit.toInt(),
      APP_TITLE,
      NOTIFY_TEXT,
    );
    restartTime();
  }

  Future<void> cancelNotifications() async {
    await _notifier.cancelNotifications();
  }
}
