import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:seajeite/app/util/constants.dart';

class LocalNotifier {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  NotificationDetails _pltfrmChnlSpc;

  void init() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    var ndrdChnlSpc = AndroidNotificationDetails(
      APP_TITLE,
      NAME_NOTIFY_CHN,
      DESCRIPTION_NOTIFY_CHN,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSChnlSpc = IOSNotificationDetails();
    _pltfrmChnlSpc = NotificationDetails(ndrdChnlSpc, iOSChnlSpc);
  }

  void cancel() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  void notifyPeriodic(Duration duration, String title, String body) async {
    var time = DateTime.now();
    for (var i = 1; i < NOTIFY_TIMES; i++) {
      time = time.add(duration);
      await _flutterLocalNotificationsPlugin.schedule(
        (time.millisecondsSinceEpoch / 1000).round(),
        title,
        body,
        time,
        _pltfrmChnlSpc,
      );
    }
  }
}
