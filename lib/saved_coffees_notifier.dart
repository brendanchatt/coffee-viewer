import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

final savedCoffeesProvider =
    AsyncNotifierProvider<SavedCoffeesNotifier, List<String>?>(
        () => SavedCoffeesNotifier());

class SavedCoffeesNotifier extends AsyncNotifier<List<String>?> {
  final stringListName = 'savedCoffees';

  @override
  FutureOr<List<String>?> build() async {
    return ref.read(sharedPreferencesProvider).getStringList(stringListName);
  }

  saveCoffee(String url) {
    final newList = state.value == null ? [url] : [...state.value!, url];

    state = AsyncData(newList);
    ref.read(sharedPreferencesProvider).setStringList(stringListName, newList);
  }
}
