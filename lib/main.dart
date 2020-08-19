import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'route_generator.dart';
import './landing.dart';
import 'service_locator.dart';

void main() {
  try {
    DotEnv().load('.env').then((value) => print("dotenv success"));
  } catch (error) {
    print("error ${error}");
  }

  setupLocator();
  runApp(new RootWidget());
}

class RootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/landing',
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: Landing(),
        onGenerateRoute: RouteGenerator.generateRoute);
    // Scaffold(
    // appBar: AppBar(title: Text('Easy List')), body: ProductManager()));
  }
}
