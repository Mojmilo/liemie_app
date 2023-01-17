import 'package:liemie_app/models/Personne.dart';
import 'package:liemie_app/models/Soin.dart';

class VisiteSoin {
  final int idVisite;
  final int idCategorieSoins;
  final int idTypeSoins;
  final int idSoins;
  final bool isPrevu;
  final bool isRealise;
  static List<VisiteSoin> visiteSoins = [];
  final Soin soin;

  VisiteSoin(
    this.idVisite,
    this.idCategorieSoins,
    this.idTypeSoins,
    this.idSoins,
    this.isPrevu,
    this.isRealise,
    this.soin,
  );

  factory VisiteSoin.fromJson(Map<String, dynamic> json, Soin soin) {
    return VisiteSoin(
      json['visite'],
      json['id_categ_soins'],
      json['id_type_soins'],
      json['id_soins'],
      json['prevu'] == 1 ? true : false,
      json['realise'] == 1 ? true : false,
      soin,
    );
  }

  // static getVisites(List<dynamic> json) {
  //   List<Visite> visites = [];
  //   for (var i = 0; i < json.length; i++) {
  //     visites.add(Visite.fromJson(json[i]));
  //   }
  //   Visite.visites = visites;
  // }
}
