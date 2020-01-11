import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:screen_state/screen_state.dart';

import 'package:seajeite/app/util/constants.dart';
import 'package:seajeite/app/util/local_notifier.dart';

class HomeBloc extends BlocBase {
  var start = DateTime.now();
  var notifier = LocalNotifier();
  Screen _screen;

  void startListening(onData) {
    notifier.init();
    _screen = new Screen();
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

  void setNotifications(Duration duration) {
    notifier.notifyPeriodic(
      duration,
      APP_TITLE,
      NOTIFY_TEXT,
    );
  }

  void cancelNotifications() {
    notifier.cancel();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
