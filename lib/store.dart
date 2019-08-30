import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'models/models.dart';
import 'reducers/rootReducer.dart';

@immutable
class AppState {
  final DeckModel deck;
  final Player player1;
  final Player player2;
  final Player winner;

  AppState({
    this.deck,
    this.player1,
    this.player2,
    this.winner,
  });

  //factory AppState.initial() => AppState(deck: DeckModel.initial(), player1: Player(hand: Hand.initial(), isCurrentPlayer: true), player2: Player.initial());

  AppState copyWith({
    DeckModel deck,
    Player player1,
    Player player2,
    Player winner,
  }) {
    return AppState(
      deck: deck ?? this.deck,
      player1: player1 ?? this.player1,
      player2: player2 ?? this.player2,
      winner: winner ?? this.winner
    );
  }
}

Store<AppState> getStore() {
  return Store<AppState>(
    rootReducer,
    initialState: AppState(),
  );
}