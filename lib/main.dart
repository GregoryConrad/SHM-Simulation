import 'package:flutter/material.dart';
import 'package:ph1140_project/spring_simulation.dart';

void main() {
  runApp(MaterialApp(
    title: 'PH1140 Project',
    theme: ThemeData(
      primarySwatch: Colors.lightGreen,
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text('Simple Harmonic Oscillators'),
      ),
      body: SpringWidget(),
    ),
  ));
}
