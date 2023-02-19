import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liemie_app/src/Db/Connection.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';
import 'package:liemie_app/src/Db/Model/Soin.dart';
import 'package:liemie_app/src/Db/Model/Visite.dart';
import 'package:liemie_app/src/Db/Model/VisiteSoin.dart';
import 'package:liemie_app/src/Db/Query.dart';
import 'package:liemie_app/src/Db/Repository/SoinRepository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  test('dropTablePersonne', () async {
    Query.dropTablePersonne();
  });

  test('dropTableVisite', () async {
    Query.dropTableVisite();
  });

  test('dropTableSoin', () async {
    Query.dropTableSoin();
  });

  test('dropTableVisiteSoin', () async {
    Query.dropTableVisiteSoin();
  });

  test('createTablePersonne', () async {
    Query.createTablePersonne();
  });

  test('createTableVisite', () async {
    Query.createTableVisite();
  });

  test('createTableSoin', () async {
    Query.createTableSoin();
  });

  test('createTableVisiteSoin', () async {
    Query.createTableVisiteSoin();
  });

  test('deleteVisiteSoinByPersonne', () async {
    Personne personne = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Query.deleteVisiteSoinByPersonne(personne);
  });

  test('deleteVisiteByPersonne', () async {
    Personne personne = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Query.deleteVisiteByPersonne(personne);
  });

  test('selectVisitesInfirmiere', () async {
    Personne infirmiere = Personne(
      3,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    List<Visite> visites = [];
    visites = await Query.selectVisitesInfirmiere(infirmiere);
    expect(visites, []);
  });

  test('selectPersonneByIdPersonne', () async {
    Personne personne = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Personne? personneResult = await Query.selectPersonneByIdPersonne(personne.id);
    expect(personneResult, null);
  });

  test('selectVisiteSoinsByIdVisite', () async {
    Personne patient = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Personne infirmiere = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Visite visite = Visite(
      1,
      patient,
      infirmiere,
      DateTime.now(),
      DateTime.now(),
      1.0,
      'compteRenduInfirmiere',
      'compteRenduPatient',
      [],
    );

    List<VisiteSoin> visiteSoins = await Query.selectVisiteSoinsByIdVisite(visite.id);

    expect(visiteSoins.length, 0);
  });

  test('selectSoins', () async {
    //expect(SoinRepository.soins, 0);
    Query.selectSoins();
    //expect(SoinRepository.soins, 1);
  });

  test('selectSoinByIdSoin', () async {
    Soin soin = Soin(
      1,
      'libel',
      'description',
      1.0,
      DateTime.now(),
      1,
      1,
    );

    Soin? soinResult = await Query.selectSoinByIdSoin(soin.id);

    expect(soinResult, null);
  });

  test('selectVisiteByIdVisite', () async {
    Personne patient = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Personne infirmiere = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Visite visite = Visite(
      1,
      patient,
      infirmiere,
      DateTime.now(),
      DateTime.now(),
      1.0,
      'compteRenduInfirmiere',
      'compteRenduPatient',
      [],
    );

    Visite? visiteResult = await Query.selectVisiteByIdVisite(visite.id);

    expect(visiteResult, null);
  });

  test('updateVisiteSoinIsRealise', () async {
    Personne patient = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Personne infirmiere = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Visite visite = Visite(
      1,
      patient,
      infirmiere,
      DateTime.now(),
      DateTime.now(),
      1.0,
      'compteRenduInfirmiere',
      'compteRenduPatient',
      [],
    );

    Soin soin = Soin(
      1,
      'libel',
      'description',
      1.0,
      DateTime.now(),
      1,
      1,
    );

    VisiteSoin visiteSoin = VisiteSoin(
      visite,
      soin,
      1,
      1,
      true,
      false,
    );

    Query.updateVisiteSoinIsRealise(visiteSoin);
  });

  test('insertVisiteSoin', () async {
    Personne patient = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Personne infirmiere = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Visite visite = Visite(
      1,
      patient,
      infirmiere,
      DateTime.now(),
      DateTime.now(),
      1.0,
      'compteRenduInfirmiere',
      'compteRenduPatient',
      [],
    );

    Soin soin = Soin(
      1,
      'libel',
      'description',
      1.0,
      DateTime.now(),
      1,
      1,
    );

    VisiteSoin visiteSoin = VisiteSoin(
      visite,
      soin,
      1,
      1,
      true,
      false,
    );

    Query.insertVisiteSoin(visiteSoin);
  });

  test('updateVisiteDateTimePrevue', () async {
    Personne patient = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Personne infirmiere = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Visite visite = Visite(
      1,
      patient,
      infirmiere,
      DateTime.now(),
      DateTime.now(),
      1.0,
      'compteRenduInfirmiere',
      'compteRenduPatient',
      [],
    );

    Query.updateVisiteDateTimePrevue(visite, DateTime.now());
  });

  test('updateVisiteDateTimeReelle', () async {
    Personne patient = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Personne infirmiere = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Visite visite = Visite(
      1,
      patient,
      infirmiere,
      DateTime.now(),
      DateTime.now(),
      1.0,
      'compteRenduInfirmiere',
      'compteRenduPatient',
      [],
    );

    Query.updateVisiteDateTimeReelle(visite, DateTime.now());
  });

  test('updateVisiteDuree', () async {
    Personne patient = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Personne infirmiere = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Visite visite = Visite(
      1,
      patient,
      infirmiere,
      DateTime.now(),
      DateTime.now(),
      1.0,
      'compteRenduInfirmiere',
      'compteRenduPatient',
      [],
    );

    Query.updateVisiteDuree(visite, 1.0);
  });

  test('updateVisiteCompteRenduInfirmiere', () async {
    Personne patient = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Personne infirmiere = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Visite visite = Visite(
      1,
      patient,
      infirmiere,
      DateTime.now(),
      DateTime.now(),
      1.0,
      'compteRenduInfirmiere',
      'compteRenduPatient',
      [],
    );

    Query.updateVisiteCompteRenduInfirmiere(visite, 'compteRenduInfirmiere');
  });

  test('updateVisiteCompteRenduPatient', () async {
    Personne patient = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Personne infirmiere = Personne(
      1,
      'login',
      'password',
      'nom',
      'prenom',
      'sexe',
      DateTime.now(),
      DateTime.now(),
      'ad1',
      'ad2',
      'cp',
      'ville',
      'telFixe',
      'telPort',
      'mail',
    );

    Visite visite = Visite(
      1,
      patient,
      infirmiere,
      DateTime.now(),
      DateTime.now(),
      1.0,
      'compteRenduInfirmiere',
      'compteRenduPatient',
      [],
    );

    Query.updateVisiteCompteRenduPatient(visite, 'compteRenduPatient');
  });

  test('insertVisiteByData', () async {
    var data = {
      "id": "4",
      "patient": "5",
      "infirmiere": "3",
      "date_prevue": "2022-05-30 16:30:00",
      "date_reelle": "0000-00-00 00:00:00",
      "duree": "45",
      "compte_rendu_infirmiere": "",
      "compte_rendu_patient": ""
    };

    Query.insertVisiteByData(data);
  });

  test('insertSoinByData', () async {
    var data = {
        "id_categ_soins": "1",
        "id_type_soins": "1",
        "id": "1",
        "libel": "Prélèvement par ponction veineuse directe",
        "description": "",
        "coefficient": "1.5",
        "date": "2016-11-17 20:31:10"
      };

    Query.insertSoinByData(data);
  });

  test('insertPersonneByData', () async {
    var data = {
        "id": "1",
        "nom": "Lagaffe",
        "prenom": "Gaston",
        "sexe": "H",
        "date_naiss": "",
        "date_deces": "",
        "ad1": "",
        "ad2": "",
        "cp": "",
        "ville": "",
        "tel_fixe": "",
        "tel_port": "",
        "mail": ""
      };

    Query.insertPersonneByData(data);
  });

  test('selectPersonneByLoginAndPassword', () async {

    Personne? personne = await Query.selectPersonneByLoginAndPassword('lwald', md5.convert(utf8.encode('lwald')).toString());

    expect(personne, null); // isNotNull
  });
}