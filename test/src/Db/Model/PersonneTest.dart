import 'package:flutter_test/flutter_test.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';

void main() {
  test('personneFromJson', () {
    var json = {
      "id": 1,
      "login": "login",
      "password": "password",
      "nom": "nom",
      "prenom": "prenom",
      "sexe": "sexe",
      "date_naiss": "2020-01-01 00:00:00",
      "date_deces": "2020-01-01 00:00:00",
      "ad1": "ad1",
      "ad2": "ad2",
      "cp": "cp",
      "ville": "ville",
      "tel_fixe": "telFixe",
      "tel_port": "telPort",
      "mail": "mail",
      };
    Personne personne = Personne.fromJson(json);

    expect(personne.id, 1);
  });
}