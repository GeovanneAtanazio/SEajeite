import 'package:flutter/material.dart';
import 'package:seajeite/app/components/custom_timer_painter.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Seajeite"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController controller;
  DateTime start = DateTime.now();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: 10),
    );
  }

  String getTimer() {
    int secs = DateTime.now().difference(start).inSeconds;
    String minutes = (secs / 60 - 0.499).round().toString();
    String seconds = (secs % 60).toString();
    return (minutes.length < 2 ? "0" + minutes : minutes) + ":" + (seconds.length < 2 ? "0" + seconds : seconds);
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
                      backgroundColor: Colors.lightBlue,
                      onPressed: () {
                        if (controller.isAnimating) {
                          controller.reset();
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
                      label: Text(controller.isAnimating ? "Parar" : "Começar"),
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
