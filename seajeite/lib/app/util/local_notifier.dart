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
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSChnlSpc = IOSNotificationDetails();
    _pltfrmChnlSpc = NotificationDetails(ndrdChnlSpc, iOSChnlSpc);
  }

  Future<void> cancel() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  void notifyPeriodic(
      int duration, int times, String title, String body) async {
    var time = DateTime.now();
    for (var i = 0; i < times; i++) {
      time = time.add(Duration(seconds: duration));
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
