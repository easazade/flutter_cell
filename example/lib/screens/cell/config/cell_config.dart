import 'package:flutter_cell/flutter_cell.dart';
import 'package:example/screens/home/home_cell.dart';
import 'package:flutter_riverpod/src/change_notifier_provider.dart';
import 'package:flutter/src/foundation/change_notifier.dart';

class MyProviders extends ArcProviders {
  @override
  ChangeNotifierProvider<T> getCubeProvider<T extends ChangeNotifier>() {
    Type typeOf<T>() => T;
    if (typeOf<HomeCell>().runtimeType == T.runtimeType) {
      return ChangeNotifierProvider<HomeCell>((_) => HomeCell())
          as ChangeNotifierProvider<T>;
    } else {
      throw Exception('Unknown cube type $T');
    }
  }
}
