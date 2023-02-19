class Personne
{
  int id;
  String login = '';
  String password = '';
  String nom;
  String prenom;
  String sexe;
  DateTime dateNaiss;
  DateTime dateDeces;
  String ad1;
  String ad2;
  String cp;
  String ville;
  String telFixe;
  String telPort;
  String mail;

  Personne(
    this.id,
    this.login,
    this.password,
    this.nom,
    this.prenom,
    this.sexe,
    this.dateNaiss,
    this.dateDeces,
    this.ad1,
    this.ad2,
    this.cp,
    this.ville,
    this.telFixe,
    this.telPort,
    this.mail,
  );

  factory Personne.fromJson(Map<String, dynamic> json) {
    return Personne(
      int.parse(json['id'].toString()),
      json['login'].toString(),
      json['password'].toString(),
      json['nom'].toString(),
      json['prenom'].toString(),
      json['sexe'].toString(),
      json['date_deces'] == null ? DateTime.parse('0001-00-00') : DateTime.parse(json['date_naiss'].toString()),
      json['date_deces'] == null ? DateTime.parse('0001-00-00') : DateTime.parse(json['date_deces'].toString()),
      json['ad1'].toString(),
      json['ad2'].toString(),
      json['cp'].toString(),
      json['ville'].toString(),
      json['tel_fixe'].toString(),
      json['tel_port'].toString(),
      json['mail'].toString(),
    );
  }
}