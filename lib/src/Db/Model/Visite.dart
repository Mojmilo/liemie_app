import 'package:liemie_app/src/Db/Model/Personne.dart';
import 'package:liemie_app/src/Db/Model/VisiteSoin.dart';
import 'package:liemie_app/src/Db/Query.dart';

class Visite
{
  int id;
  Personne patient;
  Personne infirmiere;
  DateTime datePrevue;
  DateTime dateReelle;
  double duree;
  String compteRenduInfirmiere;
  String compteRenduPatient;
  List<VisiteSoin> visiteSoins;

  Visite(
    this.id,
    this.patient,
    this.infirmiere,
    this.datePrevue,
    this.dateReelle,
    this.duree,
    this.compteRenduInfirmiere,
    this.compteRenduPatient,
    this.visiteSoins,
  );

  factory Visite.fromJson(Map<String, dynamic> json, Personne patient, Personne infirmiere, List<VisiteSoin> visiteSoins) {
    return Visite(
      json['id'],
      patient,
      infirmiere,
      DateTime.parse(json['date_prevue'].toString()),
      DateTime.parse(json['date_reelle'].toString()),
      double.parse(json['duree'].toString()),
      json['compte_rendu_infirmiere'],
      json['compte_rendu_patient'],
      visiteSoins,
    );
  }

  void setDateTimePrevue(DateTime datePrevue) {
    this.datePrevue = datePrevue;
    Query.updateVisiteDateTimePrevue(this, datePrevue);
  }

  void setDateTimeReelle(DateTime dateReelle) {
    this.dateReelle = dateReelle;
    Query.updateVisiteDateTimeReelle(this, dateReelle);
  }

  void setDuree(double duree) {
    this.duree = duree;
    Query.updateVisiteDuree(this, duree);
  }

  void setCompteRenduInfirmiere(String compteRenduInfirmiere) {
    this.compteRenduInfirmiere = compteRenduInfirmiere;
    Query.updateVisiteCompteRenduInfirmiere(this, compteRenduInfirmiere);
  }

  void setCompteRenduPatient(String compteRenduPatient) {
    this.compteRenduPatient = compteRenduPatient;
    Query.updateVisiteCompteRenduPatient(this, compteRenduPatient);
  }
}