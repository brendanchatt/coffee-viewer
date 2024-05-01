import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final coffeeImagesProvider =
    AsyncNotifierProvider<CoffeeImageNotifier, String?>(
        () => CoffeeImageNotifier());

class CoffeeImageNotifier extends AsyncNotifier<String?> {
  final dio = Dio();

  @override
  FutureOr<String?> build() async {
    return await getImageUrl();
  }

  // If this were more than one statement, I would put it in a service
  Future<String?> getImageUrl() =>
      dio.get('https://coffee.alexflipnote.dev/random.json').then(
            (response) => response.data != null
                ? (response.data as Map<String, dynamic>)['file']
                : null,
          );

  Future<void> setNewImage() async => state = AsyncData(await getImageUrl());
}
