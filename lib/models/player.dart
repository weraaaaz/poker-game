import 'package:flutter/foundation.dart';

import 'hand.dart';
import 'models.dart';

@immutable
class Player {
  final Hand hand;
  final bool isCurrentPlayer;

  Player({
    this.hand = const Hand(),
    this.isCurrentPlayer = false
  });

  // set currentPlayer(bool isCurrentPlayer) {
  //   this.isCurrentPlayer = isCurrentPlayer;
  // }

}

