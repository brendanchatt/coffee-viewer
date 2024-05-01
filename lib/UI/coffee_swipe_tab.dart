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

class _CoffeeSwipeTabState extends ConsumerState<CoffeeSwipeTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final coffee = ref.watch(coffeeImagesProvider);

    return switch (coffee) {
      AsyncData() => coffee.value == null
          ? problemTextWidget
          : Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 1.5,
                  // There are otherwise issues with animations, I think due to single item count.
                  //  Having a key solves this.  It's a fine workaround given this is not
                  //  A super realistic use case.  Normally, you would have an API to get
                  //  several items at once.
                  //  This package works fine with multiple items.
                  key: Key(coffee.value!),
                  child: SwipableStack(
                    swipeAnchor: SwipeAnchor.bottom,
                    itemCount: 1,
                    builder: (context, swipeProperty) {
                      return Center(
                        child: Card(
                            child: CachedCoffeeNetworkImage(coffee.value!)),
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

  @override
  bool get wantKeepAlive => true;
}
