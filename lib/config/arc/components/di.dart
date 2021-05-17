import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ArcProviders {
  ChangeNotifierProvider<T> getCubeProvider<T extends ChangeNotifier>();
}

class DefaultProviders extends ArcProviders {
  ChangeNotifierProvider<T> getCubeProvider<T extends ChangeNotifier>() {
    throw Exception('you need to add configure ArcProviders in ArchitectureConfig in order to provide Screens with Cubes');
  }
}
