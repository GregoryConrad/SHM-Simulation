import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ph1140_project/simulation_base.dart';

class SimplePendulumWidget extends StatefulWidget {
  @override
  _SimplePendulumWidgetState createState() => _SimplePendulumWidgetState();
}

class _SimplePendulumWidgetState
    extends SimulationBaseState<SimplePendulumWidget> {
  double g = 9.81, length = 1, maxAngle = 0.1, mass = 1;

  double get angularFrequency => sqrt(g / length);

  double get period => 2 * pi / angularFrequency;

  double get angularDisplacement =>
      maxAngle * cos(angularFrequency * controller.value * period);

  double get totalEnergy => mass * g * length * (1 - cos(maxAngle));

  double get potentialEnergy =>
      mass * g * length * (1 - cos(angularDisplacement));

  double get kineticEnergy => totalEnergy - potentialEnergy;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, children: [
      AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final swingLength = length * MediaQuery.of(context).size.height / 5;
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            createEnergyBar('Kinetic Energy\n(\$ J)', kineticEnergy),
            Expanded(
              child: Transform.rotate(
                angle: angularDisplacement,
                origin: Offset(0, -swingLength),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(width: 2, height: swingLength, color: Colors.white),
                  Container(
                    width: cubeLength - 30,
                    height: cubeLength - 30,
                    color: Colors.green,
                    child: Center(child: Text('${mass.round()}')),
                  ),
                ]),
              ),
            ),
            createEnergyBar('Potential Energy\n(\$ J)', potentialEnergy),
          ]);
        },
      ),
      Column(children: [
        Expanded(child: Container()),
        Text('Swinging with a period of ${period.format()} s'
            'and a total energy of ${totalEnergy.format()} J'),
        Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(children: [
                createSliderValue(
                    'Gravitational Field (\$ m/s²)', g, 1, 50, (v) => g = v),
                createSliderValue(
                    'Length (\$ m)', length, 0.25, 3, (v) => length = v),
                createSliderValue(
                    'Mass (\$ kg)', mass, 1, 100, (v) => mass = v),
                // .349 rads is the largest angle allowed for small angle approx
                createSliderValue('Angular Amplitude (\$ rads)', maxAngle, 0.03,
                    0.349, (v) => maxAngle = v),
              ]),
            )),
      ]),
    ]);
  }
}
