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
            toolbarHeight: 25,
            bottom: const TabBar(
              padding: EdgeInsets.all(5),
              tabs: [
                Tab(icon: Icon(Icons.swipe)),
                Tab(icon: Icon(Icons.history)),
              ],
            ),
          ),
          body: const TabBarView(
            // To not interfere with swipe
            //  An enhancement would be to disable or make rigid only when index is on swipe tab
            //  For this, remove Default and create own tab controller.
            physics: NeverScrollableScrollPhysics(),
            children: [
              CoffeeSwipeTab(),
              SavedCoffeesTab(),
            ],
          )),
    );
  }
}
