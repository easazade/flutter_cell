abstract class ArcStrings {
  String get noConnection;

  String get pleaseWait;
}

class DefaultStrings extends ArcStrings {
  String get noConnection => 'no connection';

  String get pleaseWait => 'please wait';
}
