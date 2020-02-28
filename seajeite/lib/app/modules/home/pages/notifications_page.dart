import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:seajeite/app/shared/components/dialog_components.dart';

import 'package:seajeite/app/shared/util/constants.dart';
import 'package:seajeite/app/modules/home/controllers/notifications_controller.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState
    extends ModularState<NotificationsPage, NotificationsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(STR_NOTIFICATIONS),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          children: <Widget>[
            buildSliderHeaderTitle(DESCRIPTION_NOTIFICATIONS_INTERVAL),
            buildSliderInterval(),
            SizedBox(height: 30),
            buildSliderHeaderTitle(DESCRIPTION_NOTIFICATIONS_LIMIT),
            buildSliderQtdLimit(),
            SizedBox(height: 50),
            buildFloatingButton(),
          ],
        ),
      ),
    );
  }

  Text buildSliderHeaderTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    );
  }

  Observer buildSliderInterval() {
    return Observer(
      builder: (_) {
        return Slider(
          onChanged: controller.setInterval,
          value: controller.interval,
          divisions: ((MAX_NOTIFY_INTERVAL - MIN_NOTIFY_INTERVAL) / 2).round(),
          min: MIN_NOTIFY_INTERVAL,
          max: MAX_NOTIFY_INTERVAL,
          label: '${controller.interval.toInt()} $STR_MINUTES',
        );
      },
    );
  }

  Observer buildSliderQtdLimit() {
    return Observer(
      builder: (_) {
        return Slider(
          onChanged: controller.setQtdLimit,
          value: controller.qtdLimit,
          divisions: ((MAX_NOTIFY_TIMES - MIN_NOTIFY_TIMES) / 2).round(),
          min: MIN_NOTIFY_TIMES,
          max: MAX_NOTIFY_TIMES,
          label:
              '${controller.qtdLimit.toInt()} ${STR_NOTIFICATIONS.toLowerCase()}',
        );
      },
    );
  }

  Observer buildFloatingButton() {
    return Observer(
      builder: (_) {
        if (controller.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return FloatingActionButton.extended(
          onPressed: () async {
            await controller.saveNotificationSetting(
              (msg) => DialogComponents.showToast(
                msg: msg,
                isLengthShort: true,
              ),
            );
          },
          icon: Icon(Icons.check),
          label: Text(STR_CONFIRM),
        );
      },
    );
  }
}
