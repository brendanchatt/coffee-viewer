import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_viewer/UI/cached_coffee_network_image.dart';
import 'package:coffee_viewer/state/coffee_image_notifier.dart';
import 'package:coffee_viewer/state/saved_coffees_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipable_stack/swipable_stack.dart';

class CoffeeSwipeTab extends ConsumerStatefulWidget {
  const CoffeeSwipeTab({super.key});
  static const problemText = 'Something went wrong :/';

  @override
  ConsumerState<CoffeeSwipeTab> createState() => _CoffeeSwipeTabState();
}

class _CoffeeSwipeTabState extends ConsumerState<CoffeeSwipeTab> {
  @override
  Widget build(BuildContext context) {
    final coffee = ref.watch(coffeeImagesProvider);

    return switch (coffee) {
      AsyncData() => coffee.value == null
          ? problemTextWidget
          : Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 1.5,
                  child: SwipableStack(
                    swipeAnchor: SwipeAnchor.bottom,
                    itemCount: 1,
                    builder: (context, swipeProperty) {
                      return Center(
                        child: Card(
                            child: CachedCoffeeNetworkImage(
                          coffee.value!,
                          indicateLoading: true,
                        )),
                      );
                    },
                    onSwipeCompleted: (_, SwipeDirection direction) async {
                      direction == SwipeDirection.right
                          ? ref
                              .read(savedCoffeesProvider.notifier)
                              .saveCoffee(coffee.value!)
                          : CachedNetworkImage.evictFromCache(coffee.value!);

                      await ref
                          .read(coffeeImagesProvider.notifier)
                          .setNewImage();

                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: 25),
                // You could also make these icons and texts detect gesture
                //  Use the swipable stack controller to do so
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.arrow_circle_left,
                      color: Colors.red,
                    ),
                    Text('Ditch', style: TextStyle(color: Colors.red)),
                    Text('Swipe',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Keep', style: TextStyle(color: Colors.green)),
                    Icon(Icons.arrow_circle_right, color: Colors.green),
                  ],
                )
              ],
            ),
      AsyncLoading() => Container(
          alignment: Alignment.center,
          height: 50,
          width: 50,
          child: const CircularProgressIndicator()),
      _ => problemTextWidget,
    };
  }

  final problemTextWidget =
      const Center(child: Text(CoffeeSwipeTab.problemText));
}