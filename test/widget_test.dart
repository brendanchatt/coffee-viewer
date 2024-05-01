import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:coffee_viewer/state/coffee_image_notifier.dart';
import 'package:coffee_viewer/UI/coffee_swipe_tab.dart';
import 'package:coffee_viewer/UI/saved_coffees_tab.dart';
import 'package:coffee_viewer/main.dart';

const fileUrl = 'test.com/cappuccino';

class MockCoffeeNotifier extends CoffeeImageNotifier {
  @override
  Future<String?> getImageUrl() async {
    return fileUrl;
  }
}

void main() async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();

  final ps = ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
    ],
    child: const CoffeeViewer(),
  );

  group('swipe tab', () {
    testWidgets('no internet problem widget', (WidgetTester tester) async {
      await tester.pumpWidget(ps);
      await tester.pumpAndSettle();

      expect(find.text(CoffeeSwipeTab.problemText), findsOneWidget);
    });

    testWidgets('cached network image widget found',
        (WidgetTester tester) async {
      ps.overrides
          .add(coffeeImagesProvider.overrideWith(() => MockCoffeeNotifier()));

      await tester.pumpWidget(ps);

      await tester.pump();

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });
  });

  testWidgets('saved coffees tab - none saved', (tester) async {
    await tester.pumpWidget(ps);
    await tester.tap(find.byIcon(Icons.history));
    await tester.pumpAndSettle();

    expect(find.text(SavedCoffeesTab.noSavedText), findsOneWidget);
  });
}
