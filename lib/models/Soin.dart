import 'package:liemie_app/models/Personne.dart';

class Soin {
  final int idCategorieSoins;
  final int idTypeSoins;
  final int id;
  final String libel;
  final String description;
  final double coefficient;
  final DateTime date;
  static List<Soin> soins = [];

  Soin(
    this.idCategorieSoins,
    this.idTypeSoins,
    this.id,
    this.libel,
    this.description,
    this.coefficient,
    this.date,
  );

  factory Soin.fromJson(Map<String, dynamic> json) {
    return Soin(
      json['id_categ_soins'],
      json['id_type_soins'],
      json['id'],
      json['libel'],
      json['description'],
      json['coefficient'],
      DateTime.parse(json['date']),
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
