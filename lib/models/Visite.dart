import 'package:liemie_app/models/Personne.dart';

class Visite {
  final int id;
  final int patient;
  final int infirmiere;
  final DateTime date_prevue;
  final DateTime date_reelle;
  final double duree;
  final String compte_rendu_infirmiere;
  final String compte_rendu_patient;
  // final Personne personne;

  Visite(
    this.id,
    this.patient,
    this.infirmiere,
    this.date_prevue,
    this.date_reelle,
    this.duree,
    this.compte_rendu_infirmiere,
    this.compte_rendu_patient,
  );
}
