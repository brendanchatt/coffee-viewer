import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_viewer/coffee_image_notifier.dart';
import 'package:coffee_viewer/saved_coffees_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipable_stack/swipable_stack.dart';

class CoffeeSwipeTab extends ConsumerStatefulWidget {
  const CoffeeSwipeTab({super.key});

  @override
  ConsumerState<CoffeeSwipeTab> createState() => _CoffeeSwipeTabState();
}

class _CoffeeSwipeTabState extends ConsumerState<CoffeeSwipeTab> {
  @override
  Widget build(BuildContext context) {
    final coffee = ref.read(coffeeImagesProvider);

    return switch (coffee) {
      AsyncData() => coffee.value == null
          ? problemTextWidget
          : SwipableStack(
              itemCount: 1,
              builder: (context, swipeProperty) {
                return Card(
                  child: CachedNetworkImage(imageUrl: coffee.value!),
                );
              },
              onSwipeCompleted: (_, SwipeDirection direction) async {
                direction == SwipeDirection.right
                    ? ref
                        .read(savedCoffeesProvider.notifier)
                        .saveCoffee(coffee.value!)
                    : CachedNetworkImage.evictFromCache(coffee.value!);
                await ref.read(coffeeImagesProvider.notifier).setNewImage();
                setState(() {});
              },
            ),
      AsyncLoading() => const SizedBox(
          height: 100, width: 100, child: CircularProgressIndicator()),
      _ => problemTextWidget,
    };
  }

  final problemTextWidget =
      const Center(child: Text('Something went wrong :/'));
}
