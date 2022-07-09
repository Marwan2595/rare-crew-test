import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rare_crew_test/views/login_view.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rare Crew Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: NavigationContainer(
      //   index: 0,
      // ),
      home: LoginView(),
    );
  }
}
