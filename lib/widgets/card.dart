import 'package:flutter/material.dart';
import 'package:pokergame/models/models.dart';

import 'package:pokergame/theme.dart';

class CardWidget extends StatelessWidget {
  final int rank;
  final Suit suit;
  final Function onPressed;
  final bool isVisible;
  final bool isHighlighted;

  const CardWidget({
    @required this.rank,
    @required this.suit,
    @required this.onPressed,
    this.isVisible = false,
    this.isHighlighted = false
  });

  @override
  Widget build(BuildContext context) {
    var suitIcon;
    var suitIconStyle = appTheme.cardSuitBlack;
    switch (this.suit){
      case Suit.hearts:
        suitIcon = '\u2665';
        suitIconStyle = appTheme.cardSuitRed;
        break;
      case Suit.diamonds:
        suitIcon = '\u2666';
        suitIconStyle = appTheme.cardSuitRed;
        break;
      case Suit.clubs:
        suitIcon = '\u2663';
        break;
      default:
        suitIcon = '\u2660';
    }
    return Card(
      margin: const EdgeInsets.all(5),
      shape: isHighlighted ? RoundedRectangleBorder(
        side: BorderSide(color: appTheme.primaryGreen, width: 2),
        borderRadius: BorderRadius.circular(4)
      ) : RoundedRectangleBorder(
        side: BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(4)
      ),
      child: GestureDetector(
        onTap: () {
          this.onPressed();
        },
        child: Container(
          width: 60,
          height: 90,
          color: this.isVisible ? Colors.white : Colors.black38,
          padding: const EdgeInsets.all(5),
          child: this.isVisible ? Column(
            children: <Widget>[
              Text(
                this.rank.toString(),
                style: appTheme.cardRank,
              ),
              Text(
                suitIcon,
                style: suitIconStyle
              ),
            ],
          ) : null,
        )
      )
    );
  }
}
