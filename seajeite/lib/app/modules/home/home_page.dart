import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:seajeite/app/shared/util/routes.dart';
import 'package:seajeite/app/shared/util/constants.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(STR_APP_TITLE),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            child: Container(
              child: Icon(
                Icons.settings,
              ),
              margin: EdgeInsets.only(right: 10),
            ),
            onTap: () {
              Modular.to.pushNamed(ROUTES.HOME + ROUTES.SETTINGS);
            },
          ),
        ],
      ),
      body: Observer(builder: (_) {
        return Center(
          child: buildFloatingActionButton(),
        );
      }),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton.extended(
      backgroundColor: Colors.blueGrey,
      onPressed: () async {
        if (controller.isNotifySet) {
          await controller.stopScreenListener();
        } else {
          await controller.startScreenListener();
        }
      },
      icon: Icon(
        controller.isNotifySet ? Icons.stop : Icons.play_arrow,
      ),
      label: Text(controller.isNotifySet ? STR_STOP : STR_START),
    );
  }
}
