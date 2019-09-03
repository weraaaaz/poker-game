import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'screens/game.dart';
import 'screens/start.dart';
import 'store.dart';

void main() {
  final Store<AppState> store = getStore();
  runApp(MyApp(store));
  //startGame(store);
}

class MyApp extends StatelessWidget {
  final Store<AppState> store; 
  MyApp(this.store);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Poker game',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => StartPage(),
          '/game': (context) => GamePage(),
        },
      )
    );
  }
}
