import 'package:screen_state/screen_state.dart';
import 'package:seajeite/app/util/constants.dart';

import 'local_notifier.dart';

class ScreenListener {
  Screen _screen;
  final notifier = LocalNotifier();

  void onData(ScreenStateEvent event) {
    if (event == ScreenStateEvent.SCREEN_OFF) {
      notifier.cancel();
    } else if (event == ScreenStateEvent.SCREEN_ON) {
      notifier.notifyPeriodic(Duration(minutes: 1), APP_TITLE, NOTIFY_TEXT);
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
