import 'package:liemie_app/src/Db/Model/Personne.dart';

class PersonneRepository
{
  static final PersonneRepository _personneRepository = PersonneRepository._internal();
  static List<Personne> personnes = [];

  factory PersonneRepository() {
    return _personneRepository;
  }

  static add(Personne personne) {
    personnes.add(personne);
  }

  static setVisites(List<Personne> personne) {
    PersonneRepository.personnes = personne;
  }

  PersonneRepository._internal();
}