import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ph1140_project/format.dart';

class SpringWidget extends StatefulWidget {
  @override
  _SpringWidgetState createState() => _SpringWidgetState();
}

class _SpringWidgetState extends State<SpringWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  double springConstant = 1, mass = 1, amplitude = 1;

  double get angularFrequency => sqrt(springConstant / mass);

  double get frequency => angularFrequency / (2 * pi);

  double get period => 1 / frequency;

  double get displacement =>
      100 * amplitude * cos(angularFrequency * _controller.value * period);

  // Use pow with third root as that is the relationship between
  //   mass and one side length of the cube
  double get cubeLength => 50 + 5 * pow(mass, 1 / 3);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _resetAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _resetAnimation() {
    // For .repeat, Duration only allows int params so use a smaller size
    //  to keep precision
    _controller.repeat(
      period: Duration(microseconds: (period * 1000000).toInt()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.topCenter, children: [
      // todo equations
      LayoutBuilder(builder: (context, size) {
        return AnimatedBuilder(
          animation: _controller,
          child: Container(
            width: cubeLength,
            height: cubeLength,
            color: Colors.green,
            child: Center(child: Text('${mass.round()} kg')),
          ),
          builder: (context, child) =>
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(width: 150),
            Expanded(
              child: Column(children: [
                Container(
                  height: size.maxHeight / 2 - cubeLength / 2 + displacement,
                  width: max(3, springConstant / 4),
                  color: Colors.white,
                ),
                child,
              ]),
            ),
            Container(
              width: 150,
              height: size.maxHeight / 2,
              color: Colors.grey,
            ),
          ]),
        );
      }),
      Column(children: [
        Expanded(child: Container()),
        Text('Oscillating at ${frequency.format()} Hz '
            'with a period of ${period.format()} s'),
        Card(
          margin: EdgeInsets.all(8),
          child: Padding(
            padding: EdgeInsets.only(left: 16),
            child: Column(children: [
              _createSliderValue('Spring Constant (\$ N/m)', springConstant, 1,
                  150, (v) => springConstant = v),
              _createSliderValue('Mass (\$ kg)', mass, 1, 100, (v) => mass = v),
              _createSliderValue(
                  'Amplitude (\$ m)', amplitude, 0.25, 2, (v) => amplitude = v),
            ]),
          ),
        ),
      ]),
    ]);
  }

  Widget _createSliderValue(String label, double value, double min, double max,
      Function(double) onChanged) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 200,
        child: Text(label.replaceAll(r'$', value.format())),
      ),
      Expanded(
        child: Slider(
          value: value,
          min: min,
          max: max,
          onChanged: (v) {
            setState(() {
              onChanged(v);
              _resetAnimation();
            });
          },
        ),
      ),
    ]);
  }
}
