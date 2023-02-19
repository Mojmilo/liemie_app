import 'package:flutter_test/flutter_test.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';
import 'package:liemie_app/src/Db/Model/Visite.dart';

void main() {
  test('VisiteFromJson', () {
    var json = {
      'id': 1,
      'date_prevue': '2020-01-01',
      'date_reelle': '2020-01-01',
      'duree': 1.0,
      'compte_rendu_infirmiere': 'compte_rendu_infirmiere',
      'compte_rendu_patient': 'compte_rendu_patient',
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

    Visite visite = Visite.fromJson(json, patient, infirmiere, []);

    expect(visite.id, 1);
  });
}