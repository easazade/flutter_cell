import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_cell/architecture.dart';
import 'package:flutter_cell/logic/base_cube.dart';
import 'package:flutter_cell/logic/cubes_impl.dart';

/// Screen is StatefulWidget that has a cube instance and uses manages the lifecycle of
/// that cube behind the scene.
/// Screen also provides user with the lifecycle methods to initialize the page and also define a widgetTree for
/// the page
///
/// Screen uses provider package approach to get an instance of the cube
abstract class AnimatableScreen<T extends BaseCube> extends StatefulWidget {
  @override
  _AnimatableScreenState createState() => _AnimatableScreenState<T>();

  ///callback called when initializing page
  void initialize(T cube, TickerProvider tickerProvider);

  ///callback methods called each time page is rebuilding
  Widget widgetTree(
    BuildContext context,
    T cube,
  );
}

class _AnimatableScreenState<T extends BaseCube> extends State<AnimatableScreen<T>> with TickerProviderStateMixin {
  ChangeNotifierProvider<T>? _provider;
  T? cubeInstance;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      if (_provider == null) {
        _provider = Architecture.instance.providers.getCubeProvider<T>();
        cubeInstance = watch(_provider!);
        // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        widget.initialize(cubeInstance!, this);
        // });
      } else {
        cubeInstance = watch(_provider!);
      }
      cubeInstance!.displayMessage(context);
      return widget.widgetTree(context, cubeInstance!);
    });
  }

  @override
  void dispose() {
    if (cubeInstance is! SingletonCube) {
      cubeInstance?.dispose();
    }
    super.dispose();
  }
}
