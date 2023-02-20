import 'dart:convert';
import 'dart:io';

import 'package:liemie_app/src/Db/Model/Personne.dart';
import 'package:http/http.dart' as http;
import 'package:liemie_app/src/Db/Query.dart';

class QueryApi
{
  static final QueryApi _instance = QueryApi._internal();

  factory QueryApi() {
    return _instance;
  }

  QueryApi._internal();

  static getPersonneByLoginAndPassword(String login, String password) async {
    try {
      Map<String, dynamic>? data;
      try {
        Uri url = Uri.parse('https://www.btssio-carcouet.fr/ppe4/public/connect2/${login}/${password}/infirmiere');
        final response = await http.get(url);
        data = json.decode(response.body);
      } on SocketException catch (e) {
        data = null;
      }
      return data;
    } catch (e) {
      rethrow;
    }
  }

  static getVisitesInfirmiere(Personne infirmiere) async {
    try {
      bool res = false;

      try {
        Uri url = Uri.parse('https://www.btssio-carcouet.fr/ppe4/public/mesvisites/${infirmiere.id}');
        var data = [];
        final response = await http.get(url);
        data = json.decode(response.body);

        initTable();
        await Query.deleteVisiteSoinByPersonne(infirmiere);
        await Query.deleteVisiteByPersonne(infirmiere);

        await getSoins();

        for (var i = 0; i < data.length; i++) {
          Query.insertVisiteByData(data[i]);
          await getPersonneByIdPersonne(int.parse(data[i]['patient']));
          await getVisiteSoinByIdVisite(int.parse(data[i]['id']));
        }

        res = true;
      } on SocketException catch (e) {
        res = false;
      }

      return res;
    } catch (e) {
      rethrow;
    }
  }

  static initTable() async {
    await Query.createTablePersonne();
    await Query.createTableVisite();
    await Query.createTableSoin();
    await Query.createTableVisiteSoin();
  }

  static getSoins() async {
    try {
      bool res = false;
      try {
        Uri url = Uri.parse('https://www.btssio-carcouet.fr/ppe4/public/soins/');
        var data = [];
        final response = await http.get(url);
        data = json.decode(response.body);

        for (var i = 0; i < data.length; i++) {
          Query.insertSoinByData(data[i]);
        }
        res = true;
      } on SocketException catch (e) {
        res = false;
      }
      return res;
    } catch (e) {
      rethrow;
    }
  }

  static getPersonneByIdPersonne(int idPersonne) async {
    try {
      bool res = false;
      try {
        Uri url = Uri.parse('https://www.btssio-carcouet.fr/ppe4/public/personne/${idPersonne}');
        var data = [];
        final response = await http.get(url);
        data = json.decode(response.body);

        for (var i = 0; i < data.length; i++) {
          Query.insertPersonneByData(data[i]);
        }
        res = true;
      } on SocketException catch (e) {
        res = false;
      }
      return res;
    } catch (e) {
      rethrow;
    }
  }

  static getVisiteSoinByIdVisite(int idVisite) async {
    try {
      bool res = false;
      try {
        Uri url = Uri.parse('https://www.btssio-carcouet.fr/ppe4/public/visitesoins/${idVisite}');
        var data = [];
        final response = await http.get(url);
        data = json.decode(response.body);

        for (var i = 0; i < data.length; i++) {
          var newData = {
            'id_visite': data[i]['visite'],
            'id_soin': data[i]['id_soins'],
            'id_categ_soins': data[i]['id_categ_soins'],
            'id_type_soins': data[i]['id_type_soins'],
            'prevue': data[i]['prevu'],
            'realise': data[i]['realise'],
          };

          Query.insertVisiteSoinByData(newData);
        }
        res = true;
      } on SocketException catch (e) {
        res = false;
      }
      return res;
    } catch (e) {
      rethrow;
    }
  }
}