import 'package:mobx/mobx.dart';

import 'package:seajeite/app/shared/util/constants.dart';
import 'package:seajeite/app/shared/util/local_notifier.dart';
import 'package:seajeite/app/shared/model/notification_model.dart';
import 'package:seajeite/app/shared/preferences/notification_preference.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final LocalNotifier _notifier;
  final NotificationPreference _notificationPreference;

  _HomeControllerBase(this._notifier, this._notificationPreference);

  @observable
  bool isNotifySet = false;

  @action
  setIsNotifySet(newIsNotifySet) => isNotifySet = newIsNotifySet;

  @action
  Future<NotificationModel> getNotificationSetting() async {
    var notificationSettings =
        await _notificationPreference.getNotificationSettings();
    if (notificationSettings == null)
      notificationSettings = NotificationModel(NOTIFY_INTERVAL, NOTIFY_TIMES);
    return notificationSettings;
  }

  Future<void> setNotifications() async {
    var notificationSettings = await getNotificationSetting();
    await _notifier.notifyPeriodic(
      notificationSettings.interval,
      notificationSettings.qtdLimit,
      STR_APP_TITLE,
      DESCRIPTION_NOTIFY,
    );
    setIsNotifySet(true);
  }

  Future<void> cancelNotifications() async {
    await _notifier.cancelNotifications();
    setIsNotifySet(false);
  }
}
