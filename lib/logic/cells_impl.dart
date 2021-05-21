import 'package:flutter_cell/logic/base_cell.dart';
import 'package:flutter_cell/logic/cell_state.dart';

abstract class SingletonCell extends BaseCell {
  SingletonCell([CellState state = CellState.STARTED]) : super(state);

  @override
  void dispose() {
    super.dispose();
  }
}

abstract class Cell extends BaseCell {
  Cell([CellState state = CellState.STARTED]) : super(state);
}
