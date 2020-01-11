import 'package:flutter/material.dart';
import 'package:seajeite/app/modules/home/home_module.dart';
import 'package:seajeite/app/util/constants.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomeModule(),
      debugShowCheckedModeBanner: false,
    );
  }
}
