import 'dart:async';

import 'package:flutter/material.dart';
import 'package:screen_state/screen_state.dart';
import 'package:seajeite/app/components/custom_timer_painter.dart';
import 'package:seajeite/app/util/notifier.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Seajeite"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController controller;
  DateTime start = DateTime.now();
  var notifier = Notifier();

  @override
  void initState() {
    super.initState();
    startListening();
    controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: 6),
    );
    controller.reverse(
      from: controller.value == 0.0 ? 1.0 : controller.value,
    );
  }

  Screen _screen;
  StreamSubscription<ScreenStateEvent> _subscription;

  void onData(ScreenStateEvent event) {
    start = DateTime.now();
    if (event == ScreenStateEvent.SCREEN_ON) {
      controller.reset();
      controller.reverse(
        from: controller.value == 0.0 ? 1.0 : controller.value,
      );
    }
  }

  void startListening() {
    notifier.init();
    _screen = new Screen();
    try {
      _subscription = _screen.screenStateStream.listen(onData);
    } on ScreenStateException catch (exception) {
      print(exception);
    }
  }

  String getTimer() {
    int secs = DateTime.now().difference(start).inSeconds;
    int minutes = (secs / 60 - 0.499).round();
    if (minutes > 60) {
      notifier.cancel();
    }
    String seconds = (secs % 60).toString();
    return (minutes.toString().length < 2
            ? "0" + minutes.toString()
            : minutes.toString()) +
        ":" +
        (seconds.length < 2 ? "0" + seconds : seconds);
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
                Expanded(
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
                                  "\n\nTEMPO DE ATIVIDADE",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.lightBlue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                AnimatedBuilder(
                                  animation: controller,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return Text(
                                      getTimer(),
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
                ),
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return FloatingActionButton.extended(
                      backgroundColor: Colors.blueGrey,
                      onPressed: () {
                        if (controller.isAnimating) {
                          controller.reset();
                          notifier.cancel();
                        } else {
                          start = DateTime.now();
                          controller.reverse(
                            from: controller.value == 0.0
                                ? 1.0
                                : controller.value,
                          );
                        }
                      },
                      icon: Icon(
                        controller.isAnimating ? Icons.stop : Icons.play_arrow,
                      ),
                      label: Text(controller.isAnimating ? "Parar" : "Iniciar"),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
