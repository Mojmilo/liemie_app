import 'package:flutter_test/flutter_test.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';
import 'package:liemie_app/src/Services/Authentication.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  test('authenticate', () async {
    Personne? personne = await Authentication.authenticate('test', 'test');
    expect(personne, null);

    Personne? personne2 = await Authentication.authenticate('lwald', 'lwald');
    expect(personne2, isNotNull);
  });
}