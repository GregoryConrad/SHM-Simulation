import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ph1140_project/simulation_base.dart';

class SpringWidget extends StatefulWidget {
  @override
  _SpringWidgetState createState() => _SpringWidgetState();
}

class _SpringWidgetState extends SimulationBaseState<SpringWidget> {
  double springConstant = 1, mass = 1, amplitude = 1;

  double get angularFrequency => sqrt(springConstant / mass);

  double get frequency => angularFrequency / (2 * pi);

  double get period => 1 / frequency;

  double get displacement =>
      amplitude * cos(angularFrequency * controller.value * period);

  double get totalEnergy => 0.5 * springConstant * pow(amplitude, 2);

  double get potentialEnergy => 0.5 * springConstant * pow(displacement, 2);

  double get kineticEnergy => totalEnergy - potentialEnergy;

  // Use pow with third root as that is the relationship between
  //   mass and one side length of the cube
  double get cubeLength => 50 + 5 * pow(mass, 1 / 3);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, children: [
      LayoutBuilder(builder: (context, size) {
        return AnimatedBuilder(
          animation: controller,
          child: Container(
            width: cubeLength,
            height: cubeLength,
            color: Colors.green,
            child: Center(child: Text('${mass.round()} kg')),
          ),
          builder: (context, child) =>
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _createEnergyBar(
                'Kinetic Energy\n(\$ J)', kineticEnergy, size.maxHeight),
            Expanded(
              child: Column(children: [
                Container(
                  height:
                      size.maxHeight / 2 - cubeLength / 2 + 100 * displacement,
                  width: max(3, springConstant / 4),
                  color: Colors.white,
                ),
                child,
              ]),
            ),
            _createEnergyBar(
                'Potential Energy\n(\$ J)', potentialEnergy, size.maxHeight),
          ]),
        );
      }),
      Column(children: [
        Expanded(child: Container()),
        Text('Oscillating at ${frequency.format()} Hz '
            'with a period of ${period.format()} s '
            'and a total energy of ${totalEnergy.format()} J'),
        Card(
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(children: [
              createSliderValue('Spring Constant (\$ N/m)', springConstant, 1,
                  150, (v) => springConstant = v),
              createSliderValue('Mass (\$ kg)', mass, 1, 100, (v) => mass = v),
              createSliderValue(
                  'Amplitude (\$ m)', amplitude, 0.25, 2, (v) => amplitude = v),
            ]),
          ),
        ),
      ]),
    ]);
  }

  Widget _createEnergyBar(String label, double energy, double maxHeight) {
    return Container(
      width: 128,
      child: Column(children: [
        SizedBox(height: 4),
        Text(
          label.replaceAll(r'$', energy.format()),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4),
        Container(
          width: 50,
          height: maxHeight / 2 * energy / totalEnergy,
          color: Colors.grey,
        ),
      ]),
    );
  }
}
