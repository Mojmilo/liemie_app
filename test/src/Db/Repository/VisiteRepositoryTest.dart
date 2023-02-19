import 'package:flutter_test/flutter_test.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';
import 'package:liemie_app/src/Db/Model/Visite.dart';
import 'package:liemie_app/src/Db/Repository/VisiteRepository.dart';

void main() {
  test('addVisite', () {
    expect(VisiteRepository.visites.length, 0);

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

    VisiteRepository.add(visite);
    expect(VisiteRepository.visites.length, 1);
  });

  test('setVisites', () {
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

    VisiteRepository.add(visite);
    List<Visite> visites = [];
    VisiteRepository.setVisites(visites);
    expect(VisiteRepository.visites.length, 0);
    visites.add(visite);
    VisiteRepository.setVisites(visites);
    expect(VisiteRepository.visites.length, 1);
  });
}