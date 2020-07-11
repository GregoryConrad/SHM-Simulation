import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ph1140_project/simulation_base.dart';

class SimplePendulumWidget extends StatefulWidget {
  @override
  _SimplePendulumWidgetState createState() => _SimplePendulumWidgetState();
}

class _SimplePendulumWidgetState
    extends SimulationBaseState<SimplePendulumWidget> {
  double g = 9.8, length = 1;

  double get angularFrequency => sqrt(g / length);

  double get period => 2 * pi / angularFrequency;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AnimatedBuilder(
        animation: controller,
        builder: (context, child) => Placeholder(),
      ),
      Column(children: [
        Expanded(child: Container()),
        Text('Swinging with a period of ${period.format()} s'),
        Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(children: [
                createSliderValue(
                    'Gravitational Field (\$ m/s²)', g, 1, 20, (v) => g = v),
                createSliderValue(
                    'Length (\$ m)', length, 0.5, 2, (v) => length = v),
              ]),
            )),
      ]),
    ]);
  }
}
