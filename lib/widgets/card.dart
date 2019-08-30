import 'package:flutter/material.dart';
import 'package:pokergame/models/models.dart';

import 'package:pokergame/theme.dart';

class CardWidget extends StatelessWidget {
  CardWidget({
    @required this.rank,
    @required this.suit,
    @required this.isVisible
  });

  final int rank;
  final Suit suit;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Text(
            this.rank.toString(),
            style: appTheme.cardRank
          ),
        ],
      )
    );
  }
}
