abstract class CellStrings {
  String get noConnection;

  String get pleaseWait;
}

class DefaultCellStrings extends CellStrings {
  String get noConnection => 'no connection';

  String get pleaseWait => 'please wait';
}
