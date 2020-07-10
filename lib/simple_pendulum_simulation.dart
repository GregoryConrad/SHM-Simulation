import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ph1140_project/simulation_base.dart';

class SimplePendulumWidget extends StatefulWidget {
  @override
  _SimplePendulumWidgetState createState() => _SimplePendulumWidgetState();
}

class _SimplePendulumWidgetState extends SimulationBaseState<SimplePendulumWidget> {
  double g, length;

  double get angularFrequency => sqrt(g / length);

  double get period => 2 * pi / angularFrequency;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
