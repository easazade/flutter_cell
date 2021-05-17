import 'dart:async';

abstract class ArcConnectivity {
  ArcConnectivity(Stream<ConnectionStatus> connectionChanges) {
    connectionChanges.listen((event) => _connectionChanges.add(event));
  }

  StreamController<ConnectionStatus> _connectionChanges = StreamController.broadcast();

  Stream<ConnectionStatus> get watch => _connectionChanges.stream;

  Future<bool> hasConnection();
}

enum ConnectionStatus { WIFI, MOBILE, NONE }
