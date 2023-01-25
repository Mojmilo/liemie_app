import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:liemie_app/models/Personne.dart';
import 'package:liemie_app/models/Soin.dart';
import 'package:liemie_app/models/Visite.dart';
import 'package:liemie_app/models/VisiteSoin.dart';
import 'package:liemie_app/visite.dart';
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
      db.execute(
          'CREATE TABLE IF NOT EXISTS soin(id_categ_soins INTEGER, id_type_soins INTEGER, id INTEGER PRIMARY KEY, libel TEXT, description TEXT, coefficient REAL, date TEXT)');

      // db.execute('DELETE FROM visite');
      // db.execute('DELETE FROM personne');
      // db.execute('DELETE FROM visite_soin');
      // db.execute('DELETE FROM soin');
      db.execute(
          'DELETE FROM visite_soin WHERE visite IN (SELECT id FROM visite WHERE infirmiere = ${id})');
      db.execute('DELETE FROM visite WHERE infirmiere = ${id}');

      // getSoins();

      await getSoinDB();
      // getSoins();
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
    var url = Uri.parse(
        'https://www.btssio-carcouet.fr/ppe4/public/visitesoins/${id}');
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

    getSoins();

    for (var i = 0; i < data.length; i++) {
      Soin soin = await getSoin(int.parse(data[i]['id_soins'].toString()));
      VisiteSoin visiteSoin = VisiteSoin.fromJson(data[i], soin);
      VisiteSoin.visiteSoins.add(visiteSoin);
      visiteSoins.add(visiteSoin);
    }
    return visiteSoins;
  }

  static getSoinDB() async {
    var url = Uri.parse('https://www.btssio-carcouet.fr/ppe4/public/soins/');
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
          'soin',
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

  static getSoins() async {
    var data = [];
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      'liemie.db',
      version: 1,
    );
    final Database db = await database;
    List<Map<String, dynamic>> queryRows =
        await db.rawQuery('SELECT * FROM soin');

    data = queryRows;

    Soin.soins = [];

    for (var i = 0; i < data.length; i++) {
      Soin soin = Soin.fromJson(data[i]);
      Soin.soins.add(soin);
    }
  }

  static getSoin(int id) async {
    Soin soin = Soin.soins.firstWhere((element) => element.id == id);
    return soin;
  }

  // static getSoin(int id) async {
  //   Soin soin;

  //   var data = [];
  //   WidgetsFlutterBinding.ensureInitialized();
  //   final Future<Database> database = openDatabase(
  //     'liemie.db',
  //     version: 1,
  //   );
  //   final Database db = await database;
  //   List<Map<String, dynamic>> queryRows =
  //       await db.rawQuery('SELECT * FROM soin WHERE id = ${id} LIMIT 1');

  //   data = queryRows;

  //   soin = Soin.fromJson(data[0]);
  //   Soin.soins.add(soin);
  //   return soin;
  // }

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

  static setIsRealise(int idVisite, int idSoins, bool isRealise) async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      'liemie.db',
      version: 1,
    );
    final Database db = await database;
    List<Map<String, dynamic>> queryRows = await db.rawQuery(
        'UPDATE visite_soin SET realise = ${isRealise} WHERE visite = ${idVisite} AND id_soins = ${idSoins}');
  }

  static addVisiteSoin(VisiteSoin visiteSoin) async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      'liemie.db',
      version: 1,
    );
    final Database db = await database;
    List<Map<String, dynamic>> queryRows = await db.rawQuery(
        'INSERT INTO visite_soin (visite, id_categ_soins, id_type_soins, id_soins, prevu, realise) VALUES (${visiteSoin.idVisite}, ${visiteSoin.idCategorieSoins}, ${visiteSoin.idTypeSoins}, ${visiteSoin.idSoins}, ${visiteSoin.isPrevu}, ${visiteSoin.isRealise})');
  }

  static setDateTimePrevue(int id, DateTime date_prevue) async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      'liemie.db',
      version: 1,
    );
    final Database db = await database;
    List<Map<String, dynamic>> queryRows = await db.rawQuery(
        'UPDATE visite SET date_prevue = "${date_prevue}" WHERE id = ${id}');
  }

  static setDateTimeReelle(int id, DateTime date_reelle) async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      'liemie.db',
      version: 1,
    );
    final Database db = await database;
    List<Map<String, dynamic>> queryRows = await db.rawQuery(
        'UPDATE visite SET date_reelle = "${date_reelle}" WHERE id = ${id}');
  }

  static setDuree(int id, double duree) async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      'liemie.db',
      version: 1,
    );
    final Database db = await database;
    List<Map<String, dynamic>> queryRows = await db
        .rawQuery('UPDATE visite SET duree = "${duree}" WHERE id = ${id}');
  }

  static setCompteRenduInfirmiere(
      int id, String compte_rendu_infirmiere) async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      'liemie.db',
      version: 1,
    );
    final Database db = await database;
    List<Map<String, dynamic>> queryRows = await db.rawQuery(
        'UPDATE visite SET compte_rendu_infirmiere = "${compte_rendu_infirmiere}" WHERE id = ${id}');
  }

  static setCompteRenduPatient(int id, String compte_rendu_patient) async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      'liemie.db',
      version: 1,
    );
    final Database db = await database;
    List<Map<String, dynamic>> queryRows = await db.rawQuery(
        'UPDATE visite SET compte_rendu_patient = "${compte_rendu_patient}" WHERE id = ${id}');
  }

  static addVisite(Visite visite) async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      'liemie.db',
      version: 1,
    );
    final Database db = await database;
    List<Map<String, dynamic>> queryRows = await db.rawQuery(
        'INSERT INTO visite (patient, infirmiere, date_prevue, date_reelle, duree, compte_rendu_infirmiere, compte_rendu_patient) VALUES (${visite.idPatient}, ${visite.idInfirmiere}, "${visite.date_prevue}", "${visite.date_reelle}", ${visite.duree}, "${visite.compte_rendu_infirmiere}", "${visite.compte_rendu_patient}")');
    List<Map<String, dynamic>> queryRows2 =
        await db.rawQuery('SELECT * FROM visite ORDER BY id DESC LIMIT 1');
    visite.id = queryRows2[0]['id'];
    Visite.visites.add(visite);
  }
}
