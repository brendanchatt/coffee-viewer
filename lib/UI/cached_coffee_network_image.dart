import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedCoffeeNetworkImage extends StatelessWidget {
  const CachedCoffeeNetworkImage(this.coffeeUrl, {super.key});
  final String coffeeUrl;
  static const noCoffeeText = 'coffee not found';

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: coffeeUrl,
      progressIndicatorBuilder: (_, __, ___) => Container(
        alignment: Alignment.center,
        width: 30,
        height: 30,
        child: const CircularProgressIndicator(),
      ),
      errorWidget: (_, __, ___) => const Center(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Text(CachedCoffeeNetworkImage.noCoffeeText),
        ),
      ),
    );
  }
}
