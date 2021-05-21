import 'package:flutter_cell/flutter_cell.dart';
import 'package:example/screens/data/datasource.dart';
import 'package:example/screens/data/models/models.dart';

class UsersCell extends Cell {
  List<User> users = [];

  Future init() async {
    progress();
    users = await DataSource.getUsers();
    needsConnection(retry: () => init());
    await 1.seconds();
    update();
  }
}
