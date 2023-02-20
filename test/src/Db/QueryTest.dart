import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';
import 'package:liemie_app/src/Db/Model/Soin.dart';
import 'package:liemie_app/src/Db/Model/Visite.dart';
import 'package:liemie_app/src/Db/Model/VisiteSoin.dart';
import 'package:liemie_app/src/Db/Query.dart';
import 'package:liemie_app/src/Services/Http/QueryApi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  test('dropTablePersonne', () async {
    // ARRANGE

    // ACT
    Query.dropTablePersonne();

    // ASSERT
  });

  test('dropTableVisite', () async {
    // ARRANGE

    // ACT
    Query.dropTableVisite();

    // ASSERT
  });

  test('dropTableSoin', () async {
    // ARRANGE

    // ACT
    Query.dropTableSoin();

    // ASSERT
  });

  test('dropTableVisiteSoin', () async {
    // ARRANGE

    // ACT
    Query.dropTableVisiteSoin();

    // ASSERT
  });

  test('createTablePersonne', () async {
    // ARRANGE

    // ACT
    Query.createTablePersonne();

    // ASSERT
  });

  test('createTableVisite', () async {
    // ARRANGE

    // ACT
    Query.createTableVisite();

    // ASSERT
  });

  test('createTableSoin', () async {
    // ARRANGE

    // ACT
    Query.createTableSoin();

    // ASSERT
  });

  test('createTableVisiteSoin', () async {
    // ARRANGE

    // ACT
    Query.createTableVisiteSoin();

    // ASSERT
  });

  test('deleteVisiteSoinByPersonne', () async {
    // ARRANGE

    // ACT
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

    // ASSERT
  });

  test('deleteVisiteByPersonne', () async {
    // ARRANGE

    // ACT
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

    // ASSERT
  });

  test('selectVisitesInfirmiere', () async {
    // ARRANGE
    Query.dropTablePersonne();
    Query.dropTableVisite();
    Query.dropTableSoin();
    Query.dropTableVisiteSoin();

    Query.createTablePersonne();
    Query.createTableVisite();
    Query.createTableSoin();
    Query.createTableVisiteSoin();

    // ACT
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
    List<Visite> visites = await Query.selectVisitesInfirmiere(infirmiere);
    await QueryApi.getVisitesInfirmiere(infirmiere);
    List<Visite> visites2 = await Query.selectVisitesInfirmiere(infirmiere);

    // ASSERT
    expect(visites.length, 0);
    expect(visites2.length, 8);
  });

  test('selectPersonneByIdPersonne', () async {
    // ARRANGE
    Query.dropTablePersonne();
    Query.dropTableVisite();
    Query.dropTableSoin();
    Query.dropTableVisiteSoin();

    Query.createTablePersonne();
    Query.createTableVisite();
    Query.createTableSoin();
    Query.createTableVisiteSoin();

    // ACT
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
    await QueryApi.getPersonneByIdPersonne(personne.id);
    Personne? personneResult2 = await Query.selectPersonneByIdPersonne(personne.id);

    // ASSERT
    expect(personneResult, null);
    expect(personneResult2!, isNotNull);
  });

  test('selectVisiteSoinsByIdVisite', () async {
    // ARRANGE
    Query.dropTablePersonne();
    Query.dropTableVisite();
    Query.dropTableSoin();
    Query.dropTableVisiteSoin();

    Query.createTablePersonne();
    Query.createTableVisite();
    Query.createTableSoin();
    Query.createTableVisiteSoin();

    // ACT
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
    await QueryApi.getPersonneByIdPersonne(infirmiere.id);
    await QueryApi.getVisitesInfirmiere(infirmiere);
    List<VisiteSoin> visiteSoins2 = await Query.selectVisiteSoinsByIdVisite(visite.id);

    // ASSERT
    expect(visiteSoins.length, 0);
    expect(visiteSoins2.length, 2);
  });

  test('selectSoins', () async {
    // ARRANGE
    Query.dropTablePersonne();
    Query.dropTableVisite();
    Query.dropTableSoin();
    Query.dropTableVisiteSoin();

    Query.createTablePersonne();
    Query.createTableVisite();
    Query.createTableSoin();
    Query.createTableVisiteSoin();

    // ACT
    Query.selectSoins();

    // ASSERT
  });

  test('selectSoinByIdSoin', () async {
    // ARRANGE
    Query.dropTablePersonne();
    Query.dropTableVisite();
    Query.dropTableSoin();
    Query.dropTableVisiteSoin();

    Query.createTablePersonne();
    Query.createTableVisite();
    Query.createTableSoin();
    Query.createTableVisiteSoin();

    // ACT
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
    await QueryApi.getPersonneByIdPersonne(infirmiere.id);
    await QueryApi.getVisitesInfirmiere(infirmiere);
    Soin? soinResult2 = await Query.selectSoinByIdSoin(soin.id);

    // ASSERT
    expect(soinResult, null);
    expect(soinResult2, isNotNull);
  });

  test('selectVisiteByIdVisite', () async {
    // ARRANGE
    Query.dropTablePersonne();
    Query.dropTableVisite();
    Query.dropTableSoin();
    Query.dropTableVisiteSoin();

    Query.createTablePersonne();
    Query.createTableVisite();
    Query.createTableSoin();
    Query.createTableVisiteSoin();

    // ACT
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
    await QueryApi.getPersonneByIdPersonne(infirmiere.id);
    await QueryApi.getVisitesInfirmiere(infirmiere);
    Visite? visiteResult2 = await Query.selectVisiteByIdVisite(visite.id);

    // ASSERT
    expect(visiteResult, null);
    expect(visiteResult2, isNotNull);
  });

  test('updateVisiteSoinIsRealise', () async {
    // ARRANGE
    Query.dropTablePersonne();
    Query.dropTableVisite();
    Query.dropTableSoin();
    Query.dropTableVisiteSoin();

    Query.createTablePersonne();
    Query.createTableVisite();
    Query.createTableSoin();
    Query.createTableVisiteSoin();

    // ACT
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

    // ASSERT
  });

  test('insertVisiteSoin', () async {
    // ARRANGE
    Query.dropTablePersonne();
    Query.dropTableVisite();
    Query.dropTableSoin();
    Query.dropTableVisiteSoin();

    Query.createTablePersonne();
    Query.createTableVisite();
    Query.createTableSoin();
    Query.createTableVisiteSoin();

    // ACT
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

    // ASSERT
  });

  test('updateVisiteDateTimePrevue', () async {
    // ARRANGE
    Query.dropTablePersonne();
    Query.dropTableVisite();
    Query.dropTableSoin();
    Query.dropTableVisiteSoin();

    Query.createTablePersonne();
    Query.createTableVisite();
    Query.createTableSoin();
    Query.createTableVisiteSoin();

    // ACT
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

    // ASSERT
  });

  test('updateVisiteDateTimeReelle', () async {
    // ARRANGE
    Query.dropTablePersonne();
    Query.dropTableVisite();
    Query.dropTableSoin();
    Query.dropTableVisiteSoin();

    Query.createTablePersonne();
    Query.createTableVisite();
    Query.createTableSoin();
    Query.createTableVisiteSoin();

    // ACT
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

    // ASSERT
  });

  test('updateVisiteDuree', () async {
    // ARRANGE
    Query.dropTablePersonne();
    Query.dropTableVisite();
    Query.dropTableSoin();
    Query.dropTableVisiteSoin();

    Query.createTablePersonne();
    Query.createTableVisite();
    Query.createTableSoin();
    Query.createTableVisiteSoin();

    // ACT
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

    // ASSERT
  });

  test('updateVisiteCompteRenduInfirmiere', () async {
    // ARRANGE
    Query.dropTablePersonne();
    Query.dropTableVisite();
    Query.dropTableSoin();
    Query.dropTableVisiteSoin();

    Query.createTablePersonne();
    Query.createTableVisite();
    Query.createTableSoin();
    Query.createTableVisiteSoin();

    // ACT
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

    // ASSERT
  });

  test('updateVisiteCompteRenduPatient', () async {
    // ARRANGE
    Query.dropTablePersonne();
    Query.dropTableVisite();
    Query.dropTableSoin();
    Query.dropTableVisiteSoin();

    Query.createTablePersonne();
    Query.createTableVisite();
    Query.createTableSoin();
    Query.createTableVisiteSoin();

    // ACT
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

    // ASSERT
  });

  test('insertVisiteByData', () async {
    // ARRANGE
    Query.dropTablePersonne();
    Query.dropTableVisite();
    Query.dropTableSoin();
    Query.dropTableVisiteSoin();

    Query.createTablePersonne();
    Query.createTableVisite();
    Query.createTableSoin();
    Query.createTableVisiteSoin();

    // ACT
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

    // ASSERT
  });

  test('insertSoinByData', () async {
    // ARRANGE
    Query.dropTablePersonne();
    Query.dropTableVisite();
    Query.dropTableSoin();
    Query.dropTableVisiteSoin();

    Query.createTablePersonne();
    Query.createTableVisite();
    Query.createTableSoin();
    Query.createTableVisiteSoin();

    // ACT
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

    // ASSERT
  });

  test('insertPersonneByData', () async {
    // ARRANGE
    Query.dropTablePersonne();
    Query.dropTableVisite();
    Query.dropTableSoin();
    Query.dropTableVisiteSoin();

    Query.createTablePersonne();
    Query.createTableVisite();
    Query.createTableSoin();
    Query.createTableVisiteSoin();

    // ACT
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

    // ASSERT
  });

  test('insertVisiteSoinByData', () async {
    // ARRANGE
    Query.dropTablePersonne();
    Query.dropTableVisite();
    Query.dropTableSoin();
    Query.dropTableVisiteSoin();

    Query.createTablePersonne();
    Query.createTableVisite();
    Query.createTableSoin();
    Query.createTableVisiteSoin();

    // ACT
    var data = {
      "id_visite": "1",
      "id_soin": "1",
      "id_categ_soins": "1",
      "id_type_soins": "1",
      "prevue": "1",
      "realise": "1",
    };
    Query.insertVisiteSoinByData(data);

    // ASSERT
  });

  test('selectPersonneByLoginAndPassword', () async {
    // ARRANGE
    Query.dropTablePersonne();
    Query.dropTableVisite();
    Query.dropTableSoin();
    Query.dropTableVisiteSoin();

    Query.createTablePersonne();
    Query.createTableVisite();
    Query.createTableSoin();
    Query.createTableVisiteSoin();

    // ACT
    Personne? personne = await Query.selectPersonneByLoginAndPassword('lwald', md5.convert(utf8.encode('lwald')).toString());
    var data = {
      "id": "1",
      "login": "lwald",
      "password": md5.convert(utf8.encode('lwald')).toString(),
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
    Personne? personne2 = await Query.selectPersonneByLoginAndPassword('lwald', md5.convert(utf8.encode('lwald')).toString());

    // ASSERT
    expect(personne, null);
    expect(personne2, isNotNull);
  });
}