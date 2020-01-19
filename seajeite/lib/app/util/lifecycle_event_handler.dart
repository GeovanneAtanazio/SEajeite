import 'package:flutter/material.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  LifecycleEventHandler({this.suspendingCallBack});

  final Function suspendingCallBack;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.resumed:
      case AppLifecycleState.detached:
        await suspendingCallBack();
        break;
    }
  }
}
