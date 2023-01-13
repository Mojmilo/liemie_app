import 'package:flutter/material.dart';
import 'package:liemie_app/first.dart';
import 'package:liemie_app/home.dart';
import 'package:liemie_app/login.dart';
import 'package:liemie_app/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstPage(),
        '/home': (context) => const HomePage(arguments: {}, visites: []),
        '/login': (context) => const LoginPage(),
        '/profile': (context) => const ProfilePage(arguments: {}),
      },
    );
  }
}
