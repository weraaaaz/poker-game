import 'package:flutter/foundation.dart';

@immutable
class CardModel {
  final int rank;
  final Suit suit;

  CardModel({ this.rank, this.suit });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['rank'] = this.rank;
    data['suit'] = this.suit;
    return data;
  }
}

enum Suit {
  spades,
  hearts,
  diamonds,
  clubs
}