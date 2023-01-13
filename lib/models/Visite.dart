import 'package:liemie_app/models/Personne.dart';

class Visite {
  final int id;
  final int idPatient;
  final int idInfirmiere;
  final DateTime date_prevue;
  final DateTime date_reelle;
  final double duree;
  final String compte_rendu_infirmiere;
  final String compte_rendu_patient;
  // final Personne personne;
  static List<Visite> visites = [];
  final Personne patient;

  Visite(
    this.id,
    this.idPatient,
    this.idInfirmiere,
    this.date_prevue,
    this.date_reelle,
    this.duree,
    this.compte_rendu_infirmiere,
    this.compte_rendu_patient,
    this.patient,
  );

  factory Visite.fromJson(Map<String, dynamic> json, Personne personne) {
    return Visite(
      json['id'],
      json['patient'],
      json['infirmiere'],
      DateTime.parse(json['date_prevue']),
      DateTime.parse(json['date_reelle']),
      json['duree'],
      json['compte_rendu_infirmiere'],
      json['compte_rendu_patient'],
      personne,
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
