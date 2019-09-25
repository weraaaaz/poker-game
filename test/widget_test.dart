// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:pokergame/main.dart';
import 'package:pokergame/models/models.dart';
import 'package:pokergame/store.dart';
import 'package:redux/redux.dart';

void main() {
  testWidgets('Starts game', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final Store<AppState> store = getStore();
    await tester.pumpWidget(MyApp(store));

    final newGameButtonFinder = find.text('New game');
    // Verify that there is button 'New game'
    expect(newGameButtonFinder, findsOneWidget);
    expect(find.text('Winner'), findsNothing);

    // Tap the 'New game' button and trigger a frame.
    await tester.tap(newGameButtonFinder);
    await tester.pump();

    // await tester.pumpWidget(GamePage());
    // // Verify that there is no button 'New game'
    // expect(newGameButtonFinder, findsNothing);
    // final showCardsButtonFinder = find.text('Show cards');
    // // Verify that there is button 'Show cards'
    // expect(showCardsButtonFinder, findsOneWidget);
    // // Verify that there is Player 1 text, not Player 2
    // expect(find.text('Player 1'), findsOneWidget);
    // expect(find.text('Player 2'), findsNothing);
  });
}
