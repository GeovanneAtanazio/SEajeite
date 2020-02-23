import 'dart:async';

import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import 'package:seajeite/app/app_module.dart';
import 'package:seajeite/app/util/screen_listener.dart';

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) {
    ScreenListener().startListening();
    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  Workmanager.initialize(
    callbackDispatcher, // The top level function, aka callbackDispatcher
  );
  Workmanager.registerOneOffTask("1", "simpleTask");
  runApp(AppModule());
}
