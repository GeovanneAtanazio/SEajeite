import 'package:flutter/material.dart';
import 'package:screen_state/screen_state.dart';

import 'package:seajeite/app/components/custom_timer_painter.dart';
import 'package:seajeite/app/modules/home/home_module.dart';
import 'package:seajeite/app/util/constants.dart';

import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = APP_TITLE}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final _bloc = HomeModule.to.getBloc<HomeBloc>();
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    _bloc.startListening(onData);
    controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: NOTIFY_TIMES * NOTIFY_INTERVAL),
    );
    controller.reverse(
      from: controller.value == 0.0 ? 1.0 : controller.value,
    );
  }

  void onData(ScreenStateEvent event) {
    if (event == ScreenStateEvent.SCREEN_ON) {
      _bloc.start = DateTime.now();
      controller.reset();
      controller.reverse(
        from: controller.value == 0.0 ? 1.0 : controller.value,
      );

      _bloc.setNotifications(
        Duration(minutes: NOTIFY_INTERVAL),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
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
