import 'package:liemie_app/src/Db/Model/VisiteSoin.dart';
import 'package:liemie_app/src/Db/Query.dart';

class VisiteSoinRepository
{
  static final VisiteSoinRepository _visiteSoinRepository = VisiteSoinRepository._internal();
  static List<VisiteSoin> visiteSoins = [];

  factory VisiteSoinRepository() {
    return _visiteSoinRepository;
  }

  static add(VisiteSoin visiteSoin) {
    visiteSoins.add(visiteSoin);
  }

  static remove(VisiteSoin visiteSoin) {
    visiteSoins.remove(visiteSoin);
  }

  static setVisiteSoins(List<VisiteSoin> visiteSoins) {
    VisiteSoinRepository.visiteSoins = visiteSoins;
  }

  VisiteSoinRepository._internal();
}