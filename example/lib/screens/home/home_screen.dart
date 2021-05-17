import 'package:flutter_cell/flutter_cell.dart';
import 'package:example/screens/data/models/user.dart';
import 'package:flutter/material.dart';

import 'home_cell.dart';

class HomeScreen extends Screen<HomeCell> {
  @override
  void initialize(cube) {
    cube.init();
  }

  @override
  Widget buildScreen(BuildContext context, cube) {
    Widget body;

    if (cube.isIdle) {
      if (cube.users.isEmpty) {
        body = Center(child: Text('no users have registered yet'));
      } else {
        body = _createUsersList(cube.users);
      }
    } else {
      body = cube.toWidget();
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
