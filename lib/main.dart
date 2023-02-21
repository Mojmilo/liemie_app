import 'package:flutter/material.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';
import 'package:liemie_app/src/Db/Query.dart';
import 'package:liemie_app/src/Pages/first.dart';
import 'package:liemie_app/src/Pages/app.dart';
import 'package:liemie_app/src/Pages/login.dart';
import 'package:liemie_app/src/Pages/profile.dart';
import 'package:liemie_app/src/Services/Http/QueryApi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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
        // '/home': (context) => const HomePage(arguments: {}, visites: []),
        '/login': (context) => const LoginPage(),
        // '/profile': (context) => const ProfilePage(arguments: {}),
      },
    );
  }
}
