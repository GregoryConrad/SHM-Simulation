import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ph1140_project/format.dart';

class SpringWidget extends StatefulWidget {
  @override
  _SpringWidgetState createState() => _SpringWidgetState();
}

class _SpringWidgetState extends State<SpringWidget>
    with SingleTickerProviderStateMixin {
  // Animation is used to get a rebuild every frame
  AnimationController _controller;
  Stopwatch _stopwatch = Stopwatch();

  int springConstant = 1, mass = 1, amplitude = 100;

  double get angularFrequency => sqrt(springConstant / mass);

  double get frequency => angularFrequency / (2 * pi);

  double get period => 1 / frequency;

  double get displacement =>
      amplitude * cos(angularFrequency * _stopwatch.elapsedMilliseconds / 1000);

  // Use pow with third root as that is the relationship between
  //   mass and one side length of the cube
  double get cubeLength => 50 + 5 * pow(mass, 1 / 3);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)
      ..repeat(period: Duration(seconds: 1));
    _stopwatch.start();
  }

  @override
  void dispose() {
    _controller.dispose();
    _stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // todo equations
      Expanded(
        child: AnimatedBuilder(
          animation: _controller,
          child: Container(
            width: cubeLength,
            height: cubeLength,
            color: Colors.green,
            child: Center(child: Text('$mass kg')),
          ),
          builder: (context, child) => Column(children: [
            Container(
              height: MediaQuery.of(context).size.height / 2 -
                  cubeLength / 2 +
                  displacement,
              width: max(3, springConstant / 4),
              color: Colors.white,
            ),
            child,
          ]),
        ),
      ),
      Text('Oscillating at ${frequency.format()} Hz '
          'with a period of ${period.format()} s'),
      Card(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.only(left: 16),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 200,
                child: Text('Spring Constant ($springConstant N/m)'),
              ),
              Expanded(
                child: Slider(
                  value: springConstant.toDouble(),
                  min: 1,
                  max: 100,
                  onChanged: (k) => setState(() {
                    springConstant = k.round();
                    _stopwatch.reset();
                  }),
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 200,
                child: Text('Mass ($mass kg)'),
              ),
              Expanded(
                child: Slider(
                  value: mass.toDouble(),
                  min: 1,
                  max: 100,
                  onChanged: (m) => setState(() {
                    mass = m.round();
                    _stopwatch.reset();
                  }),
                ),
              ),
            ]),
          ]),
        ),
      ),
    ]);
  }
}
