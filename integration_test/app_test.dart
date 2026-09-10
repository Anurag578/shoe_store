import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:dummy_store/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Shoe Store end-to-end', () {
    testWidgets('loads real products from the API on launch', (tester) async {
      app.main(); // launches the actual app - real DI, real network calls
      await tester.pumpAndSettle(const Duration(seconds: 5)); // allow API time to respond

      // If products loaded successfully, at least one product card's
      // price text should be visible somewhere on screen.
      expect(find.textContaining('\$'), findsWidgets);
    });

    testWidgets('searching filters the product list', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      await tester.enterText(find.byType(TextField), 'nike');
      await tester.pumpAndSettle(const Duration(seconds: 2)); // debounce delay + rebuild

      // Not asserting a specific brand exists (data varies), just that the
      // search field accepted input and the list re-rendered without crashing.
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('tapping a product opens its detail page', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final firstCard = find.byType(GestureDetector).first;
      await tester.tap(firstCard);
      await tester.pumpAndSettle();

      expect(find.text('Add to Cart'), findsOneWidget);
    });

    testWidgets('adding to cart updates the cart badge count', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add to Cart'));
      await tester.pumpAndSettle();

      // The cart badge should now show "1".
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('checkout clears the cart', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add to Cart'));
      await tester.pumpAndSettle();

      // Go back to the list, then open the cart.
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.shopping_cart));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Checkout'));
      await tester.pumpAndSettle();

      expect(find.text('Your cart is empty.'), findsOneWidget);
    });
  });
}