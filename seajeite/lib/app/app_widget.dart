import 'package:flutter/material.dart';
import 'package:seajeite/app/modules/home/home_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seajeite',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomeModule(),
    );
  }
}
