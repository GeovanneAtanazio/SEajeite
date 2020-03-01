import 'package:meta/meta.dart';
import 'package:screen_state/screen_state.dart';

import 'package:seajeite/app/shared/model/notification_model.dart';
import 'package:seajeite/app/shared/preferences/notification_preference.dart';

import 'constants.dart';
import 'local_notifier.dart';

class ScreenListener {
  Screen _screen;
  final LocalNotifier notifier;
  final NotificationPreference notificationPreference;

  ScreenListener({
    @required this.notifier,
    @required this.notificationPreference,
  });

  Future<void> onData(ScreenStateEvent event) async {
    if (event == ScreenStateEvent.SCREEN_OFF) {
      notifier.cancelNotifications();
    } else if (event == ScreenStateEvent.SCREEN_UNLOCKED) {
      NotificationModel notificationSettings =
          await notificationPreference.getNotificationSettings();
      if (notificationSettings != null) {
        notifier.notifyPeriodic(notificationSettings.interval,
            notificationSettings.qtdLimit, STR_APP_TITLE, DESCRIPTION_NOTIFY);
      } else {
        notifier.notifyPeriodic(
            NOTIFY_INTERVAL, NOTIFY_TIMES, STR_APP_TITLE, DESCRIPTION_NOTIFY);
      }
    }
  }

  void startListening() {
    _screen = Screen();
    try {
      _screen.screenStateStream.listen(onData);
    } on ScreenStateException catch (exception) {
      print(exception);
    }
  }

  void stopListening() {
    _screen = null;
  }
}
