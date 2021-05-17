import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_cell/architecture.dart';
import 'package:flutter_cell/logic/base_cube.dart';
import 'package:flutter_cell/logic/cubes_impl.dart';

/// Screen is StatefulWidget that has a cube instance and manages the lifecycle of
/// that page behind the scene.
/// Screen also provides user with the lifecycle methods to initialize the page and also define a widgetTree for
/// the page
///
/// Screen uses provider package approach to get an instance of the cube
abstract class Screen<T extends BaseCube> extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState<T>();

  ///callback called when initializing page
  void initialize(T cube);

  ///callback methods called each time page is rebuilding
  Widget buildScreen(BuildContext context, T cube);
}

class _ScreenState<T extends BaseCube> extends State<Screen<T>> {
  ChangeNotifierProvider<T>? _provider;
  T? cubeInstance;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      if (_provider == null) {
        _provider = Architecture.instance.providers.getCubeProvider<T>();
        cubeInstance = watch(_provider!);
        // WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        widget.initialize(cubeInstance!);
        // });
      } else {
        cubeInstance = watch(_provider!);
      }
      cubeInstance!.displayMessage(context);
      return widget.buildScreen(context, cubeInstance!);
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
