class Visite {
  final int id;
  final String nom;
  final String prenom;
  final String sexe;
  final DateTime date_naiss;
  final DateTime date_deces;
  final String ad1;
  final String ad2;
  final String cp;
  final String ville;
  final String tel_fixe;
  final String tel_port;
  final String mail;

  Visite(this.id, this.nom, this.prenom, this.sexe, this.date_naiss,
      this.date_deces, this.ad1, this.ad2, this.cp, this.ville, this.tel_fixe,
      this.tel_port, this.mail);
}