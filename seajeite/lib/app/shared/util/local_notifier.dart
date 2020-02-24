import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:seajeite/app/shared/util/constants.dart';

class LocalNotifier {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  NotificationDetails _pltfrmChnlSpc;

  LocalNotifier() {
    _init();
  }

  void _init() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    var ndrdChnlSpc = AndroidNotificationDetails(
      STR_APP_TITLE,
      STR_APP_TITLE,
      DESCRIPTION_NOTIFY_CHN,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );

    var iOSChnlSpc = IOSNotificationDetails();
    _pltfrmChnlSpc = NotificationDetails(ndrdChnlSpc, iOSChnlSpc);
  }

  Future<void> cancelNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> notifyPeriodic(
      int duration, int times, String title, String body) async {
    var time = DateTime.now();
    for (var i = 0; i < times; i++) {
      time = time.add(Duration(minutes: duration));
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
