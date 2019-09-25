import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:pokergame/actions/actions.dart';
import 'package:pokergame/models/appState.dart';
import 'package:pokergame/theme.dart';
import 'package:pokergame/widgets/card.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool areCardsVisible = false;
  bool canSwapCards = true;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
      converter: (store) => store,
      builder: (context, store) {
        AppState state = store.state;
        Function dispatch = store.dispatch;
        var currentPlayer = state.player1.isCurrentPlayer ? state.player1 : state.player2;
        var currentCards = currentPlayer.hand.cards;
        var cardsToSwap = state.cardsToSwap;
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  currentPlayer.name,
                  style: appTheme.cardSuitRed,
                ),
                Column(
                  children: currentCards.map<Widget>((card) {
                    return CardWidget(
                      rank: card.rank,
                      suit: card.suit,
                      onPressed: areCardsVisible && canSwapCards ? () {
                        dispatch(ToggleSelectCard(card));
                      } : () {},
                      isVisible: areCardsVisible,
                      isHighlighted: cardsToSwap.contains(card)
                    );
                  }).toList()
                ),
                if (!areCardsVisible) RaisedButton(
                  onPressed: () {
                    setState(() {
                      areCardsVisible = true;
                    });
                  },
                  padding: const EdgeInsets.all(10.0),
                  color: appTheme.primaryGreen,
                  child: Text(
                    !areCardsVisible ? 'Show cards' : '',
                    style: TextStyle(
                      fontSize: 20,
                      color: appTheme.white,
                    )
                  ),
                ),
                if (areCardsVisible && canSwapCards) RaisedButton(
                  onPressed: () {
                    replaceCards(store, cardsToSwap);
                    setState(() {
                      canSwapCards = false;
                    });
                  },
                  padding: const EdgeInsets.all(10.0),
                  color: appTheme.primaryGreen,
                  child: Text(
                    'Replace selected cards',
                    style: TextStyle(
                      fontSize: 20,
                      color: appTheme.white,
                    )
                  ),
                ),
                if (areCardsVisible && !canSwapCards) RaisedButton(
                  onPressed: state.player1.isCurrentPlayer ? () {
                    dispatch(ChangePlayer());
                    setState(() {
                      canSwapCards = true;
                      areCardsVisible = false;
                    });
                  } : () {
                    dispatch(ChooseWinner());
                    Navigator.pop(context);
                  },
                  padding: const EdgeInsets.all(10.0),
                  color: appTheme.primaryGreen,
                  child: Text(
                    state.player1.isCurrentPlayer ? 'Change player' : 'End game',
                    style: TextStyle(
                      fontSize: 20,
                      color: appTheme.white,
                    )
                  ),
                ),
              ]
            ),
          ),
        );
      }
    );
  }
}