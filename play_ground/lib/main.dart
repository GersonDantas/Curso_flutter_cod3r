import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat(reverse: true);

  late final Animation<double> _animation =
      CurvedAnimation(parent: controller, curve: Curves.bounceIn);

  final List colors = [
    Colors.red,
    Colors.black,
    Colors.amber,
    Colors.brown,
    Colors.redAccent,
  ];

  Color setColor() {
    int i = Random().nextInt(4);
    return colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flexible & Expanded',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text('Flexible & Expanded'),
          ),
          body: Column(
            children: [
              Container(
                height: 50,
                width: 50,
                color: setColor(),
                margin: EdgeInsets.all(10),
              ),
              Container(
                height: 50,
                width: 50,
                color: setColor(),
                margin: EdgeInsets.all(10),
              ),
              FadeTransition(
                opacity: _animation,
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: 50,
                  color: setColor(),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                height: 50,
                width: 50,
                color: setColor(),
              )
            ],
          ),
        ));
  }
}
