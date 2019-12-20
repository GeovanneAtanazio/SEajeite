import 'dart:async';

import 'package:flutter/material.dart';
import 'package:screen_state/screen_state.dart';
import 'package:seajeite/app/app_module.dart';
import 'package:seajeite/app/util/notifier.dart';
import 'package:workmanager/workmanager.dart';

Screen _screen;
Notifier notifier = Notifier();

void onData(ScreenStateEvent event) {
  if (event == ScreenStateEvent.SCREEN_OFF) {
    notifier.cancel();
  } else if (event == ScreenStateEvent.SCREEN_ON) {
    notifier.notifyPeriodic(Duration(minutes: 1), "Seajeite",
        "Arruma essa postura, seu arrombado!");
  }
}

void startListening() {
  _screen = new Screen();
  notifier.init();
  try {
    _screen.screenStateStream.listen(onData);
  } on ScreenStateException catch (exception) {
    print(exception);
  }
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) {
    startListening();
    return Future.value(true);
  });
}

void main() {
  Workmanager.initialize(
    callbackDispatcher, // The top level function, aka callbackDispatcher
  );
  Workmanager.registerOneOffTask("1", "simpleTask");
  runApp(AppModule());
}
