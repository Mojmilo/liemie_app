import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';
import 'package:liemie_app/src/Db/Query.dart';
import 'package:liemie_app/src/Services/Authentication.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  group('authenticate', () {
    test('authenticateWithNetwork', () async {
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
      Personne? personne = await Authentication.authenticate('test', 'test');
      Personne? personne2 = await Authentication.authenticate('lwald', 'lwald');

      // ASSERT
      expect(personne, null);
      expect(personne2, isNotNull);
    });

    // test('authenticateWithoutNetwork', () async {
    //   // ARRANGE
    //   // block network
    //   Query.dropTablePersonne();
    //   Query.dropTableVisite();
    //   Query.dropTableSoin();
    //   Query.dropTableVisiteSoin();
    //
    //   Query.createTablePersonne();
    //   Query.createTableVisite();
    //   Query.createTableSoin();
    //   Query.createTableVisiteSoin();
    //
    //   // ACT
    //   Personne? personne = await Authentication.authenticate('test', 'test');
    //   var data = {
    //     "id": "1",
    //     "login": "lwald",
    //     "password": md5.convert(utf8.encode("lwald")).toString(),
    //     "nom": "Lagaffe",
    //     "prenom": "Gaston",
    //     "sexe": "H",
    //     "date_naiss": "",
    //     "date_deces": "",
    //     "ad1": "",
    //     "ad2": "",
    //     "cp": "",
    //     "ville": "",
    //     "tel_fixe": "",
    //     "tel_port": "",
    //     "mail": ""
    //   };
    //   Query.insertPersonneByData(data);
    //   Personne? personne2 = await Authentication.authenticate('lwald', 'lwald');
    //
    //   // ASSERT
    //   expect(personne, null);
    //   expect(personne2, isNotNull);
    // });
  });

  test('initTable', () async {
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
    Authentication.initTable();

    // ASSERT
  });
}