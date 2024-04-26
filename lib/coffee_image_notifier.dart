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
    return await _getImageUrl();
  }

  Future<String?> _getImageUrl() =>
      dio.get('https://coffee.alexflipnote.dev/random.json').then(
            (response) => response.data != null
                ? (response.data as Map<String, dynamic>)['file']
                : null,
          );

  Future<void> setNewImage() async => state = AsyncData(await _getImageUrl());
}
