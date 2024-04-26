import 'package:flutter/material.dart';

import 'coffee_swipe_tab.dart';
import 'saved_coffees_tab.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: [
              Icon(Icons.swipe),
              Icon(Icons.history),
            ]),
          ),
          body: const TabBarView(
            children: [
              CoffeeSwipeTab(),
              SavedCoffeesTab(),
            ],
          )),
    );
  }
}
