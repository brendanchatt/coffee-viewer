import 'package:coffee_viewer/main.dart';
import 'package:coffee_viewer/state/saved_coffees_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('saved coffees notifier state', () {
    test('no saved coffees yields null provider state', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      final container = ProviderContainer(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      );

      expect(container.read(savedCoffeesProvider), null);
    });

    test('coffees saved yields non empty list provider state', () async {
      SharedPreferences.setMockInitialValues({
        SavedCoffeesNotifier.stringListName: [
          'test.com/pic',
          'test.com/image',
          'test.com/yes'
        ]
      });
      final prefs = await SharedPreferences.getInstance();

      final container = ProviderContainer(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      );

      final state = container.read(savedCoffeesProvider);

      expect(state, isList);
      expect(state, isNotEmpty);
    });
  });
}
