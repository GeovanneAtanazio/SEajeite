import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:seajeite/app/shared/model/notification_model.dart';
import 'package:seajeite/app/shared/preferences/notification_preference.dart';
import 'package:seajeite/app/shared/util/constants.dart';

part 'notifications_controller.g.dart';

class NotificationsController = _NotificationsControllerBase
    with _$NotificationsController;

abstract class _NotificationsControllerBase with Store {
  final NotificationPreference _notificationPreference = Modular.get();

  _NotificationsControllerBase() {
    getNotificationSetting();
  }

  @observable
  double interval = NOTIFY_INTERVAL.toDouble();
  @observable
  double qtdLimit = NOTIFY_TIMES.toDouble();
  @observable
  bool isLoading = false;

  @action
  setInterval(double newInterval) => interval = newInterval;

  @action
  setIsLoading(bool newIsLoading) => isLoading = newIsLoading;

  @action
  setQtdLimit(double newTimes) => qtdLimit = newTimes;

  Future<void> saveNotificationSetting(Function callback) async {
    setIsLoading(true);
    if (interval != null && qtdLimit != null) {
      var notificationSettings =
          NotificationModel(interval.toInt(), qtdLimit.toInt());
      await _notificationPreference
          .setNotificationSettings(notificationSettings)
          .then((status) => callback(status
              ? "Configurações salvas com sucesso"
              : "Erro ao tentar salvar configurações"))
          .catchError((e) => callback("Erro ao tentar salvar configurações"));
    }
    setIsLoading(false);
  }

  @action
  Future<void> getNotificationSetting() async {
    setIsLoading(true);
    var notificationSettings =
        await _notificationPreference.getNotificationSettings();
    if (notificationSettings != null) {
      setInterval(notificationSettings.interval.toDouble());
      setQtdLimit(notificationSettings.qtdLimit.toDouble());
    }
    setIsLoading(false);
  }
}
