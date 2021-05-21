abstract class CellLogger {
  void log(anything);

  void footprint(anything);

  void report(error, stacktrace);
}

class DefaultCellLogger extends CellLogger {
  @override
  void footprint(anything) {
    print(anything.toString());
  }

  @override
  void log(anything) {
    print(anything.toString());
  }

  @override
  void report(error, stacktrace) {
    print(error.toString());
    print(stacktrace.toString());
  }
}
