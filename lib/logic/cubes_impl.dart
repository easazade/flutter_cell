import 'package:flutter_cell/logic/base_cube.dart';
import 'package:flutter_cell/logic/cube_state.dart';

abstract class SingletonCube extends BaseCube {
  SingletonCube([CubeState state = CubeState.STARTED]) : super(state);

  @override
  void dispose() {
    super.dispose();
  }
}

abstract class Cube extends BaseCube {
  Cube([CubeState state = CubeState.STARTED]) : super(state);
}
