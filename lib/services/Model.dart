import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:liemie_app/models/Personne.dart';
import 'package:liemie_app/models/Visite.dart';
import 'package:liemie_app/models/VisiteSoin.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class Model {
  static getVisitesUserDB(int id) async {
    var url = Uri.parse(
        'https://www.btssio-carcouet.fr/ppe4/public/mesvisites/${id}');
    bool res = false;
    try {
      var data = [];
      final response = await http.get(url);
      data = json.decode(response.body);

      WidgetsFlutterBinding.ensureInitialized();
      final Future<Database> database = openDatabase(
        'liemie.db',
        version: 1,
      );
      final Database db = await database;

      db.execute(
          'CREATE TABLE IF NOT EXISTS visite(id INTEGER PRIMARY KEY, patient INTEGER, infirmiere INTEGER, date_prevue TEXT, date_reelle TEXT, duree REAL, compte_rendu_infirmiere TEXT, compte_rendu_patient TEXT)');
      db.execute(
          'CREATE TABLE IF NOT EXISTS personne(id INTEGER PRIMARY KEY, nom TEXT, prenom TEXT, sexe TEXT, date_naiss TEXT, date_deces TEXT, ad1 TEXT, ad2 TEXT, cp TEXT, ville TEXT, tel_fixe TEXT, tel_port TEXT, mail TEXT)');
      db.execute(
          'CREATE TABLE IF NOT EXISTS visite_soin(visite INTEGER, id_categ_soins INTEGER, id_type_soins INTEGER, id_soins INTEGER, prevu INTEGER, realise INTEGER, PRIMARY KEY(visite, id_soins))');

      for (var i = 0; i < data.length; i++) {
        await db.insert(
          'visite',
          data[i],
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        await getPersonneDB(int.parse(data[i]['patient']));
        await getVisiteSoinDB(int.parse(data[i]['id']));
      }
      res = true;
    } catch (e) {
      res = false;
    }
    return res;
  }

  static getVisitesUser(int id) async {
    List<Visite> visites = [];
    bool res = false;
    try {
      var data = [];
      WidgetsFlutterBinding.ensureInitialized();
      final Future<Database> database = openDatabase(
        'liemie.db',
        version: 1,
      );
      final Database db = await database;
      List<Map<String, dynamic>> queryRows =
          await db.rawQuery('SELECT * FROM visite WHERE infirmiere = ${id}');

      data = queryRows;

      List<Visite> visites = [];
      // Visite.visites = [];
      Personne.personnes = [];
      VisiteSoin.visiteSoins = [];
      for (var i = 0; i < data.length; i++) {
        Personne personne =
            await getPersonne(int.parse(data[i]['patient'].toString()));
        List<VisiteSoin> visiteSoins =
            await getVisiteSoin(int.parse(data[i]['id'].toString()));
        visites.add(Visite.fromJson(data[i], personne, visiteSoins));
      }
      Visite.visites = visites;
      res = true;
    } catch (e) {
      res = false;
    }
    return res;
  }

  static getPersonneDB(int id) async {
    var url =
        Uri.parse('https://www.btssio-carcouet.fr/ppe4/public/personne/${id}');
    bool res = false;
    try {
      var data = [];
      final response = await http.get(url);
      data = json.decode(response.body);

      WidgetsFlutterBinding.ensureInitialized();
      final Future<Database> database = openDatabase(
        'liemie.db',
        version: 1,
      );
      final Database db = await database;
      for (var i = 0; i < data.length; i++) {
        await db.insert(
          'personne',
          data[i],
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      res = true;
    } catch (e) {
      res = false;
    }
    return res;
  }

  static getPersonne(int id) async {
    Personne personne;

    var data = [];
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      'liemie.db',
      version: 1,
    );
    final Database db = await database;
    List<Map<String, dynamic>> queryRows =
        await db.rawQuery('SELECT * FROM personne WHERE id = ${id} LIMIT 1');

    data = queryRows;

    personne = Personne.fromJson(data[0]);
    Personne.personnes.add(personne);
    return personne;
  }

  static getVisiteSoinDB(int id) async {
    var url =
        Uri.parse('https://www.btssio-carcouet.fr/ppe4/public/visitesoins/${id}');
    bool res = false;
    try {
      var data = [];
      final response = await http.get(url);
      data = json.decode(response.body);

      WidgetsFlutterBinding.ensureInitialized();
      final Future<Database> database = openDatabase(
        'liemie.db',
        version: 1,
      );
      final Database db = await database;
      for (var i = 0; i < data.length; i++) {
        await db.insert(
          'visite_soin',
          data[i],
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      res = true;
    } catch (e) {
      res = false;
    }
    return res;
  }

  static getVisiteSoin(int id) async {
    List<VisiteSoin> visiteSoins = [];

    var data = [];
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      'liemie.db',
      version: 1,
    );
    final Database db = await database;
    List<Map<String, dynamic>> queryRows =
        await db.rawQuery('SELECT * FROM visite_soin WHERE visite = ${id}');

    data = queryRows;

    // print(data);

    for(var i = 0; i < data.length; i++){
      VisiteSoin visiteSoin = VisiteSoin.fromJson(data[i]);
      VisiteSoin.visiteSoins.add(visiteSoin);
      visiteSoins.add(visiteSoin);
    }
    return visiteSoins;
  }

  static deleteAll() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      'liemie.db',
      version: 1,
    );
    final Database db = await database;

    // db.execute('DROP TABLE IF EXISTS user');
    // db.execute('DROP TABLE IF EXISTS visite');
    // db.execute('DROP TABLE IF EXISTS personne');
    db.execute('drop table visite_soin');
  }
}
