import 'dart:math';

import 'package:pokergame/actions/actions.dart';
import 'package:pokergame/models/models.dart';

import '../store.dart';

AppState rootReducer(AppState state, action){
  if (action is StartGame) {
    return startGame(state);
  }
  if (action is DealCards) {
    return dealCards(state, action);
  }
  if (action is ChangePlayer) {
    return changePlayer(state);
  }
  if (action is RemoveFromPlayerHand) {
    return removeFromPlayerHand(state, action);
  }
  if (action is ChooseWinner) {
    return chooseWinner(state);
  }
  if (action is ToggleSelectCard) {
    return toggleSelectCard(state, action);
  }
  return state;
//  try {
//    print('state');
//    return action.reducer(state);
//  } catch(e){
//    print('Error: $e');
//    return state;
//  }
}

AppState startGame(AppState state) {
  return state.copyWith(
    deck: DeckModel.initial(),
    player1: Player(hand: Hand(), isCurrentPlayer: true, name: "Player 1"),
    player2: Player(hand: Hand(), isCurrentPlayer: false, name: "Player 2"),
    currentPlayer: state.player1,
    cardsToSwap: List<CardModel>(),
  );
}

AppState dealCards(AppState state, DealCards action) {
  var currentPlayer = state.player1.isCurrentPlayer ? state.player1 : state.player2;
  var currentPlayerCards = List<CardModel>.from(currentPlayer.hand.cards);
  var deck = state.deck;
  var randomizer = Random();
  for (var i = 0; i < action.numberOfCards; i++) {
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

AppState changePlayer(AppState state) {
  var player1 = state.player1;
  var player2 = state.player2;
  return state.copyWith(
    player1: Player(hand: player1.hand, isCurrentPlayer: !player1.isCurrentPlayer, name: player1.name),
    player2: Player(hand: player2.hand, isCurrentPlayer: !player2.isCurrentPlayer, name: player2.name),
  );
}

AppState toggleSelectCard(AppState state, ToggleSelectCard action) {
  var cardsToSwap = state.cardsToSwap;
  if (cardsToSwap.contains(action.card)) {
    cardsToSwap.remove(action.card);
  } else cardsToSwap.add(action.card);
  return state.copyWith(
    cardsToSwap: cardsToSwap
  );
}

AppState removeFromPlayerHand(AppState state, RemoveFromPlayerHand action) {
  var currentPlayer = state.player1.isCurrentPlayer ? state.player1 : state.player2;
  currentPlayer.hand.cards.removeWhere((card) => action.cards.contains(card));
  return state.copyWith(
    player1: state.player1,
    player2: state.player2,
  );
}

AppState chooseWinner(AppState state) {
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