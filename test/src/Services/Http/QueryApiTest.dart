import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';
import 'package:liemie_app/src/Services/Http/QueryApi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  group('getPersonneByLoginAndPassword', () {
    test('invalidLoginAndPasswordWithNetwork', () async {
      // ARRANGE

      // ACT
      var data = await QueryApi.getPersonneByLoginAndPassword('test', 'test');

      // ASSERT
      expect(data, {'status': 'false'});
    });

    test('validLoginAndPasswordWithNetwork', () async {
      // ARRANGE

      // ACT
      var data = await QueryApi.getPersonneByLoginAndPassword('lwald', 'lwald');

      // ASSERT
      expect(data, {
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

    // test('getPersonneByLoginAndPasswordWithoutNetwork', () async {
    //   // ARRANGE
    //   // block network
    //
    //   // ACT
    //   var data = await QueryApi.getPersonneByLoginAndPassword('test', 'test');
    //
    //   // ASSERT
    //   expect(data, null);
    // });
  });

  group('getVisitesInfirmiere', () {
    test('getVisitesInfirmiereWithNetwork', () async {
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
      bool response = await QueryApi.getVisitesInfirmiere(personne);

      // ASSERT
      expect(response, true);
    });

    // test('getVisitesInfirmiereWithoutNetwork', () async {
    //   // ARRANGE
    //   // block network
    //
    //   // ACT
    //     Personne personne = Personne(
    //       1,
    //       'login',
    //       'password',
    //       'nom',
    //       'prenom',
    //       'sexe',
    //       DateTime.now(),
    //       DateTime.now(),
    //       'ad1',
    //       'ad2',
    //       'cp',
    //       'ville',
    //       'telFixe',
    //       'telPort',
    //       'mail',
    //     );
    //     bool response = await QueryApi.getVisitesInfirmiere(personne);
    //
    //   // ASSERT
    //   expect(response, false);
    // });
  });

  test('initTable', () async {
    // ARRANGE

    // ACT
    await QueryApi.initTable();

    // ASSERT
  });

  group('getSoins', () {
    test('getSoinsWithNetwork', () async {
      // ARRANGE

      // ACT
      bool response = await QueryApi.getSoins();

      // ASSERT
      expect(response, true);
    });

    // test('getSoinsWithoutNetwork', () async {
    //   // ARRANGE
    //   // block network
    //
    //   // ACT
    //   bool response = await QueryApi.getSoins();
    //
    //   // ASSERT
    //   expect(response, false);
    // });
  });

  group('getPersonneByIdPersonne', () {
    test('getPersonneByIdPersonneWithNetwork', () async {
      // ARRANGE

      // ACT
      bool response = await QueryApi.getPersonneByIdPersonne(3);

      // ASSERT
      expect(response, true);
    });

    // test('getPersonneByIdPersonneWithoutNetwork', () async {
    //   // ARRANGE
    //   // block network
    //
    //   // ACT
    //   bool response = await QueryApi.getPersonneByIdPersonne(3);
    //
    //   // ASSERT
    //   expect(response, false);
    // });
  });

  group('getVisiteSoinByIdVisite', () {
    test('getVisiteSoinByIdVisiteWithNetwork', () async {
      // ARRANGE

      // ACT
      bool response = await QueryApi.getVisiteSoinByIdVisite(8);

      // ASSERT
      expect(response, true);
    });

    // test('getVisiteSoinByIdVisiteWithoutNetwork', () async {
    //   // ARRANGE
    //   // block network
    //
    //   // ACT
    //   bool response = await QueryApi.getVisiteSoinByIdVisite(8);
    //
    //   // ASSERT
    //   expect(response, false);
    // });
  });
}