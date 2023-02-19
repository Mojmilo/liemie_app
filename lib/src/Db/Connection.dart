import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Connection
{
  static final Connection _instance = Connection._internal();
  static final Future<Database> database = openDatabase(
    'liemie.db',
    version: 1,
  );

  factory Connection() {
    return _instance;
  }

  static Future<Database> load() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Database db = await database;
    return db;
  }

  Connection._internal();
}