import 'package:liemie_app/src/Db/Model/VisiteSoin.dart';

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

  static setVisites(List<VisiteSoin> visiteSoins) {
    VisiteSoinRepository.visiteSoins = visiteSoins;
  }

  VisiteSoinRepository._internal();
}