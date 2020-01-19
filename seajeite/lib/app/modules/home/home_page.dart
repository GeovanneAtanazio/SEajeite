import 'package:flutter/material.dart';
import 'package:screen_state/screen_state.dart';
import 'package:seajeite/app/util/lifecycle_event_handler.dart';

import './components/custom_timer_painter.dart';
import 'package:seajeite/app/modules/home/home_module.dart';
import 'package:seajeite/app/util/constants.dart';

import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = APP_TITLE}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final _bloc = HomeModule.to.getBloc<HomeBloc>();
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(LifecycleEventHandler(
      suspendingCallBack: () async => _bloc.cancelNotifications(),
    ));
    _bloc.startListening(onData);
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds:
            _bloc.tupleNotSetting.interval * _bloc.tupleNotSetting.qtdLimit,
      ),
    );
    controller.reverse(
      from: controller.value == 0.0 ? 1.0 : controller.value,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void onData(ScreenStateEvent event) {
    if (event == ScreenStateEvent.SCREEN_ON) {
      _bloc.restartTime();
      controller.reset();
      controller.reverse(
        from: controller.value == 0.0 ? 1.0 : controller.value,
      );

      _bloc.setNotifications(_bloc.tupleNotSetting.interval);
    }
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
                    StreamBuilder<double>(
                      stream: _bloc.outIntervalValue,
                      initialData: 10,
                      builder: (context, snapshot) {
                        return Slider(
                          onChanged: _bloc.setIntervalValue,
                          value: snapshot.data,
                          divisions: 5,
                          min: 10,
                          max: 60,
                          label: '${snapshot.data.toInt()} minutos',
                        );
                      },
                    ),
                    Text("Quantidade limite"),
                    StreamBuilder<double>(
                      stream: _bloc.outQtdLimitValue,
                      initialData: 1,
                      builder: (context, snapshot) {
                        return Slider(
                          onChanged: _bloc.setQtdLimitValue,
                          value: snapshot.data,
                          divisions: 11,
                          min: 1,
                          max: 12,
                          label: '${snapshot.data.toInt()} notificações',
                        );
                      },
                    ),
                  ],
                ),
                FlatButton(
                  textColor: Colors.blueGrey,
                  onPressed: () async {
                    await _bloc.saveNotificationSetting();
                    await _bloc.cancelNotifications();
                    _bloc.setNotifications(_bloc.tupleNotSetting.interval);
                    _bloc.restartTime();
                    Navigator.of(context).pop();
                    controller.duration = Duration(
                      seconds: _bloc.tupleNotSetting.interval *
                          _bloc.tupleNotSetting.qtdLimit,
                    );
                    controller.reset();
                    controller.reverse(
                      from: controller.value == 0.0 ? 1.0 : controller.value,
                    );
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
              await _bloc.getNotificationSetting();
              showSettingsDialog();
            },
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: controller,
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

  AnimatedBuilder buildAnimatedController() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return FloatingActionButton.extended(
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            if (controller.isAnimating) {
              controller.reset();
              _bloc.cancelNotifications();
            } else {
              _bloc.startListening(onData);
              _bloc.start = DateTime.now();
              controller.reverse(
                from: controller.value == 0.0 ? 1.0 : controller.value,
              );
            }
          },
          icon: Icon(
            controller.isAnimating ? Icons.stop : Icons.play_arrow,
          ),
          label: Text(
            controller.isAnimating ? DESCRIPTION_STOP : DESCRIPTION_START,
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
                  animation: controller,
                  builder: (BuildContext context, Widget child) {
                    return CustomPaint(
                      painter: CustomTimerPainter(
                        animation: controller,
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
                      animation: controller,
                      builder: (BuildContext context, Widget child) {
                        return Text(
                          _bloc.getTimer(),
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
