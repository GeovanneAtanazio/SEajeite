import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:seajeite/app/shared/util/routes.dart';
import 'package:seajeite/app/shared/util/constants.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  Future<void> navigate() async {
    await Future.delayed(Duration(seconds: 2));
    await Modular.to.pushReplacementNamed(ROUTES.HOME);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff183e50),
      body: Center(
        child: Image.asset(
          APP_ICON_PATH,
          height: 200,
        ),
      ),
    );
  }
}
