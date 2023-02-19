import 'package:flutter_test/flutter_test.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';
import 'package:liemie_app/src/Db/Model/Soin.dart';
import 'package:liemie_app/src/Db/Model/Visite.dart';
import 'package:liemie_app/src/Db/Model/VisiteSoin.dart';
import 'package:liemie_app/src/Db/Repository/VisiteSoinRepository.dart';

void main() {
  test('addVisiteSoin', () {
    expect(VisiteSoinRepository.visiteSoins.length, 0);

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

    VisiteSoinRepository.add(visiteSoin);
    expect(VisiteSoinRepository.visiteSoins.length, 1);
  });

  test('setVisiteSoins', () {
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

    VisiteSoinRepository.add(visiteSoin);
    List<VisiteSoin> visiteSoins = [];
    VisiteSoinRepository.setVisiteSoins(visiteSoins);
    expect(VisiteSoinRepository.visiteSoins.length, 0);
    visiteSoins.add(visiteSoin);
    VisiteSoinRepository.setVisiteSoins(visiteSoins);
    expect(VisiteSoinRepository.visiteSoins.length, 1);
  });
}