import 'package:flutter/material.dart';
import 'package:rare_crew_test/view_models/navigation_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rare Crew Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NavigationContainer(),
    );
  }
}
