import 'package:flutter_test/flutter_test.dart';
import 'package:liemie_app/src/Db/Connection.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  test('loadConnection', () async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    final Database db = await Connection.load();
    expect(db, isNotNull);
  });
}