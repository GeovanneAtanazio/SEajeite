import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:screen_state/screen_state.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:seajeite/app/shared/util/constants.dart';
import 'package:seajeite/app/modules/home/components/custom_timer_painter.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = APP_TITLE}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController>
    with TickerProviderStateMixin {
  AnimationController _aController;

  @override
  void initState() {
    controller.startListening(onData);
    _aController = AnimationController(
      vsync: this,
      duration: Duration(
        minutes: controller.interval.toInt() * controller.qtdLimit.toInt(),
      ),
    );
    _aController.reverse(
      from: _aController.value == 0.0 ? 1.0 : _aController.value,
    );
    super.initState();
  }

  @override
  Future<void> dispose() async {
    await controller.cancelNotifications();
    super.dispose();
  }

  Future<void> onData(ScreenStateEvent event) async {
    if (event == ScreenStateEvent.SCREEN_UNLOCKED) {
      await controller.setNotifications();
      _aController.reset();
      _aController.reverse(
        from: _aController.value == 0.0 ? 1.0 : _aController.value,
      );
    } else if (event == ScreenStateEvent.SCREEN_OFF)
      await controller.cancelNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            child: Container(
              child: Icon(
                Icons.settings,
              ),
              margin: EdgeInsets.only(right: 10),
            ),
            onTap: () async {
              await controller.getNotificationSetting();
              showSettingsDialog();
            },
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _aController,
        builder: (context, child) {
          return Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                buildExpandedTimer(),
                buildAnimatedController(),
              ],
            ),
          );
        },
      ),
    );
  }

  showSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 240,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    "Configurar Notificações",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  margin: EdgeInsets.only(bottom: 30),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Tempo de intervalo"),
                    Observer(
                      builder: (_) {
                        return Slider(
                          onChanged: controller.setInterval,
                          value: controller.interval,
                          divisions:
                              ((MAX_NOTIFY_INTERVAL - MIN_NOTIFY_INTERVAL) / 2)
                                  .round(),
                          min: MIN_NOTIFY_INTERVAL,
                          max: MAX_NOTIFY_INTERVAL,
                          label: '${controller.interval.toInt()} minutos',
                        );
                      },
                    ),
                    Text("Quantidade limite"),
                    Observer(
                      builder: (_) {
                        return Slider(
                          onChanged: controller.setQtdLimit,
                          value: controller.qtdLimit,
                          divisions: ((MAX_NOTIFY_TIMES - MIN_NOTIFY_TIMES) / 2)
                              .round(),
                          min: MIN_NOTIFY_TIMES,
                          max: MAX_NOTIFY_TIMES,
                          label: '${controller.qtdLimit.toInt()} notificações',
                        );
                      },
                    ),
                  ],
                ),
                FlatButton(
                  textColor: Colors.blueGrey,
                  onPressed: () async {
                    await controller.saveNotificationSetting();
                    await controller.cancelNotifications();
                    await controller.setNotifications();
                    Navigator.of(context).pop();
                    _aController.duration = Duration(
                      minutes: controller.interval.toInt() *
                          controller.qtdLimit.toInt(),
                    );
                    _aController.reset();
                    _aController.reverse(
                        from: _aController.value == 0.0
                            ? 1.0
                            : _aController.value);
                  },
                  child: Text("OK"),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  AnimatedBuilder buildAnimatedController() {
    return AnimatedBuilder(
      animation: _aController,
      builder: (context, child) {
        return FloatingActionButton.extended(
          backgroundColor: Colors.blueGrey,
          onPressed: () async {
            if (_aController.isAnimating) {
              _aController.reset();
              await controller.cancelNotifications();
            } else {
              await controller.startListening(onData);
              _aController.reset();
              _aController.reverse(
                from: _aController.value == 0.0 ? 1.0 : _aController.value,
              );
            }
            controller.restartTime();
          },
          icon: Icon(
            _aController.isAnimating ? Icons.stop : Icons.play_arrow,
          ),
          label: Text(
            _aController.isAnimating ? DESCRIPTION_STOP : DESCRIPTION_START,
          ),
        );
      },
    );
  }

  Expanded buildExpandedTimer() {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.center,
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _aController,
                  builder: (BuildContext context, Widget child) {
                    return CustomPaint(
                      painter: CustomTimerPainter(
                        animation: _aController,
                        backgroundColor: Colors.blueGrey,
                        color: Colors.lightBlue,
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: FractionalOffset.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "\n\n$DESCRIPTION_ACTIVITY_TIME",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.lightBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _aController,
                      builder: (BuildContext context, Widget child) {
                        return Text(
                          _aController.isAnimating
                              ? controller.getTimer(_aController.reset)
                              : "00:00",
                          style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.lightBlue,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
