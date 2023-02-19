import 'package:flutter_test/flutter_test.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';
import 'package:liemie_app/src/Db/Repository/PersonneRepository.dart';

void main() {
  test('addPersonne', () {
    expect(PersonneRepository.personnes.length, 0);
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
    PersonneRepository.add(personne);
    expect(PersonneRepository.personnes.length, 1);
  });

  test('setVisites', () {
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
    PersonneRepository.add(personne);
    List<Personne> personnes = [];
    PersonneRepository.setVisites(personnes);
    expect(PersonneRepository.personnes.length, 0);
    personnes.add(personne);
    PersonneRepository.setVisites(personnes);
    expect(PersonneRepository.personnes.length, 1);
  });
}