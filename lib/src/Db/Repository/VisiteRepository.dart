import 'package:liemie_app/src/Db/Model/Visite.dart';

class VisiteRepository
{
  static final VisiteRepository _visiteRepository = VisiteRepository._internal();
  static List<Visite> visites = [];

  factory VisiteRepository() {
    return _visiteRepository;
  }

  static add(Visite visite) {
    visites.add(visite);
  }

  static setVisites(List<Visite> visites) {
    VisiteRepository.visites = visites;
  }

  VisiteRepository._internal();
}