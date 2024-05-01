import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedCoffeeNetworkImage extends StatelessWidget {
  const CachedCoffeeNetworkImage(this.coffeeUrl,
      {this.indicateLoading = false, super.key});
  final String coffeeUrl;
  final bool indicateLoading;
  static const noCoffeeText = 'coffee not found';

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: coffeeUrl,
      progressIndicatorBuilder: (_, __, progress) => Container(
        alignment: Alignment.center,
        width: 30,
        height: 30,
        child: const CircularProgressIndicator(),
      ),
      errorWidget: (_, __, ___) => _coffeeNotFound,
    );
  }

  final _coffeeNotFound = const Padding(
    padding: EdgeInsets.all(25.0),
    child: Text(CachedCoffeeNetworkImage.noCoffeeText),
  );
}
