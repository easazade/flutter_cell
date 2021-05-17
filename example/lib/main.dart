import 'package:flutter_cell/architecture.dart';
import 'package:flutter_cell/config/config.dart';
import 'package:flutter_cell/core/cube_provider.dart';
import 'package:example/screens/cell/config/cell_config.dart';
import 'package:example/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  Architecture.instance.config = ArchitectureConfig(providers: MyProviders());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExampleApp(),
    );
  }
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CubeProvider(
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
