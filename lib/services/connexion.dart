import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:liemie_app/home.dart';

testConnexion(String login, String password, context) async {
  final String url =
      'https://www.btssio-carcouet.fr/ppe4/public/connect2/${login}/${password}/infirmiere';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    if (json['status'] != 'false') {
      // return json;
      if (json != false) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => HomePage(
              arguments: {'login': login, 'password': password},
            ),
          ),
          (route) => false,
        );
      }
    } else {
      // return false;
    }
  } else {
    // throw Exception('Failed to load data');
  }
}
