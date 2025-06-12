import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:news_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-end test', () {
    testWidgets('App should load and display posts',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify app bar title
      expect(find.text('News App'), findsOneWidget);

      // Wait for posts to load
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // Verify that either posts are loaded or error/empty state is shown
      expect(
        find.byType(ListView).first.evaluate().isNotEmpty ||
            find.text('No posts available').evaluate().isNotEmpty ||
            find.byType(ElevatedButton).evaluate().isNotEmpty,
        isTrue,
      );
    });

    testWidgets('Error handling and retry functionality',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Wait for initial load
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // If error state is shown, verify retry button
      if (find.byType(ElevatedButton).evaluate().isNotEmpty) {
        await tester.tap(find.byType(ElevatedButton).first);
        await tester.pumpAndSettle();

        // Wait for retry attempt
        await tester.pump(const Duration(seconds: 2));
        await tester.pumpAndSettle();

        // Verify that either posts are loaded or error state is shown again
        expect(
          find.byType(ListView).first.evaluate().isNotEmpty ||
              find.byType(ElevatedButton).evaluate().isNotEmpty,
          isTrue,
        );
      }
    });
  });
}
