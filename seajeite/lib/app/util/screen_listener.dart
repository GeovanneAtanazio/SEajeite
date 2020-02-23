import 'package:screen_state/screen_state.dart';
import 'package:seajeite/app/preferences/notification_tuple_preference.dart';
import 'package:seajeite/app/util/constants.dart';
import 'package:seajeite/app/util/notification_setting_tuple.dart';

import 'local_notifier.dart';

class ScreenListener {
  Screen _screen;
  final notifier = LocalNotifier();
  final tuplePreference = NotificationSettingTuplePreference();

  Future<void> onData(ScreenStateEvent event) async {
    if (event == ScreenStateEvent.SCREEN_OFF) {
      notifier.cancel();
    } else if (event == ScreenStateEvent.SCREEN_ON) {
      NotificationSettingTuple tupleNotSetting =
          await tuplePreference.getNotificationSettingTuple();
      if (tupleNotSetting != null) {
        notifier.notifyPeriodic(tupleNotSetting.interval,
            tupleNotSetting.qtdLimit, APP_TITLE, NOTIFY_TEXT);
      } else {
        notifier.notifyPeriodic(
            NOTIFY_INTERVAL, NOTIFY_TIMES, APP_TITLE, NOTIFY_TEXT);
      }
    }
  }

  void startListening() {
    _screen = new Screen();
    notifier.init();
    try {
      _screen.screenStateStream.listen(onData);
    } on ScreenStateException catch (exception) {
      print(exception);
    }
  }
}
