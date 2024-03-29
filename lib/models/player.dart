import 'package:flutter/foundation.dart';

import 'hand.dart';
import 'models.dart';

@immutable
class Player {
  final Hand hand;
  final bool isCurrentPlayer;
  final String name;

  Player({
    this.hand = const Hand(),
    this.isCurrentPlayer = false,
    this.name = '',
  });

   Player copyWith({
    Hand hand,
    bool isCurrentPlayer,
    String name
  }) {
    return Player(
      hand: hand ?? this.hand,
      isCurrentPlayer: isCurrentPlayer ?? this.isCurrentPlayer,
      name: name ?? this.name
    );
  }
}

