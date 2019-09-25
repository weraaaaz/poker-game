import 'dart:math';
import 'package:redux/redux.dart';

import 'package:pokergame/models/models.dart';

class StartGame {

  reducer(AppState state) {
    return state.copyWith(
      deck: DeckModel().initial(),
      player1: Player(hand: Hand(), isCurrentPlayer: true, name: "Player 1"),
      player2: Player(hand: Hand(), isCurrentPlayer: false, name: "Player 2"),
      currentPlayer: state.player1,
      cardsToSwap: List<CardModel>(),
    );
  }
}

class DealCards {
  final int numberOfCards;

  DealCards(
    this.numberOfCards
  );

  reducer(AppState state) {
    var currentPlayer = state.player1.isCurrentPlayer ? state.player1 : state.player2;
    var currentPlayerCards = List<CardModel>.from(currentPlayer.hand.cards);
    var deck = state.deck;
    var randomizer = Random();
    for (var i = 0; i < numberOfCards; i++) {
      var cardIndex = randomizer.nextInt(deck.cards.length);
      currentPlayerCards.add(deck.cards[cardIndex]);
      deck.cards.removeAt(cardIndex);
    }
    return state.copyWith(
      deck: deck,
      player1: currentPlayer == state.player1 ? Player(hand: Hand(cards: currentPlayerCards), isCurrentPlayer: state.player1.isCurrentPlayer, name: state.player1.name) : state.player1,
      player2: currentPlayer == state.player2 ? Player(hand: Hand(cards: currentPlayerCards), isCurrentPlayer: state.player2.isCurrentPlayer, name: state.player2.name) : state.player2,
      cardsToSwap: List<CardModel>(),
    );
  }
}

class ChangePlayer {

 reducer(AppState state) {
   return state.copyWith(
    player1: state.player1.copyWith(isCurrentPlayer: !state.player1.isCurrentPlayer),
    player2: state.player2.copyWith(isCurrentPlayer: !state.player2.isCurrentPlayer),
  );
 }
}

class RemoveFromPlayerHand {
  final List<CardModel> cards;

  RemoveFromPlayerHand(
    this.cards
  );

  reducer(AppState state) {
    var currentPlayer = state.player1.isCurrentPlayer ? state.player1 : state.player2;
    currentPlayer.hand.cards.removeWhere((card) => cards.contains(card));
    return state.copyWith(
      player1: state.player1,
      player2: state.player2,
    );
  }
}

class ToggleSelectCard {
  final CardModel card;

  ToggleSelectCard(
    this.card
  );

  reducer(AppState state) {
    var cardsToSwap = state.cardsToSwap;
    if (cardsToSwap.contains(card)) {
      cardsToSwap.remove(card);
    } else cardsToSwap.add(card);
    return state.copyWith(
      cardsToSwap: cardsToSwap
    );
  }
}

class ChooseWinner {

  reducer(AppState state) {
    var player1ScoreName = state.player1.hand.getHandScoreName();
    var player2ScoreName = state.player2.hand.getHandScoreName();
    var winner;
    if (player1ScoreName!= player2ScoreName) {
      winner = player1ScoreName.index > player2ScoreName.index ? state.player1 : state.player2;
    } else {
      winner = state.player1.hand.getRepeatedRanksMaxIndex() > state.player2.hand.getRepeatedRanksMaxIndex() ? state.player1 : state.player2;
    }
    return state.copyWith(
      winner: winner,
    );
  }
}

startGame(Store<AppState> store) {
  store.dispatch(StartGame());
}

dealInitialCards(Store<AppState> store) {
  store.dispatch(DealCards(5));
  store.dispatch(ChangePlayer());
  store.dispatch(DealCards(5));
  store.dispatch(ChangePlayer());
}

replaceCards(Store<AppState> store, List<CardModel> cards) {
  store.dispatch(RemoveFromPlayerHand(cards));
  store.dispatch(DealCards(cards.length));
}
