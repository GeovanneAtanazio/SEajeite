import 'package:flutter_modular/flutter_modular.dart';

import 'package:seajeite/app/shared/util/routes.dart';
import 'package:seajeite/app/modules/home/home_page.dart';
import 'package:seajeite/app/modules/home/home_controller.dart';
import 'package:seajeite/app/shared/preferences/notification_preference.dart';
import 'package:seajeite/app/modules/home/controllers/notifications_controller.dart';
import 'package:seajeite/app/shared/repositories/local_storage/local_storage_shared.dart';

import 'pages/settings_page.dart';
import 'pages/notifications_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
        Bind((i) => NotificationsController()),
        Bind((i) => NotificationPreference(i.get<LocalStorageShared>())),
      ];

  @override
  List<Router> get routers => [
        Router(ROUTES.ROOT, child: (_, args) => HomePage()),
        Router(ROUTES.SETTINGS, child: (_, args) => SettingsPage()),
        Router(ROUTES.SETTINGS + ROUTES.NOTIFICATIONS,
            child: (_, args) => NotificationsPage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
