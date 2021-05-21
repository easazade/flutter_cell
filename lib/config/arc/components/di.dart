import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class CellProviders {
  ChangeNotifierProvider<T> getCellProvider<T extends ChangeNotifier>();
}

class DefaultCellProviders extends CellProviders {
  ChangeNotifierProvider<T> getCellProvider<T extends ChangeNotifier>() {
    throw Exception(
        'you need to add configure ArcProviders in ArchitectureConfig in order to provide Screens with Cubes');
  }
}
