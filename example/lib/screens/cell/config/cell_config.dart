import 'package:example/screens/list/users_cell.dart';
import 'package:flutter_cell/flutter_cell.dart';
import 'package:flutter_riverpod/src/change_notifier_provider.dart';
import 'package:flutter/src/foundation/change_notifier.dart';

class MyProviders extends CellProviders {
  @override
  ChangeNotifierProvider<T> getCellProvider<T extends ChangeNotifier>() {
    if (typeOf<UsersCell>().runtimeType == T.runtimeType) {
      return ChangeNotifierProvider<UsersCell>((_) => UsersCell())
          as ChangeNotifierProvider<T>;
    } else {
      throw Exception('Unknown cell type $T');
    }
  }

  Type typeOf<T>() => T;
}
