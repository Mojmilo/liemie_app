import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class Model {
  static getVisitesUser(int id) async {
    var url = Uri.parse('https://www.btssio-carcouet.fr/ppe4/public/mesvisites/${id}');
    var data = [];
    try {
      final response = await http.get(url);
      data = json.decode(response.body);

      WidgetsFlutterBinding.ensureInitialized();
      final Future<Database> database = openDatabase(
        'liemie.db',
        version: 1,
      );
      final Database db = await database;
      db.execute('DROP TABLE IF EXISTS visite');
      db.execute('CREATE TABLE visite(id INTEGER PRIMARY KEY, patient INTEGER, infirmiere INTEGER, date_prevue TEXT, date_reelle TEXT, duree REAL, compte_rendu_infirmiere TEXT, compte_rendu_patient TEXT)');

      db.execute('DROP TABLE IF EXISTS personne');
      db.execute('CREATE TABLE personne(id INTEGER PRIMARY KEY, nom TEXT, prenom TEXT, sexe TEXT, date_naiss TEXT, date_deces TEXT, ad1 TEXT, ad2 TEXT, cp TEXT, ville TEXT, tel_fixe TEXT, tel_port TEXT, mail TEXT)');
      for (var i = 0; i < data.length; i++) {
        await db.insert(
          'visite',
          data[i],
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        await getPersonne(int.parse(data[i]['patient']));
      }
      List<Map<String, dynamic>> queryRows =
          await db.rawQuery('SELECT * FROM visite');

      data = queryRows;

      // List<Map<String, dynamic>> queryRows2 =
      //     await db.rawQuery('SELECT * FROM personne');

      // print(queryRows2);
    } catch(e) {
      data = [];
    }
      return data;
  }

  static getPersonne(int id) async {
    var url = Uri.parse('https://www.btssio-carcouet.fr/ppe4/public/personne/${id}');
    var data = [];
    try {
      final response = await http.get(url);
      data = json.decode(response.body);

      WidgetsFlutterBinding.ensureInitialized();
      final Future<Database> database = openDatabase(
        'liemie.db',
        version: 1,
      );
      final Database db = await database;
      await db.insert(
        'personne',
        data[0],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      List<Map<String, dynamic>> queryRows =
          await db.rawQuery('SELECT * FROM personne');

      data = queryRows;
      
      print(data);
    } catch(e) {
      data = [];
    }
      return data;
  }
}