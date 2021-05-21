import 'package:example/screens/list/users_cell.dart';
import 'package:example/screens/list/users_screen.dart';
import 'package:flutter_cell/flutter_cell.dart';
import 'package:example/screens/data/models/user.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('home')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              child: Text('Users Screen'),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => UsersScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
