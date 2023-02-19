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
  static final Connection connection = Connection();

  factory Query() {
    return _instance;
  }

  static createTablePersonne() async {
    final Database db = await connection.load();
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
  }

  static createTableVisite() async {
    final Database db = await connection.load();
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
  }

  static createTableSoin() async {
    final Database db = await connection.load();
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
  }

  static createTableVisiteSoin() async {
    final Database db = await connection.load();
    await db.execute('CREATE TABLE IF NOT EXISTS visite_soin ('
      'visite INTEGER,'
      'id_categ_soins INTEGER,'
      'id_type_soins INTEGER,'
      'id_soin INTEGER,'
      'prevue INTEGER,'
      'realise INTEGER,'
      'PRIMARY KEY(visite, id_soins),'
      'FOREIGN KEY(visite) REFERENCES visite(id),'
      'FOREIGN KEY(id_soin) REFERENCES soin(id)'
      ')'
    );
  }

  static deleteVisiteSoinByPersonne(Personne infirmiere) async {
    final Database db = await connection.load();
    await db.execute('DELETE FROM visite_soin WHERE visite IN (SELECT id FROM visite WHERE infirmiere = ${infirmiere.id})');
  }

  static deleteVisiteByPersonne(Personne infirmiere) async {
    final Database db = await connection.load();
    await db.execute('DELETE FROM visite WHERE infirmiere = ${infirmiere.id}');
  }

  static selectVisitesInfirmiere(Personne infirmiere) async {
    List<Visite> visitesResponse = [];
    try {
      final Database db = await connection.load();
      List<Map<String, dynamic>> queryRows =
        await db.rawQuery('SELECT * FROM visite WHERE infirmiere = ${infirmiere.id}');

      List<Visite> visites = [];
      for (var i = 0; i < queryRows.length; i++) {
        Personne personne =
          await selectPersonneByIdPersonne(int.parse(queryRows[i]['patient'].toString()));
        List<VisiteSoin> visiteSoins =
          await selectVisiteSoinsByIdVisite(int.parse(queryRows[i]['id'].toString()));
        visites.add(Visite.fromJson(queryRows[i], personne, infirmiere, visiteSoins));
      }
      VisiteRepository.setVisites(visites);
      visitesResponse = visites;
    } catch (e) {
      visitesResponse = [];
    }
    return visitesResponse;
  }

  static selectPersonneByIdPersonne(int idPersonne) async {
    Personne personne;
    final Database db = await connection.load();
    List<Map<String, dynamic>> queryRows =
      await db.rawQuery('SELECT * FROM personne WHERE id = ${idPersonne} LIMIT 1');

    personne = Personne.fromJson(queryRows[0]);
    PersonneRepository.add(personne);
    return personne;
  }

  static selectVisiteSoinsByIdVisite(int idVisite) async {
    List<VisiteSoin> visiteSoins = [];
    final Database db = await connection.load();
    List<Map<String, dynamic>> queryRows =
      await db.rawQuery('SELECT * FROM visite_soin WHERE visite = ${idVisite}');

    selectSoins();

    for (var i = 0; i < queryRows.length; i++) {
      Soin soin = await selectSoinByIdSoin(int.parse(queryRows[i]['id_soins'].toString()));
      Visite visite =
        await selectVisiteByIdVisite(int.parse(queryRows[i]['id_visite'].toString()));
      VisiteSoin visiteSoin = VisiteSoin.fromJson(queryRows[i], visite, soin);
      VisiteSoinRepository.add(visiteSoin);
      visiteSoins.add(visiteSoin);
    }
    return visiteSoins;
  }

  static selectSoins() async {
    final Database db = await connection.load();
    List<Map<String, dynamic>> queryRows =
      await db.rawQuery('SELECT * FROM soin');

    SoinRepository.setSoins([]);

    for (var i = 0; i < queryRows.length; i++) {
      Soin soin = Soin.fromJson(queryRows[i]);
      SoinRepository.add(soin);
    }
  }

  static selectSoinByIdSoin(int idSoin) async {
    Soin soin;
    final Database db = await connection.load();
    List<Map<String, dynamic>> queryRows =
      await db.rawQuery('SELECT * FROM soin WHERE id = ${idSoin} LIMIT 1');

    soin = Soin.fromJson(queryRows[0]);
    SoinRepository.add(soin);
    return soin;
  }

  static selectVisiteByIdVisite(int idVisite) async {
    Visite visite;
    final Database db = await connection.load();
    List<Map<String, dynamic>> queryRows =
      await db.rawQuery('SELECT * FROM visite WHERE id = ${idVisite} LIMIT 1');

    Personne patient =
      await selectPersonneByIdPersonne(int.parse(queryRows[0]['patient'].toString()));

    Personne infirmiere =
      await selectPersonneByIdPersonne(int.parse(queryRows[0]['infirmiere'].toString()));
    visite = Visite.fromJson(queryRows[0], patient, infirmiere, []);
    VisiteRepository.add(visite);
    return visite;
  }

  static updateVisiteSoinIsRealise(VisiteSoin visiteSoin) async {
    final Database db = await connection.load();
    List<Map<String, dynamic>> queryRows = await db.rawQuery(
        'UPDATE visite_soin SET realise = ${visiteSoin.isRealise ? 1 : 0} WHERE visite = ${visiteSoin.visite.id} AND id_soins = ${visiteSoin.soin.id}');
  }

  static insertVisiteSoin(VisiteSoin visiteSoin) async {
    final Database db = await connection.load();
    List<Map<String, dynamic>> queryRows = await db.rawQuery(
        'INSERT INTO visite_soin (visite, id_categ_soins, id_type_soins, id_soins, prevu, realise) VALUES (${visiteSoin.visite.id}, ${visiteSoin.idCategorieSoins}, ${visiteSoin.idTypeSoins}, ${visiteSoin.soin.id}, ${visiteSoin.isPrevu ? 1 : 0}, ${visiteSoin.isRealise ? 1 : 0})');
  }

  static updateVisiteDateTimePrevue(Visite visite, DateTime datePrevue) async {
    final Database db = await connection.load();
    List<Map<String, dynamic>> queryRows = await db.rawQuery(
        'UPDATE visite SET date_prevue = "${datePrevue}" WHERE id = ${visite.id}');
  }

  static updateVisiteDateTimeReelle(Visite visite, DateTime dateReelle) async {
    final Database db = await connection.load();
    List<Map<String, dynamic>> queryRows = await db.rawQuery(
        'UPDATE visite SET date_reelle = "${dateReelle}" WHERE id = ${visite.id}');
  }

  static updateVisiteDuree(Visite visite, double duree) async {
    final Database db = await connection.load();
    List<Map<String, dynamic>> queryRows = await db
        .rawQuery('UPDATE visite SET duree = "${duree}" WHERE id = ${visite.id}');
  }

  static updateVisiteCompteRenduInfirmiere(Visite visite, String compteRenduInfirmiere) async {
    final Database db = await connection.load();
    List<Map<String, dynamic>> queryRows = await db.rawQuery(
        'UPDATE visite SET compte_rendu_infirmiere = "${compteRenduInfirmiere}" WHERE id = ${visite.id}');
  }

  static updateVisiteCompteRenduPatient(Visite visite, String compteRenduPatient) async {
    final Database db = await connection.load();
    List<Map<String, dynamic>> queryRows = await db.rawQuery(
        'UPDATE visite SET compte_rendu_patient = "${compteRenduPatient}" WHERE id = ${visite.id}');
  }

  static insertVisiteByData(data) async {
    final Database db = await connection.load();
    await db.insert(
      'visite',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static insertSoinByData(data) async {
    final Database db = await connection.load();
    await db.insert(
      'soin',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static insertPersonneByData(data) async {
    final Database db = await connection.load();
    await db.insert(
      'personne',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static insertVisiteSoinByData(data) async {
    final Database db = await connection.load();
    await db.insert(
      'visite_soin',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static selectPersonneByLoginAndPassword(String login, String password) async {
    Personne personne;
    final Database db = await connection.load();
    List<Map<String, dynamic>> queryRows =
      await db.rawQuery('SELECT * FROM personne WHERE login = "${login}" AND password = "${password}" LIMIT 1');

    personne = Personne.fromJson(queryRows[0]);
    return personne;
  }

  Query._internal();
}