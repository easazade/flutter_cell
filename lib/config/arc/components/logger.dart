abstract class ArcLogger {
  void log(anything);

  void footprint(anything);

  void report(error, stacktrace);
}

class DefaultLogger extends ArcLogger {
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
