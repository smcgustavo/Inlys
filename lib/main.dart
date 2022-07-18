import 'package:flutter/material.dart';
import 'bottomNavigationBarMenu.dart';
import 'package:flutter/services.dart';
import 'package:inlys/profile.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Profile user = Profile("Gustavo", 13.25);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNavigation(user: user),
    );
  }
}