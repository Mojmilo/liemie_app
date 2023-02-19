import 'package:flutter_test/flutter_test.dart';
import 'package:liemie_app/src/Db/Model/Soin.dart';
import 'package:liemie_app/src/Db/Repository/SoinRepository.dart';

void main() {
  test('addSoin', () {
    expect(SoinRepository.soins.length, 0);
    Soin soin = Soin(
      1,
      'libel',
      'description',
      1.0,
      DateTime.now(),
      1,
      1,
    );
    SoinRepository.add(soin);
    expect(SoinRepository.soins.length, 1);
  });

  test('setSoins', () {
    Soin soin = Soin(
      1,
      'libel',
      'description',
      1.0,
      DateTime.now(),
      1,
      1,
    );
    SoinRepository.add(soin);
    List<Soin> soins = [];
    SoinRepository.setSoins(soins);
    expect(SoinRepository.soins.length, 0);
    soins.add(soin);
    SoinRepository.setSoins(soins);
    expect(SoinRepository.soins.length, 1);
  });
}