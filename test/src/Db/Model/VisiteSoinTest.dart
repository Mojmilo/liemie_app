import 'package:flutter_test/flutter_test.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';
import 'package:liemie_app/src/Db/Model/Soin.dart';
import 'package:liemie_app/src/Db/Model/Visite.dart';
import 'package:liemie_app/src/Db/Model/VisiteSoin.dart';

void main() {
  test('VisiteSoinFromJson', () {
    var json = {
      'id': 1,
      'libel': 'libel',
      'description': 'description',
      'coefficient': 1.0,
      'date': '2020-01-01',
      'id_categ_soins': 1,
      'id_type_soins': 1,
    };

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

    VisiteSoin visiteSoin = VisiteSoin.fromJson(json, visite, soin);

    expect(visiteSoin.visite.id, 1);
    expect(visiteSoin.soin.id, 1);
  });
}