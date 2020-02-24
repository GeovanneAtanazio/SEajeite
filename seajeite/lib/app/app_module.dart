import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:seajeite/app/app_widget.dart';
import 'package:seajeite/app/app_controller.dart';
import 'package:seajeite/app/modules/home/home_module.dart';
import 'package:seajeite/app/shared/util/local_notifier.dart';
import 'package:seajeite/app/shared/preferences/notification_preference.dart';
import 'package:seajeite/app/shared/repositories/local_storage/local_storage_shared.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => GetIt.I.get<LocalNotifier>()),
        Bind((i) => GetIt.I.get<LocalStorageShared>()),
        Bind((i) => GetIt.I.get<NotificationPreference>()),
      ];

  @override
  List<Router> get routers => [
        Router("/", module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
