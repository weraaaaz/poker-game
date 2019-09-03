import 'package:pokergame/models/models.dart';
import 'package:redux/redux.dart';

import '../store.dart';

class StartGame {
}

class DealCards {
  final int numberOfCards;

  DealCards(
    this.numberOfCards
  );
}

class ChangePlayer {

}

class RemoveFromPlayerHand {
  final List<CardModel> cards;

  RemoveFromPlayerHand(
    this.cards
  );
}

class ToggleSelectCard {
  final CardModel card;

  ToggleSelectCard(
    this.card
  );
}

class ChooseWinner {

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

replaceCards(List<CardModel> cards) {
  return (Store<AppState> store) {
    store.dispatch(RemoveFromPlayerHand(cards));
    store.dispatch(DealCards(cards.length));
    store.dispatch(ChangePlayer());
  };
}