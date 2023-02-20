import 'package:flutter_test/flutter_test.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';
import 'package:liemie_app/src/Services/Http/QueryApi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  test('getPersonneByLoginAndPassword', () async {
    var data = await QueryApi.getPersonneByLoginAndPassword('test', 'test');
    expect(data, {'status': 'false'});

    var data2 = await QueryApi.getPersonneByLoginAndPassword('lwald', 'lwald');
    expect(data2, {
      'id': '3',
      'nom': 'lwald',
      'prenom': 'lwald',
      'sexe': 'F',
      'date_naiss': '2019-10-20',
      'date_deces': null,
      'ad1': '',
      'ad2': null,
      'cp': '0',
      'ville': '',
      'tel_fixe': '0101010101',
      'tel_port': '0606060606',
      'mail': 'Jeanne@spirou.fr'
    });
  });

  test('getVisitesInfirmiere', () async {
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

    bool response = await QueryApi.getVisitesInfirmiere(personne);
    expect(response, true);
  });

  test('initTable', () async {
    await QueryApi.initTable();
  });

  test('getSoins', () async {
    bool response = await QueryApi.getSoins();
    expect(response, true);
  });

  test('getPersonneByIdPersonne', () async {
    bool response = await QueryApi.getPersonneByIdPersonne(3);
    expect(response, true);
  });

  test('getVisiteSoinByIdVisite', () async {
    bool response = await QueryApi.getVisiteSoinByIdVisite(8);
    expect(response, true);
  });
}