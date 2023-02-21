import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';
import 'package:liemie_app/src/Db/Model/Visite.dart';
import 'package:liemie_app/src/Db/Query.dart';
import 'package:liemie_app/src/Db/Repository/VisiteRepository.dart';
import 'package:liemie_app/src/Pages/app.dart';
import 'package:liemie_app/src/Services/Http/QueryApi.dart';
import 'package:page_transition/page_transition.dart';

class Authentication
{
  static final Authentication _instance = Authentication._internal();

  factory Authentication() {
    return _instance;
  }

  Authentication._internal();

  static Future<Personne?> authenticate(String login, String password) async {
    try {
      Personne? infirmiere;

      final data = await QueryApi.getPersonneByLoginAndPassword(login, password);

      if(data != null) {
        if (data['status'] != 'false') {
          if (data != false) {
            initTable();

            data['login'] = login;
            data['password'] = md5.convert(utf8.encode(password)).toString();

            Query.insertPersonneByData(data);

            infirmiere = Personne.fromJson(data);
            //bool res = await QueryApi.getVisitesInfirmiere(infirmiere);
            List<Visite> visites = await Query.selectVisitesInfirmiere(infirmiere);
          } else {
            infirmiere = null;
          }
        } else {
          infirmiere = null;
        }
      } else {
        infirmiere = await Query.selectPersonneByLoginAndPassword(login, md5.convert(utf8.encode(password)).toString());
      }

      return infirmiere;
    } catch (e) {
      rethrow;
    }
  }

  static initTable() {
    Query.createTablePersonne();
    Query.createTableVisite();
    Query.createTableSoin();
    Query.createTableVisiteSoin();
  }
}