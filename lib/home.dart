import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key);
  const HomePage({Key? key, required this.arguments}) : super(key: key);
  final Map arguments;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String id = widget.arguments['id'];
    String nom = widget.arguments['nom'];
    String prenom = widget.arguments['prenom'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liemie App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Id : ${id}',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Nom : ${nom}',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Prénom : ${prenom}',
            ),
          ],
        ),
      ),
    );
  }
}
