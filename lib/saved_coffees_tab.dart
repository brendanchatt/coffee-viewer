import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_viewer/saved_coffees_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedCoffeesTab extends ConsumerWidget {
  const SavedCoffeesTab({super.key});

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
                  (url) => CachedNetworkImage(imageUrl: url),
                )
                .toList(),
          )
        : const Center(
            child: Text(
                'You haven\'t saved any coffees yet.\nGo play on the swipe screen. :)'),
          );
  }
}
