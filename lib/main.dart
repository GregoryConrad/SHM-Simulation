import 'package:flutter/material.dart';
import 'package:ph1140_project/simple_pendulum_simulation.dart';
import 'package:ph1140_project/spring_simulation.dart';
import 'package:rxdart/rxdart.dart';

final stateStream = BehaviorSubject.seeded(true);

void main() {
  runApp(MaterialApp(
    title: 'PH1140 Project',
    theme: ThemeData(
      primarySwatch: Colors.lightGreen,
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: StreamBuilder<bool>(
        stream: stateStream,
        builder: (context, snapshot) {
          final isLarge = MediaQuery.of(context).size.width > 800;
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text('Simple Harmonic Oscillators'),
                actions: [
                  if (snapshot.data)
                    IconButton(
                        icon: Icon(Icons.pause),
                        onPressed: () => stateStream.add(false))
                  else
                    IconButton(
                        icon: Icon(Icons.play_arrow),
                        onPressed: () => stateStream.add(true))
                ],
                bottom: isLarge
                    ? null
                    : TabBar(tabs: [
                        Tab(text: 'Spring'),
                        Tab(text: 'Pendulum'),
                      ]),
              ),
              body: isLarge
                  ? Row(children: [
                      Expanded(child: SpringWidget()),
                      VerticalDivider(thickness: 2),
                      Expanded(child: SimplePendulumWidget()),
                    ])
                  : TabBarView(children: [
                      SpringWidget(),
                      SimplePendulumWidget(),
                    ]),
            ),
          );
        }),
  ));
}
