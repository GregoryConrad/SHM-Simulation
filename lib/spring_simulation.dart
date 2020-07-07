import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ph1140_project/format.dart';

class SpringWidget extends StatefulWidget {
  @override
  _SpringWidgetState createState() => _SpringWidgetState();
}

class _SpringWidgetState extends State<SpringWidget> {
  int springConstant = 1, mass = 1;

  double get angularFrequency => sqrt(springConstant / mass);

  double get frequency => angularFrequency / (2 * pi);

  double get period => 1 / frequency;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // todo equations
      Expanded(
        // todo preview
        child: Container(),
      ),
      Text('Oscillating at ${frequency.format()} Hz '
          'with a period of ${period.format()} s'),
      Card(
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: 200,
              child: Text('Spring Constant ($springConstant N/m)'),
            ),
            Slider(
              value: springConstant.toDouble(),
              min: 1,
              max: 1000,
              onChanged: (k) => setState(() => springConstant = k.round()),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: 200,
              child: Text('Mass ($mass kg)'),
            ),
            Slider(
              value: mass.toDouble(),
              min: 1,
              max: 1000,
              onChanged: (m) => setState(() => mass = m.round()),
            ),
          ]),
        ]),
      ),
    ]);
  }
}
