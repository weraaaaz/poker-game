import 'package:flutter/foundation.dart';

import 'card.dart';

@immutable
class DeckModel {
  final List<CardModel> cards;

  DeckModel({ this.cards });

  factory DeckModel.initial() {
    final List<CardModel> cards = [];
    for (int rank = 2; rank <= 14; rank++) {
      Suit.values.forEach(
        (suit) => cards.add(CardModel(rank: rank, suit: suit))
      );
    }
    return DeckModel(cards: cards);
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cards'] = this.cards;
    return data;
  }

  String toString() => this.toJson().toString();
}

