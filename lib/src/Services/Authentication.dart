import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';
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

  static authenticate(String login, String password, context) async {
    bool res = false;
    try {
      final data = await QueryApi.getPersonneByLoginAndPassword(login, password);
      if (data['status'] != 'false') {
        if (data != false) {
          initTable();
          // Personne infirmiere = Query.selectPersonneByIdPersonne(data['id']);
          Personne infirmiere = Personne.fromJson(data);
          Query.selectVisitesInfirmiere(infirmiere);

          Navigator.push(
            context,
            PageTransition(
              child: AppPage(
                personne: infirmiere,
                visites: VisiteRepository.visites,
              ),
              type: PageTransitionType.fade,
            ),
          );

          data['login'] = login;
          data['password'] = md5.convert(utf8.encode(password)).toString();

          Query.insertPersonneByData(data);

          res = true;
        } else {
          res = false;
        }
      } else {
        res = false;
      }
    } catch (e) {
      Personne infirmiere = Query.selectPersonneByLoginAndPassword(login, md5.convert(utf8.encode(password)).toString());
      if (infirmiere != null) {

        Navigator.push(
          context,
          PageTransition(
            child: AppPage(
              personne: infirmiere,
              visites: VisiteRepository.visites,
            ),
            type: PageTransitionType.fade,
          ),
        );

        res = true;
      } else {
        res = false;
      }
    }
    return res;
  }

  static initTable() async {
    await Query.createTablePersonne();
    await Query.createTableVisite();
    await Query.createTableSoin();
    await Query.createTableVisiteSoin();
  }
}