import 'package:flutter_test/flutter_test.dart';
import 'package:liemie_app/src/Db/Model/Soin.dart';

void main() {
  test('SoinFromJson', () {
    var json = {
      'id': 1,
      'libel': 'libel',
      'description': 'description',
      'coefficient': 1.0,
      'date': '2020-01-01',
      'id_categ_soins': 1,
      'id_type_soins': 1,
    };
    Soin soin = Soin.fromJson(json);

    expect(soin.id, 1);
  });
}