import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:liemie_app/app.dart';
import 'package:liemie_app/models/Personne.dart';
import 'package:liemie_app/models/Visite.dart';
import 'package:liemie_app/services/Model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sqflite/sqflite.dart';

testConnexion(String login, String password, context) async {
  final String url =
      'https://www.btssio-carcouet.fr/ppe4/public/connect2/${login}/${password}/infirmiere';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json['status'] != 'false') {
        if (json != false) {
          // Navigator.of(context).pushAndRemoveUntil(
          //   MaterialPageRoute(
          //     builder: (context) => HomePage(
          //       arguments: json,
          //     ),
          //   ),
          //   (route) => false,
          // );

          await Model.loadTable();
          // await Model.getVisitesUserDB(int.parse(json['id'].toString()));
          await Model.getVisitesUser(int.parse(json['id'].toString()));

          Personne personne = Personne.fromJson(json);

          Navigator.push(
            context,
            PageTransition(
              child: AppPage(
                personne: personne,
                visites: Visite.visites,
              ),
              type: PageTransitionType.fade,
            ),
          );
          json['login'] = login;
          json['password'] = md5.convert(utf8.encode(password)).toString();

          WidgetsFlutterBinding.ensureInitialized();
          final Future<Database> database = openDatabase(
            'liemie.db',
            version: 1,
          );

          final Database db = await database;

          db.execute(
              'CREATE TABLE IF NOT EXISTS user(id INTEGER PRIMARY KEY, login TEXT, password TEXT, nom TEXT, prenom TEXT, sexe TEXT, date_naiss TEXT, date_deces TEXT, ad1 TEXT, ad2 TEXT, cp TEXT, ville TEXT, tel_fixe TEXT, tel_port TEXT, mail TEXT)');

          // await deleteDatabase(db.path);

          await db.insert(
            'user',
            json,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );

          List<Map<String, dynamic>> queryRows =
              await db.rawQuery('SELECT * FROM user');

          // print(queryRows);

          return true;
        }
      } else {
        return false;
      }
    } else {
      // throw Exception('Failed to load data');
      return false;
    }
  } catch (e) {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      'liemie.db',
      version: 1,
    );

    final Database db = await database;

    db.execute(
        'CREATE TABLE IF NOT EXISTS user(id INTEGER PRIMARY KEY, login TEXT, password TEXT, nom TEXT, prenom TEXT, sexe TEXT, date_naiss TEXT, date_deces TEXT, ad1 TEXT, ad2 TEXT, cp TEXT, ville TEXT, tel_fixe TEXT, tel_port TEXT, mail TEXT)');

    List<Map<String, dynamic>> queryRows =
        await db.rawQuery('SELECT * FROM user');

    for (var row in queryRows) {
      if (row['login'] == login &&
          row['password'] == md5.convert(utf8.encode(password)).toString()) {
        // Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute(
        //     builder: (context) => HomePage(
        //       arguments: row,
        //     ),
        //   ),
        //   (route) => false,
        // );
        await Model.getVisitesUser(int.parse(row['id'].toString()));

        Personne personne = Personne.fromJson(row);

        Navigator.push(
          context,
          PageTransition(
            child: AppPage(
              // arguments: row,
              personne: personne,
              visites: Visite.visites,
            ),
            type: PageTransitionType.fade,
          ),
        );
        return true;
      }
    }

    return false;
  }
}
