import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';
import 'package:liemie_app/src/Db/Model/Visite.dart';
import 'package:liemie_app/src/Db/Model/VisiteSoin.dart';
import 'package:liemie_app/src/Db/Query.dart';
import 'package:liemie_app/src/Db/Repository/VisiteRepository.dart';
import 'package:liemie_app/src/Db/Repository/VisiteSoinRepository.dart';
import 'package:liemie_app/src/Pages/login.dart';
import 'package:liemie_app/src/Services/Authentication.dart';
import 'package:liemie_app/src/Services/Http/QueryApi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  group('login', () {
    Query.dropTablePersonne();
    Query.dropTableVisite();
    Query.dropTableSoin();
    Query.dropTableVisiteSoin();

    Query.createTablePersonne();
    Query.createTableVisite();
    Query.createTableSoin();
    Query.createTableVisiteSoin();

    test('loginWithChargeApi', () async {
      // Arrange

      // Act
      Personne? infirmiere = await Authentication.authenticate('lwald', 'lwald');
      bool res = await QueryApi.getVisitesInfirmiere(infirmiere!);
      List<Visite> visites = await Query.selectVisitesInfirmiere(infirmiere);

      // Assert
      expect(infirmiere, isNotNull);
      expect(res, true);
      expect(visites.length, 8);

      // Act
      List<VisiteSoin> visiteSoins = await Query.selectVisiteSoinsByIdVisite(visites.first.id);

      // Assert
      expect(visiteSoins.length, 2);
    });

    test('loginWithoutChargeApi', () async {
      // Arrange

      // Act
      Personne? infirmiere = await Authentication.authenticate('lwald', 'lwald');
      List<Visite> visites = await Query.selectVisitesInfirmiere(infirmiere!);

      // Assert
      expect(infirmiere, isNotNull);
      expect(visites.length, 8);

      // Act
      List<VisiteSoin> visiteSoins = await Query.selectVisiteSoinsByIdVisite(visites.first.id);

      // Assert
      expect(visiteSoins.length, 2);
    });

    test('loginWithoutChargeApiGetInfosVisiteSoins', () async {
      // Arrange

      // Act
      Personne? infirmiere = await Authentication.authenticate('lwald', 'lwald');
      List<Visite> visites = await Query.selectVisitesInfirmiere(infirmiere!);

      // Assert
      expect(infirmiere, isNotNull);
      expect(visites.length, 8);

      // Act
      List<VisiteSoin> visiteSoins = await Query.selectVisiteSoinsByIdVisite(visites.first.id);
      bool isPrevu = visiteSoins.first.isPrevu;
      visiteSoins.first.isPrevu = false;
      await Query.updateVisiteSoinIsPrevu(visiteSoins.first);

      // Assert
      expect(isPrevu, true);

      // Act
      List<VisiteSoin> visiteSoins2 = await Query.selectVisiteSoinsByIdVisite(visites.first.id);
      bool isPrevu2 = visiteSoins2.first.isPrevu;

      // Assert
      expect(isPrevu2, false);
    });
  });
}

// TODO Voir problème liste VisiteSoin singleton qui pointe peut être sur la même liste