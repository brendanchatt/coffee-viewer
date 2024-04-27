import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';

final savedCoffeesProvider =
    NotifierProvider<SavedCoffeesNotifier, List<String>?>(
        () => SavedCoffeesNotifier());

class SavedCoffeesNotifier extends Notifier<List<String>?> {
  final stringListName = 'savedCoffees';

  @override
  List<String>? build() {
    return ref.read(sharedPreferencesProvider).getStringList(stringListName);
  }

  saveCoffee(String url) {
    final newList = state == null ? [url] : [...state!, url];

    state = newList;
    ref.read(sharedPreferencesProvider).setStringList(stringListName, newList);
  }
}
