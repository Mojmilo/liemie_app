import 'package:liemie_app/src/Db/Connection.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';
import 'package:liemie_app/src/Db/Model/Soin.dart';
import 'package:liemie_app/src/Db/Model/Visite.dart';
import 'package:liemie_app/src/Db/Model/VisiteSoin.dart';
import 'package:liemie_app/src/Db/Repository/PersonneRepository.dart';
import 'package:liemie_app/src/Db/Repository/SoinRepository.dart';
import 'package:liemie_app/src/Db/Repository/VisiteRepository.dart';
import 'package:liemie_app/src/Db/Repository/VisiteSoinRepository.dart';
import 'package:sqflite/sqflite.dart';

class Query
{
  static final Query _instance = Query._internal();

  factory Query() {
    return _instance;
  }

  static createTablePersonne() async {
    try {
      final Database db = await Connection.database;
      await db.execute('CREATE TABLE IF NOT EXISTS personne ('
        'id INTEGER PRIMARY KEY,'
        'login TEXT,'
        'password TEXT,'
        'nom TEXT,'
        'prenom TEXT,'
        'sexe TEXT,'
        'date_naiss TEXT,'
        'date_deces TEXT,'
        'ad1 TEXT,'
        'ad2 TEXT,'
        'cp TEXT,'
        'ville TEXT,'
        'tel_fixe TEXT,'
        'tel_port TEXT,'
        'mail TEXT'
        ')'
      );
    } catch (e) {
      rethrow;
    }
  }

  static createTableVisite() async {
    try {
      final Database db = await Connection.database;
      await db.execute('CREATE TABLE IF NOT EXISTS visite ('
        'id INTEGER PRIMARY KEY,'
        'patient INTEGER,'
        'infirmiere INTEGER,'
        'date_prevue TEXT,'
        'date_reelle TEXT,'
        'duree TEXT,'
        'compte_rendu_infirmiere TEXT,'
        'compte_rendu_patient TEXT,'
        'FOREIGN KEY(patient) REFERENCES personne(id),'
        'FOREIGN KEY(infirmiere) REFERENCES personne(id)'
        ')'
      );
    } catch (e) {
      rethrow;
    }
  }

  static createTableSoin() async {
    try {
      final Database db = await Connection.database;
      await db.execute('CREATE TABLE IF NOT EXISTS soin ('
        'id_categ_soins INTEGER,'
        'id_type_soins INTEGER,'
        'id INTEGER PRIMARY KEY,'
        'libel TEXT,'
        'description TEXT,'
        'coefficient REAL,'
        'date TEXT,'
        'FOREIGN KEY(id_categ_soins) REFERENCES categ_soins(id),'
        'FOREIGN KEY(id_type_soins) REFERENCES type_soins(id)'
        ')'
      );
    } catch (e) {
      rethrow;
    }
  }

  static createTableVisiteSoin() async {
    try {
      final Database db = await Connection.database;
      await db.execute('CREATE TABLE IF NOT EXISTS visite_soin ('
        'id_visite INTEGER,'
        'id_categ_soins INTEGER,'
        'id_type_soins INTEGER,'
        'id_soin INTEGER,'
        'prevue INTEGER,'
        'realise INTEGER,'
        'PRIMARY KEY(id_visite, id_soin),'
        'FOREIGN KEY(id_visite) REFERENCES visite(id),'
        'FOREIGN KEY(id_soin) REFERENCES soin(id)'
        ')'
      );
    } catch (e) {
      rethrow;
    }
  }

  static deleteVisiteSoinByPersonne(Personne infirmiere) async {
    try {
      final Database db = await Connection.database;
      await db.execute('DELETE FROM visite_soin WHERE id_visite IN (SELECT id FROM visite WHERE infirmiere = ${infirmiere.id})');
    } catch (e) {
      rethrow;
    }
  }

