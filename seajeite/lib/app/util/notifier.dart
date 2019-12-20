import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifier {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  NotificationDetails _pltfrmChnlSpc;

  init() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    var ndrdChnlSpc = AndroidNotificationDetails(
      'seajeite',
      'Seajeite',
      'Lembrete de correção postural',
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSChnlSpc = IOSNotificationDetails();
    _pltfrmChnlSpc = NotificationDetails(ndrdChnlSpc, iOSChnlSpc);
  }

  cancel() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  notifyPeriodic(Duration duration, String title, String body) async {
    var time = DateTime.now();
    for (var i = 0; i < 5; i++) {
      time = time.add(duration);
      await _flutterLocalNotificationsPlugin.schedule(
          (time.millisecondsSinceEpoch / 1000).round(),
          title,
          body,
          time,
          _pltfrmChnlSpc);
      print((time.millisecondsSinceEpoch / 1000).round().toString());
    }
  }
}
