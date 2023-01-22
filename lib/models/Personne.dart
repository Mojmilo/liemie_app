class Personne {
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
  static List<Personne> personnes = [];

  Personne(
      this.id,
      this.nom,
      this.prenom,
      this.sexe,
      this.date_naiss,
      this.date_deces,
      this.ad1,
      this.ad2,
      this.cp,
      this.ville,
      this.tel_fixe,
      this.tel_port,
      this.mail);

  factory Personne.fromJson(Map<String, dynamic> json) {
    return Personne(
      json['id'],
      json['nom'],
      json['prenom'],
      json['sexe'],
      DateTime.parse(json['date_naiss']),
      DateTime.now(), // DateTime.parse(json['date_deces'])
      json['ad1'],
      json['ad2'].toString(),
      json['cp'],
      json['ville'],
      json['tel_fixe'].toString(),
      json['tel_port'],
      json['mail'],
    );
  }

  // static getPersonnes(List<dynamic> json) {
  //   List<Personne> personnes = [];
  //   for (var i = 0; i < json.length; i++) {
  //     personnes.add(Personne.fromJson(json[i]));
  //   }
  //   Personne.personnes = personnes;
  // }
}
