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
    home: MainPage(),
  ));
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isPlaying = true;

  @override
  Widget build(BuildContext context) {
    final isLarge = MediaQuery.of(context).size.width > 800;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Simple Harmonic Oscillators'),
          actions: [
            // todo use rxdart and behavior subject to take care of this state
            if (isPlaying)
              IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: () => setState(() => isPlaying = false))
            else
              IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () => setState(() => isPlaying = true))
          ],
          bottom: isLarge
              ? null
              : TabBar(tabs: [Tab(text: 'Spring'), Tab(text: 'Pendulum')]),
        ),
        body: isLarge
            ? Row(children: [
                Expanded(child: SpringWidget()),
                VerticalDivider(thickness: 2),
                Expanded(child: SimplePendulumWidget()),
              ])
            : TabBarView(children: [SpringWidget(), SimplePendulumWidget()]),
      ),
    );
  }
}
