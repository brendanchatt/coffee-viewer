import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/saved_coffees_notifier.dart';
import 'cached_coffee_network_image.dart';

class SavedCoffeesTab extends ConsumerWidget {
  const SavedCoffeesTab({super.key});
  static const noSavedText =
      'You haven\'t saved any coffees yet.\nGo play on the swipe screen. :)';

  @override
  Widget build(BuildContext context, ref) {
    final savedCoffees = ref.watch(savedCoffeesProvider);
    // Don't use a builder constructor here.  There are only a few images
    return savedCoffees != null
        ? GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 5,
            children: savedCoffees
                .map(
                  (url) => Card(child: CachedCoffeeNetworkImage(url)),
                )
                .toList(),
          )
        : const Center(
            child: Text(SavedCoffeesTab.noSavedText),
          );
  }
}
