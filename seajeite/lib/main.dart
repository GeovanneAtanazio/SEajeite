import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:seajeite/app/app_module.dart';
import 'package:seajeite/app/shared/util/local_notifier.dart';
import 'package:seajeite/app/shared/util/screen_listener.dart';
import 'package:seajeite/app/shared/preferences/notification_preference.dart';
import 'package:seajeite/app/shared/repositories/local_storage/local_storage_shared.dart';

GetIt getIt = GetIt.I;

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) {
    ScreenListener(
      notifier: getIt.get<LocalNotifier>(),
      notificationPreference: getIt.get<NotificationPreference>(),
    );
    return Future.value(true);
  });
}

void main() {
  getIt.registerLazySingleton<LocalNotifier>(() => LocalNotifier());
  getIt.registerLazySingleton<LocalStorageShared>(() => LocalStorageShared());
  getIt.registerLazySingleton<NotificationPreference>(
      () => NotificationPreference(getIt.get<LocalStorageShared>()));

  WidgetsFlutterBinding.ensureInitialized();
  Workmanager.initialize(
    callbackDispatcher, // The top level function, aka callbackDispatcher
  );
  Workmanager.registerOneOffTask("1", "simpleTask");

  runApp(ModularApp(module: AppModule()));
}
