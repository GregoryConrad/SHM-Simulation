import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ph1140_project/format.dart';
import 'package:ph1140_project/main.dart';
export 'package:ph1140_project/format.dart';

abstract class SimulationBaseState<T extends StatefulWidget> extends State<T>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  StreamSubscription<ApplicationState> _subscription;

  double get period;

  double get mass;

  double get totalEnergy;

  // Use pow with third root as that is the relationship between
  //   mass and one side length of the cube
  double get cubeLength => 50 + 5 * pow(mass, 1 / 3);

  void resetAnimation() {
    final state = stateStream.value;
    if (state.isPlaying) {
      // For .repeat, Duration only allows int params so use a smaller size
      //  to keep precision
      controller.repeat(
        period: Duration(microseconds: period * 1000000 ~/ state.speed),
      );
    } else {
      controller.stop();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
    // BehaviorSubject emits last value for new subscribers, so this
    //  will be called automatically for us
    _subscription = stateStream.listen((_) => resetAnimation());
  }

  @override
  void dispose() {
    _subscription.cancel();
    controller.dispose();
    super.dispose();
  }

  /// Creates a Slider widget with a label. The $ character is replaced with an
  ///  appropriate user facing value
  Widget createSliderValue(String label, double value, double min, double max,
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
              resetAnimation();
            });
          },
        ),
      ),
    ]);
  }

  Widget createEnergyBar(String label, double energy) {
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
          height: MediaQuery.of(context).size.height / 2 * energy / totalEnergy,
          color: Colors.grey,
        ),
      ]),
    );
  }
}
