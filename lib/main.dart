import 'package:flutter/material.dart';
import 'package:ph1140_project/simple_pendulum_simulation.dart';
import 'package:ph1140_project/spring_simulation.dart';

void main() {
  runApp(MaterialApp(
    title: 'PH1140 Project',
    theme: ThemeData(
      primarySwatch: Colors.lightGreen,
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: Builder(builder: (context) {
      final isLarge = MediaQuery.of(context).size.width > 1000;
      return Scaffold(
        appBar: AppBar(
          title: Text('Simple Harmonic Oscillators'),
        ),
        body: isLarge
            ? Row(children: [
                Expanded(child: SpringWidget()),
                VerticalDivider(thickness: 2),
                Expanded(child: SimplePendulumWidget()),
              ])
            : SpringWidget(),
      );
    }),
  ));
}