  static deleteVisiteByPersonne(Personne infirmiere) async {
    try {
      final Database db = await Connection.database;
      await db.execute('DELETE FROM visite WHERE infirmiere = ${infirmiere.id}');
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Visite>> selectVisitesInfirmiere(Personne infirmiere) async {
    try {
      List<Visite> visitesResponse = [];

      final Database db = await Connection.database;
      List<Map<String, dynamic>> queryRows =
        await db.rawQuery('SELECT * FROM visite WHERE infirmiere = ${infirmiere.id}');

      List<Visite> visites = [];
      for (var i = 0; i < queryRows.length; i++) {
        Personne? personne =
          await selectPersonneByIdPersonne(int.parse(queryRows[i]['patient'].toString()));
        List<VisiteSoin> visiteSoins =
          await selectVisiteSoinsByIdVisite(int.parse(queryRows[i]['id'].toString()));

        if(personne != null) {
          visites.add(Visite.fromJson(queryRows[i], personne, infirmiere, visiteSoins));
          VisiteRepository.setVisites(visites);
          visitesResponse = visites;
        } else {
          visitesResponse = [];
        }
      }

      return visitesResponse;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Personne?> selectPersonneByIdPersonne(int idPersonne) async {
    try {
      Personne? personne;

      final Database db = await Connection.database;
      List<Map<String, dynamic>> queryRows =
        await db.rawQuery('SELECT * FROM personne WHERE id = ${idPersonne} LIMIT 1');

      if(queryRows.isNotEmpty) {
        personne = Personne.fromJson(queryRows[0]);
        PersonneRepository.add(personne);
      } else {
        personne = null;
      }

      return personne;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<VisiteSoin>> selectVisiteSoinsByIdVisite(int idVisite) async {
    try {
      List<VisiteSoin> visiteSoins = [];

      final Database db = await Connection.database;
      List<Map<String, dynamic>> queryRows =
        await db.rawQuery('SELECT * FROM visite_soin WHERE id_visite = ${idVisite}'); // AND id_soin IS NOT NULL

      selectSoins();

      for (var i = 0; i < queryRows.length; i++) {
        Soin? soin = await selectSoinByIdSoin(int.parse(queryRows[i]['id_soin'].toString()));
        Visite? visite =
          await selectVisiteByIdVisite(int.parse(queryRows[i]['id_visite'].toString()));

        if(soin != null && visite != null) {
          VisiteSoin visiteSoin = VisiteSoin.fromJson(queryRows[i], visite, soin);
          VisiteSoinRepository.add(visiteSoin);
          visiteSoins.add(visiteSoin);
        } else {
          visiteSoins = [];
        }

      }

      return visiteSoins;
    } catch (e) {
      rethrow;
    }
  }

  static selectSoins() async {
    try {
      final Database db = await Connection.database;
      List<Map<String, dynamic>> queryRows =
        await db.rawQuery('SELECT * FROM soin');

      SoinRepository.setSoins([]);

      for (var i = 0; i < queryRows.length; i++) {
        Soin soin = Soin.fromJson(queryRows[i]);
        SoinRepository.add(soin);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<Soin?> selectSoinByIdSoin(int idSoin) async {
    Soin? soin;

    try {
      final Database db = await Connection.database;
      List<Map<String, dynamic>> queryRows =
        await db.rawQuery('SELECT * FROM soin WHERE id = ${idSoin} LIMIT 1');

      if(queryRows.isNotEmpty) {
        soin = Soin.fromJson(queryRows[0]);
        SoinRepository.add(soin);
      } else {
        soin = null;
      }
    } catch(e) {
      rethrow;
    }
    return soin;
  }

  static Future<Visite?> selectVisiteByIdVisite(int idVisite) async {
    try {
      Visite? visite;

      final Database db = await Connection.database;
      List<Map<String, dynamic>> queryRows =
        await db.rawQuery('SELECT * FROM visite WHERE id = ${idVisite} LIMIT 1');

      if(queryRows.isNotEmpty) {
        Personne? patient =
          await selectPersonneByIdPersonne(int.parse(queryRows[0]['patient'].toString()));

        Personne? infirmiere =
          await selectPersonneByIdPersonne(int.parse(queryRows[0]['infirmiere'].toString()));

        if(patient != null && infirmiere != null) {
          visite = Visite.fromJson(queryRows[0], patient, infirmiere, []);
          VisiteRepository.add(visite);
        } else {
          visite = null;
        }

        return visite;
      }
    } catch (e) {
      rethrow;
    }
  }

  static updateVisiteSoinIsRealise(VisiteSoin visiteSoin) async {
    try {
      List<Map<String, dynamic>> data = [];
      final Database db = await Connection.database;
      List<Map<String, dynamic>> queryRows = await db.rawQuery(
          'UPDATE visite_soin SET realise = ${visiteSoin.isRealise ? 1 : 0} WHERE id_visite = ${visiteSoin.visite.id} AND id_soin = ${visiteSoin.soin.id}');
    } catch (e) {
      rethrow;
    }
  }

  static insertVisiteSoin(VisiteSoin visiteSoin) async {
    try {
      final Database db = await Connection.database;
      List<Map<String, dynamic>> queryRows = await db.rawQuery(
          'INSERT INTO visite_soin (id_visite, id_categ_soins, id_type_soins, id_soin, prevue, realise) VALUES (${visiteSoin.visite.id}, ${visiteSoin.idCategorieSoins}, ${visiteSoin.idTypeSoins}, ${visiteSoin.soin.id}, ${visiteSoin.isPrevu ? 1 : 0}, ${visiteSoin.isRealise ? 1 : 0})');
    } catch (e) {
      rethrow;
    }
  }

  static updateVisiteDateTimePrevue(Visite visite, DateTime datePrevue) async {
    try {
      final Database db = await Connection.database;
      List<Map<String, dynamic>> queryRows = await db.rawQuery(
          'UPDATE visite SET date_prevue = "${datePrevue}" WHERE id = ${visite.id}');
    } catch (e) {
      rethrow;
    }
  }

  static updateVisiteDateTimeReelle(Visite visite, DateTime dateReelle) async {
    try {
      final Database db = await Connection.database;
      List<Map<String, dynamic>> queryRows = await db.rawQuery(
          'UPDATE visite SET date_reelle = "${dateReelle}" WHERE id = ${visite.id}');
    } catch (e) {
      rethrow;
    }
  }

  static updateVisiteDuree(Visite visite, double duree) async {
    try {
      final Database db = await Connection.database;
      List<Map<String, dynamic>> queryRows = await db
          .rawQuery('UPDATE visite SET duree = "${duree}" WHERE id = ${visite.id}');
    } catch (e) {
      rethrow;
    }
  }

  static updateVisiteCompteRenduInfirmiere(Visite visite, String compteRenduInfirmiere) async {
    try {
      final Database db = await Connection.database;
      List<Map<String, dynamic>> queryRows = await db.rawQuery(
          'UPDATE visite SET compte_rendu_infirmiere = "${compteRenduInfirmiere}" WHERE id = ${visite.id}');
    } catch (e) {
      rethrow;
    }
  }

  static updateVisiteCompteRenduPatient(Visite visite, String compteRenduPatient) async {
    try {
      final Database db = await Connection.database;
      List<Map<String, dynamic>> queryRows = await db.rawQuery(
          'UPDATE visite SET compte_rendu_patient = "${compteRenduPatient}" WHERE id = ${visite.id}');
    } catch (e) {
      rethrow;
    }
  }

  static insertVisiteByData(data) async {
    try {
      final Database db = await Connection.database;
      await db.insert(
        'visite',
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      rethrow;
    }
  }

  static insertSoinByData(data) async {
    try {
      final Database db = await Connection.database;
      await db.insert(
        'soin',
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      rethrow;
    }
  }

  static insertPersonneByData(data) async {
    try {
      final Database db = await Connection.database;
      await db.insert(
        'personne',
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      rethrow;
    }
  }

  static insertVisiteSoinByData(data) async {
    try {
      final Database db = await Connection.database;
      await db.insert(
        'visite_soin',
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<Personne?> selectPersonneByLoginAndPassword(String login, String password) async {
    Personne? personne;

    try {
      final Database db = await Connection.database;
      List<Map<String, dynamic>> queryRows =
        await db.rawQuery('SELECT * FROM personne WHERE login = "${login}" AND password = "${password}" LIMIT 1');

      if(queryRows.isNotEmpty) {
        personne = Personne.fromJson(queryRows[0]);
      } else {
        personne = null;
      }
    } catch (e) {
      rethrow;
    }
    return personne;
  }

  static dropTablePersonne() async {
    try {
      final Database db = await Connection.database;
      await db.execute('DROP TABLE IF EXISTS personne');
    } catch (e) {
      rethrow;
    }
  }

  static dropTableVisite() async {
    try {
      final Database db = await Connection.database;
      await db.execute('DROP TABLE IF EXISTS visite');
    } catch (e) {
      rethrow;
    }
  }

  static dropTableSoin() async {
    try {
      final Database db = await Connection.database;
      await db.execute('DROP TABLE IF EXISTS soin');
    } catch (e) {
      rethrow;
    }
  }

  static dropTableVisiteSoin() async {
    try {
      final Database db = await Connection.database;
      await db.execute('DROP TABLE IF EXISTS visite_soin');
    } catch (e) {
      rethrow;
    }
  }

  Query._internal();
}