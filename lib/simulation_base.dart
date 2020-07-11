import 'package:flutter/material.dart';
import 'package:ph1140_project/format.dart';
export 'package:ph1140_project/format.dart';

abstract class SimulationBaseState<T extends StatefulWidget> extends State<T>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  double get period;

  void resetAnimation() {
    // For .repeat, Duration only allows int params so use a smaller size
    //  to keep precision
    controller.repeat(
      period: Duration(microseconds: (period * 1000000).toInt()),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
    resetAnimation();
  }

  @override
  void dispose() {
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
}
