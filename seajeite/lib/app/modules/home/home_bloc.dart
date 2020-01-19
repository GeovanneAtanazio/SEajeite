import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';
import 'package:screen_state/screen_state.dart';
import 'package:seajeite/app/preferences/notification_tuple_preference.dart';

import 'package:seajeite/app/util/constants.dart';
import 'package:seajeite/app/util/local_notifier.dart';
import 'package:seajeite/app/util/notification_setting_tuple.dart';

class HomeBloc extends BlocBase {
  var start = DateTime.now();
  final notifier = LocalNotifier();
  final tuplePreference = NotificationSettingTuplePreference();
  Screen _screen;

  var _tupleNotSetting =
      NotificationSettingTuple(NOTIFY_INTERVAL, NOTIFY_TIMES);
  NotificationSettingTuple get tupleNotSetting => _tupleNotSetting;

  final _intervalController =
      BehaviorSubject<double>.seeded(NOTIFY_INTERVAL.toDouble());
  Stream<double> get outIntervalValue => _intervalController.stream;
  Function(double) get setIntervalValue => _intervalController.sink.add;
  double get interval => _intervalController.value;

  final _qtdLimitValueController =
      BehaviorSubject<double>.seeded(NOTIFY_TIMES.toDouble());
  Stream<double> get outQtdLimitValue => _qtdLimitValueController.stream;
  Function(double) get setQtdLimitValue => _qtdLimitValueController.sink.add;
  double get qtdLimit => _qtdLimitValueController.value;

  Future<void> saveNotificationSetting() async {
    _tupleNotSetting =
        NotificationSettingTuple(interval.toInt(), qtdLimit.toInt());
    await tuplePreference.setTuple(tupleNotSetting);
  }

  Future<void> getNotificationSetting() async {
    _tupleNotSetting = await tuplePreference.getNotificationSettingTuple();
    if (tupleNotSetting != null) {
      setIntervalValue(tupleNotSetting.interval.toDouble());
      setQtdLimitValue(tupleNotSetting.qtdLimit.toDouble());
    }
  }

  void restartTime() {
    start = DateTime.now();
  }

  void startListening(onData) {
    notifier.init();
    _screen = new Screen();

    cancelNotifications();
    setNotifications(tupleNotSetting.interval);

    try {
      _screen.screenStateStream.listen(onData);
    } on ScreenStateException catch (e) {
      print(e);
    }
  }

  String getTimer() {
    int secs = DateTime.now().difference(start).inSeconds;
    int minutes = (secs / 60 - 0.499).round();

    if (minutes > 60) {
      cancelNotifications();
    }

    String seconds = (secs % 60).toString();
    return (minutes.toString().length < 2
            ? "0" + minutes.toString()
            : minutes.toString()) +
        ":" +
        (seconds.length < 2 ? "0" + seconds : seconds);
  }

  void setNotifications(int duration) {
    notifier.notifyPeriodic(
      duration,
      tupleNotSetting.qtdLimit,
      APP_TITLE,
      NOTIFY_TEXT,
    );
  }

  Future<void> cancelNotifications() async {
    await notifier.cancel();
  }

  @override
  void dispose() {
    _intervalController?.close();
    _qtdLimitValueController?.close();
    super.dispose();
  }
}
