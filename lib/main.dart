import 'package:flutter/material.dart';
import 'package:ph1140_project/simple_pendulum_simulation.dart';
import 'package:ph1140_project/spring_simulation.dart';
import 'package:rxdart/rxdart.dart';

class ApplicationState {
  final bool isPlaying;
  final double speed;

  ApplicationState.initial()
      : isPlaying = true,
        speed = 1;

  ApplicationState._from(this.isPlaying, this.speed);

  ApplicationState copyWithPlaying() => ApplicationState._from(true, speed);

  ApplicationState copyWithPaused() => ApplicationState._from(false, speed);

  ApplicationState copyWithIncreasedSpeed() =>
      speed >= 2.00 ? this : ApplicationState._from(isPlaying, speed + 0.05);

  ApplicationState copyWithDecreasedSpeed() =>
      speed <= 0.05 ? this : ApplicationState._from(isPlaying, speed - 0.05);
}

final stateStream = BehaviorSubject.seeded(ApplicationState.initial());

void main() {
  runApp(MaterialApp(
    title: 'PH1140 Project',
    theme: ThemeData(
      primarySwatch: Colors.lightGreen,
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: StreamBuilder<ApplicationState>(
        initialData: stateStream.value,
        stream: stateStream,
        builder: (context, snapshot) {
          final state = snapshot.data;
          final width = MediaQuery.of(context).size.width;
          final isLarge = width > 800;
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  width > 600 ? 'Simple Harmonic Oscillators' : 'Oscillators',
                ),
                actions: [
                  FlatButton(
                    child: Text('-'),
                    onPressed: () =>
                        stateStream.add(state.copyWithDecreasedSpeed()),
                  ),
                  Center(child: Text('Speed: ${(state.speed * 100).round()}%')),
                  FlatButton(
                    child: Text('+'),
                    onPressed: () =>
                        stateStream.add(state.copyWithIncreasedSpeed()),
                  ),
                  if (state.isPlaying)
                    IconButton(
                      icon: Icon(Icons.pause),
                      onPressed: () => stateStream.add(state.copyWithPaused()),
                    )
                  else
                    IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () => stateStream.add(state.copyWithPlaying()),
                    )
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
