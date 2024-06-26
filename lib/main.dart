import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UI/main_screen.dart';

// Riverpod convention for warming up async initalized sync consumed items, like shared prefs
// I know VGV uses bloc, so see: https://riverpod.dev/docs/concepts/scopes#initialization-of-synchronous-provider-for-async-apis
final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
    ],
    child: const CoffeeViewer(),
  ));
}

class CoffeeViewer extends StatelessWidget {
  const CoffeeViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Viewer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
