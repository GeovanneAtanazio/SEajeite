import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:seajeite/app/shared/util/routes.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Configurações"),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            buildCard(
              "Notificações",
              ROUTES.HOME + ROUTES.SETTINGS + ROUTES.NOTIFICATIONS,
            ),
          ],
        ),
      ),
    );
  }

  buildCard(String title, String route) {
    return InkWell(
      onTap: () => Modular.to.pushNamed(route),
      child: Card(
        child: ListTile(
          title: Text(title, style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
