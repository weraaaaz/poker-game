import 'package:flutter/material.dart';
import 'dart:math';

import 'card.dart';

@immutable
class Hand {
  final List<CardModel> cards;

  const Hand({ this.cards = const [] }); 

  Hand copyWith({
    List<CardModel> cards
  }) {
    return Hand(
      cards: cards ?? this.cards
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cards != null) {
      data['cards'] = this.cards.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String toString() => this.toJson().toString();

  List<int> _getRanks() {
    return this.cards.map((card) => card.rank).toList();
  }

  List<int> _getRepeatedRanks(List<int> ranks) {
    var repeatedRanks = ranks.toList();
    ranks.toSet().forEach((rank) => repeatedRanks.remove(rank));
    return repeatedRanks;
  }

  HandName getHandScoreName() {
    var repeatedRanks = _getRepeatedRanks(_getRanks());
    if (repeatedRanks.length > 0) {
      if (repeatedRanks.length == 1) {
        return HandName.pair;
      }
      if (repeatedRanks.length == 2) {
        if (repeatedRanks.toSet().length == repeatedRanks.length) {
          return HandName.twoPairs;
        } else return HandName.threeOfAKind;
      }
      if (repeatedRanks.length == 3) {
        if (repeatedRanks.toSet().length == 1) {
          return HandName.fourOfAKind;
        } else return HandName.fullHouse;
      }
    }
    if (this.cards.map((card) => card.suit).toList().toSet().length == 1 && this.cards.every((card) => card.rank >= 10)) {
      return HandName.poker;
    }
    return HandName.none;
  }

  int getRepeatedRanksMaxIndex() {
    var repeatedRanks = _getRepeatedRanks(_getRanks());
    if (repeatedRanks.length > 0) {
      if (getHandScoreName() != HandName.fullHouse) {
        return repeatedRanks.reduce(max);
      } else return repeatedRanks[0];
    }
    return 0;
  }
}

enum HandName {
  none,
  pair,
  twoPairs,
  threeOfAKind,
  fourOfAKind,
  fullHouse,
  poker
}
