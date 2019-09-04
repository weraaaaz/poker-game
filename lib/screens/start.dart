import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pokergame/widgets/card.dart';

import '../store.dart';
import '../theme.dart';
import '../actions/actions.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
      converter: (store) => store,
      builder: (context, store) {
        AppState state = store.state;
        var winner = state.winner;
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (winner != null) Column(
                  children: <Widget>[
                    Text(
                      '${state.player1.name} - ${state.player1.hand.getHandScoreName().toString().split('.')[1]}'
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: store.state.player1.hand.cards.map<Widget>((card) {
                        return CardWidget(
                          rank: card.rank,
                          suit: card.suit,
                          onPressed: () {},
                          isVisible: true,
                        );
                      }).toList()
                    ),
                    Text(
                      '${state.player2.name} - ${state.player2.hand.getHandScoreName().toString().split('.')[1]}'
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: store.state.player2.hand.cards.map<Widget>((card) {
                        return CardWidget(
                          rank: card.rank,
                          suit: card.suit,
                          onPressed: () {},
                          isVisible: true,
                        );
                      }).toList()
                    ),
                    Text(
                      'Winner is ${winner.name}'
                    ),
                  ]
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      "/game",
                    );
                    startGame(store);
                    dealInitialCards(store);
                  },
                  padding: const EdgeInsets.all(10.0),
                  color: appTheme.primaryGreen,
                  child: Text(
                    'New game',
                    style: TextStyle(
                      fontSize: 20,
                      color: appTheme.white,
                    )
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}