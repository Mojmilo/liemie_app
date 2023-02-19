import 'package:liemie_app/src/Db/Model/Soin.dart';

class SoinRepository
{
  static final SoinRepository _soinRepository = SoinRepository._internal();
  static List<Soin> soins = [];

  factory SoinRepository() {
    return _soinRepository;
  }

  static add(Soin soin) {
    soins.add(soin);
  }

  static setSoins(List<Soin> soins) {
    SoinRepository.soins = soins;
  }

  SoinRepository._internal();
}