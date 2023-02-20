import 'package:flutter_test/flutter_test.dart';
import 'package:liemie_app/src/Db/Connection.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  test('loadConnection', () async {
    final Database db = await Connection.database;
    expect(db, isNotNull);
  });
}