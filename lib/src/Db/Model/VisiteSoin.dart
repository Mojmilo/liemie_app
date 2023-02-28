import 'package:liemie_app/src/Db/Model/Soin.dart';
import 'package:liemie_app/src/Db/Model/Visite.dart';
import 'package:liemie_app/src/Db/Query.dart';
import 'package:liemie_app/src/Db/Repository/VisiteSoinRepository.dart';

class VisiteSoin
{
  Visite visite;
  Soin soin;
  int idCategorieSoins;
  int idTypeSoins;
  bool isPrevu;
  bool isRealise;

  VisiteSoin(this.visite, this.soin, this.idCategorieSoins, this.idTypeSoins, this.isPrevu, this.isRealise);

  factory VisiteSoin.fromJson(Map<String, dynamic> json, Visite visite, Soin soin) {
    return VisiteSoin(
      visite,
      soin,
      json['id_categ_soins'],
      json['id_type_soins'],
      json['prevu'] == 1 ? true : false,
      json['realise'] == 1 ? true : false,
    );
  }

  void setIsRealise(bool isRealise) {
    this.isRealise = isRealise;
    Query.updateVisiteSoinIsRealise(this);
  }

  void setIsPrevu(bool isPrevu) {
    this.isPrevu = isPrevu;
    Query.updateVisiteSoinIsPrevu(this);
  }

  static addVisiteSoin(Visite visite, Soin soin) {
    VisiteSoin visiteSoin = VisiteSoin(
      visite,
      soin,
      soin.idCategorieSoins,
      soin.idTypeSoins,
      false,
      true,
    );
    VisiteSoinRepository.add(visiteSoin);
    visite.visiteSoins.add(visiteSoin);
    Query.insertVisiteSoin(visiteSoin);
  }

  static removeVisiteSoin(VisiteSoin visiteSoin) {
    VisiteSoinRepository.remove(visiteSoin);
    visiteSoin.visite.visiteSoins.remove(visiteSoin);
    Query.deleteVisiteSoin(visiteSoin);
  }
}