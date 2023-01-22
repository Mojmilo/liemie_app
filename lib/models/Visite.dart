import 'package:liemie_app/models/Personne.dart';
import 'package:liemie_app/models/VisiteSoin.dart';
import 'package:liemie_app/services/Model.dart';

class Visite {
  int id;
  final int idPatient;
  final int idInfirmiere;
  DateTime date_prevue;
  DateTime date_reelle;
  double duree;
  String compte_rendu_infirmiere;
  String compte_rendu_patient;
  // final Personne personne;
  static List<Visite> visites = [];
  final Personne patient;
  final List<VisiteSoin> visiteSoins;

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
    this.visiteSoins,
  );

  factory Visite.fromJson(Map<String, dynamic> json, Personne personne,
      List<VisiteSoin> visiteSoins) {
    return Visite(
      json['id'],
      json['patient'],
      json['infirmiere'],
      DateTime.parse(json['date_prevue'].toString()),
      DateTime.parse(json['date_reelle'].toString()),
      double.parse(json['duree'].toString()),
      json['compte_rendu_infirmiere'],
      json['compte_rendu_patient'],
      personne,
      visiteSoins,
    );
  }

  // static getVisites(List<dynamic> json) {
  //   List<Visite> visites = [];
  //   for (var i = 0; i < json.length; i++) {
  //     visites.add(Visite.fromJson(json[i]));
  //   }
  //   Visite.visites = visites;
  // }

  setDateTimePrevue(DateTime date_prevue) {
    this.date_prevue = date_prevue;
    Model.setDateTimePrevue(this.id, this.date_prevue);
  }

  setDateTimeReelle(DateTime date_reelle) {
    this.date_reelle = date_reelle;
    Model.setDateTimeReelle(this.id, this.date_reelle);
  }

  setDuree(double duree) {
    this.duree = duree;
    Model.setDuree(this.id, this.duree);
  }

  setCompteRenduInfirmiere(String compte_rendu_infirmiere) {
    this.compte_rendu_infirmiere = compte_rendu_infirmiere;
    Model.setCompteRenduInfirmiere(this.id, this.compte_rendu_infirmiere);
  }

  setCompteRenduPatient(String compte_rendu_patient) {
    this.compte_rendu_patient = compte_rendu_patient;
    Model.setCompteRenduPatient(this.id, this.compte_rendu_patient);
  }

  addVisite() {
    Model.addVisite(this);
  }
}
