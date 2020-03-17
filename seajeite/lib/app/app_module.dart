import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:seajeite/app/app_widget.dart';
import 'package:seajeite/app/app_controller.dart';
import 'package:seajeite/app/shared/util/routes.dart';
import 'package:seajeite/app/splash/splash_page.dart';
import 'package:seajeite/app/modules/home/home_module.dart';
import 'package:seajeite/app/shared/util/local_notifier.dart';
import 'package:seajeite/app/shared/repositories/local_storage/local_storage_shared.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => LocalNotifier()),
        Bind((i) => LocalStorageShared()),
      ];

  @override
  List<Router> get routers => [
        Router(ROUTES.ROOT, child: (_, args) => SplashPage()),
        Router(ROUTES.HOME, module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
