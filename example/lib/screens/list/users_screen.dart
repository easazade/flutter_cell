import 'package:flutter_cell/flutter_cell.dart';
import 'package:example/screens/data/models/user.dart';
import 'package:flutter/material.dart';

import 'users_cell.dart';

class UsersScreen extends Screen<UsersCell> {
  @override
  void initialize(cell) {
    cell.init();
  }

  @override
  Widget buildScreen(BuildContext context, cell) {
    Widget body;

    if (cell.isIdle) {
      if (cell.users.isEmpty) {
        body = Center(child: Text('no users have registered yet'));
      } else {
        body = _createUsersList(cell.users);
      }
    } else {
      body = cell.toWidget();
    }

    return Scaffold(
      appBar: AppBar(title: Text('home')),
      body: body,
    );
  }

  Widget _createUsersList(List<User> users) {
    return ListView(
      children: [
        for (var user in users)
          ListTile(
            title: Text(user.name),
            leading: Text(user.id.toString()),
            trailing: Text('${user.credit} \$'),
          )
      ],
    );
  }
}
