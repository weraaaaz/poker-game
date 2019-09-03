import 'package:flutter/material.dart';
import 'dart:math';

import 'card.dart';

@immutable
class Hand {
  final List<CardModel> cards;

  const Hand({ this.cards = const [] }); 

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cards != null) {
      data['cards'] = this.cards.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String toString() => this.toJson().toString();

  List<int> _getRanks() {
    var ranks = List<int>();
    this.cards.forEach((card) => ranks.add(card.rank));
    return ranks;
  }
  
  List<Suit> _getSuits() {
    var suits = List<Suit>();
    this.cards.forEach((card) => suits.add(card.suit));
    return suits;
  }

  bool _isPoker() {
    return _getSuits().toSet().length == 1 && this.cards.every((card) => card.rank >= 10 && card.rank <= 14);
  }

  bool _hasRepeatedElements() {
    return _getRanks().toSet().length != 5;
  }

  List<int> _getRepeatedRanks(List<int> ranks) {
    var repeatedRanks = ranks;
    ranks.toSet().forEach((rank) => repeatedRanks.remove(rank));
    return repeatedRanks;
  }

  HandName getHandScoreName() {
    if (_hasRepeatedElements()) {
      var repeatedRanks = _getRepeatedRanks(_getRanks());
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
    if (_isPoker()) {
      return HandName.poker;
    }
    return HandName.none;
  }

  int getRepeatedRanksMaxIndex() {
    if (_hasRepeatedElements()) {
      if (getHandScoreName() != HandName.fullHouse) {
        return _getRepeatedRanks(_getRanks()).reduce(max);
      } else return _getRepeatedRanks(_getRanks())[0];
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
