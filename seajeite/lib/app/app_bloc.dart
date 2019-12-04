import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppBloc extends BlocBase {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  NotificationDetails _pltfrmChnlSpc;
  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }

  Future initBloc() async {
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

  notify(int id, String title, String body) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
    await _flutterLocalNotificationsPlugin.show(
        id, title, body, _pltfrmChnlSpc);
  }
}
