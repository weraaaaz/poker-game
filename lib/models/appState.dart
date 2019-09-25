import 'package:flutter/material.dart';

import 'package:pokergame/models/models.dart';

@immutable
class AppState {
  final DeckModel deck;
  final Player player1;
  final Player player2;
  final Player winner;
  final Player currentPlayer;
  final List<CardModel> cardsToSwap;

  AppState({
    this.deck,
    this.player1,
    this.player2,
    this.winner,
    this.currentPlayer,
    this.cardsToSwap
  });

  AppState copyWith({
    DeckModel deck,
    Player player1,
    Player player2,
    Player winner,
    Player currentPlayer,
    List<CardModel> cardsToSwap
  }) {
    return AppState(
      deck: deck ?? this.deck,
      player1: player1 ?? this.player1,
      player2: player2 ?? this.player2,
      winner: winner ?? this.winner,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      cardsToSwap: cardsToSwap ?? this.cardsToSwap
    );
  }
}