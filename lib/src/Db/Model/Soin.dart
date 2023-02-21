class Soin
{
  int id;
  String libel;
  String description;
  double coefficient;
  DateTime date;
  int idCategorieSoins;
  int idTypeSoins;

  Soin(
    this.id,
    this.libel,
    this.description,
    this.coefficient,
    this.date,
    this.idCategorieSoins,
    this.idTypeSoins,
  );

  factory Soin.fromJson(Map<String, dynamic> json) {
    return Soin(
      int.parse(json['id'].toString()),
      json['libel'].toString(),
      json['description'].toString(),
      double.parse(json['coefficient'].toString()),
      json['date'] == null ? DateTime.parse('0001-11-30') : json['date'].toString() == '' ? DateTime.parse('0001-11-30') : DateTime.parse(json['date'].toString()),
      int.parse(json['id_categ_soins'].toString()),
      int.parse(json['id_type_soins'].toString()),
    );
  }
}