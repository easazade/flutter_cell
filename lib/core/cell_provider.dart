import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CellProvider extends StatelessWidget {
  final Widget child;

  const CellProvider({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: child);
  }
}
