import 'package:flutter_test/flutter_test.dart';
import 'package:pokergame/actions/actions.dart';
import 'package:pokergame/models/models.dart';
import 'package:pokergame/store.dart';
import 'package:redux/redux.dart';

main() {
  group('test redux', () {
    final Store<AppState> store = getStore();
    test('should set initial state', () {
      startGame(store);
      // checks if deck has 52 cards
      expect(store.state.deck.cards.length, 52);
      // check if has 4 suits and 13 of one suit
      // checks if deck has unique cards [check card on specific index]
      // expect(store.state.deck.cards.toSet().toList(), store.state.deck.cards);
      expect(store.state.player1.hand.cards.length, 0);
      expect(store.state.player2.hand.cards.length, 0);
      // currentPlayer in main state
      expect(store.state.player1.isCurrentPlayer, isTrue);
      expect(store.state.player2.isCurrentPlayer, isFalse);
    });
    test('should deal 5 cards for each player', () {
      startGame(store);
      store.dispatch(DealCards(5));
      store.dispatch(ChangePlayer());
      store.dispatch(DealCards(5));
      store.dispatch(ChangePlayer());
      expect(store.state.player1.hand.cards.length, 5);
      expect(store.state.player2.hand.cards.length, 5);
      expect(store.state.deck.cards.length, 42);
      //checks if deck doesn't have cards that players have
      expect(store.state.player1.hand.cards.every((card) => !store.state.deck.cards.contains(card)), isTrue);
      expect(store.state.player2.hand.cards.every((card) => !store.state.deck.cards.contains(card)), isTrue);
      expect(store.state.player1.isCurrentPlayer, isTrue);
      expect(store.state.player2.isCurrentPlayer, isFalse);
    });
    test('should replace player1 all 5 cards and player2 0 cards', () {
      startGame(store);
      store.dispatch(DealCards(5));
      store.dispatch(ChangePlayer());
      store.dispatch(DealCards(5));
      store.dispatch(ChangePlayer());
      List<CardModel> previousCardsPlayer1 = store.state.player1.hand.cards;  
      List<CardModel> previousCardsPlayer2 = store.state.player2.hand.cards;  
      store.dispatch(RemoveFromPlayerHand(store.state.player1.hand.cards));
      expect(store.state.player1.hand.cards.length, 0);
      store.dispatch(DealCards(5));
      expect(store.state.player1.hand.cards.length, 5);
      store.dispatch(ChangePlayer());
      expect(store.state.deck.cards.length, 37);
      store.dispatch(RemoveFromPlayerHand([]));
      expect(store.state.player2.hand.cards.length, 5);
      store.dispatch(DealCards(0));
      expect(store.state.player2.hand.cards.length, 5);
      store.dispatch(ChangePlayer());             
      // checks if player1 has all new cards
      expect(previousCardsPlayer1.every((card) => !store.state.player1.hand.cards.contains(card)), isTrue);
      // checks if player2 has the same cards as before
      expect(previousCardsPlayer2.every((card) => store.state.player2.hand.cards.contains(card)), isTrue);
      expect(store.state.deck.cards.length, 37);
    });
    test('should calculate hands score', () {
      var player1 = Player(hand: Hand(
        cards: [
          CardModel(rank: 2, suit: Suit.clubs),
          CardModel(rank: 2, suit: Suit.spades),
          CardModel(rank: 2, suit: Suit.hearts),
          CardModel(rank: 4, suit: Suit.clubs),
          CardModel(rank: 5, suit: Suit.clubs),
        ],
      ));
      var player2 = Player(hand: Hand(
        cards: [
          CardModel(rank: 3, suit: Suit.clubs),
          CardModel(rank: 3, suit: Suit.spades),
          CardModel(rank: 3, suit: Suit.hearts),
          CardModel(rank: 4, suit: Suit.hearts),
          CardModel(rank: 5, suit: Suit.hearts),
        ],
      ));
      expect(player1.hand.getHandScore() == 3, isTrue);
      expect(player1.hand.getRepeatedRanksMaxIndex() == 2, isTrue);
      expect(player2.hand.getHandScore() == 3, isTrue);
      expect(player2.hand.getRepeatedRanksMaxIndex() == 3, isTrue);
      player1 = Player(hand: Hand(
        cards: [
          CardModel(rank: 2, suit: Suit.clubs),
          CardModel(rank: 2, suit: Suit.spades),
          CardModel(rank: 2, suit: Suit.hearts),
          CardModel(rank: 2, suit: Suit.diamonds),
          CardModel(rank: 3, suit: Suit.clubs),
        ],
      ));
      player2 = Player(hand: Hand(
        cards: [
          CardModel(rank: 3, suit: Suit.clubs),
          CardModel(rank: 7, suit: Suit.clubs),
          CardModel(rank: 2, suit: Suit.clubs),
          CardModel(rank: 4, suit: Suit.clubs),
          CardModel(rank: 5, suit: Suit.clubs),
        ],
      ));
      expect(player1.hand.getHandScore() == 4, isTrue);
      expect(player1.hand.getRepeatedRanksMaxIndex() == 2, isTrue);
      expect(player2.hand.getHandScore() == 0, isTrue);
      player1 = Player(hand: Hand(
        cards: [
          CardModel(rank: 2, suit: Suit.clubs),
          CardModel(rank: 2, suit: Suit.spades),
          CardModel(rank: 13, suit: Suit.clubs),
          CardModel(rank: 2, suit: Suit.hearts),
          CardModel(rank: 13, suit: Suit.hearts),
        ],
      ));
      expect(player1.hand.getHandScore() == 5, isTrue);
      expect(player1.hand.getRepeatedRanksMaxIndex() == 2, isTrue);
      player1 = Player(hand: Hand(
        cards: [
          CardModel(rank: 10, suit: Suit.clubs),
          CardModel(rank: 12, suit: Suit.clubs),
          CardModel(rank: 13, suit: Suit.clubs),
          CardModel(rank: 11, suit: Suit.clubs),
          CardModel(rank: 14, suit: Suit.clubs),
        ],
      ));
      expect(player1.hand.getHandScore() == 6, isTrue);
      player1 = Player(hand: Hand(
        cards: [
          CardModel(rank: 12, suit: Suit.clubs),
          CardModel(rank: 9, suit: Suit.clubs),
          CardModel(rank: 14, suit: Suit.clubs),
          CardModel(rank: 12, suit: Suit.spades),
          CardModel(rank: 3, suit: Suit.clubs),
        ],
      ));
      expect(player1.hand.getHandScore() == 1, isTrue);
      expect(player1.hand.getRepeatedRanksMaxIndex() == 12, isTrue);
      player1 = Player(hand: Hand(
        cards: [
          CardModel(rank: 12, suit: Suit.clubs),
          CardModel(rank: 11, suit: Suit.spades),
          CardModel(rank: 2, suit: Suit.clubs),
          CardModel(rank: 11, suit: Suit.clubs),
          CardModel(rank: 12, suit: Suit.hearts),
        ],
      ));
      expect(player1.hand.getHandScore() == 2, isTrue);
      expect(player1.hand.getRepeatedRanksMaxIndex() == 12, isTrue);
      startGame(store);
      store.dispatch(DealCards(5));
      store.dispatch(ChangePlayer());
      store.dispatch(DealCards(5));
      store.dispatch(ChangePlayer());
      store.dispatch(ChooseWinner());
      print(store.state.player1.hand.getHandScore());
      print(store.state.player2.hand.getHandScore());
      print(store.state.winner == store.state.player1);
    });
  });
}