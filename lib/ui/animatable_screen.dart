import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_cell/architecture.dart';
import 'package:flutter_cell/logic/base_cell.dart';
import 'package:flutter_cell/logic/cells_impl.dart';

/// Screen is StatefulWidget that has a cell instance and uses manages the lifecycle of
/// that cell behind the scene.
/// Screen also provides user with the lifecycle methods to initialize the page and also define a widgetTree for
/// the page
///
/// Screen uses provider package approach to get an instance of the cell
abstract class AnimatableScreen<T extends BaseCell> extends StatefulWidget {
  @override
  _AnimatableScreenState createState() => _AnimatableScreenState<T>();

  ///callback called when initializing page
  void initialize(T cell, TickerProvider tickerProvider);

  ///callback methods called each time page is rebuilding
  Widget widgetTree(
    BuildContext context,
    T cell,
  );
}

class _AnimatableScreenState<T extends BaseCell>
    extends State<AnimatableScreen<T>> with TickerProviderStateMixin {
  ChangeNotifierProvider<T>? _provider;
  T? cellInstance;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      if (_provider == null) {
        _provider = Architecture.instance.providers.getCellProvider<T>();
        cellInstance = watch(_provider!);
        // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        widget.initialize(cellInstance!, this);
        // });
      } else {
        cellInstance = watch(_provider!);
      }
      cellInstance!.displayMessage(context);
      return widget.widgetTree(context, cellInstance!);
    });
  }

  @override
  void dispose() {
    if (cellInstance is! SingletonCell) {
      cellInstance?.dispose();
    }
    super.dispose();
  }
}
