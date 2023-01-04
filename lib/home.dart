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
    String login = widget.arguments['login'];
    String password = widget.arguments['password'];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liemie App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              // 'Login :',
              'Login : ${login}',
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Password : ${password}',
            ),
          ],
        ),
      ),
    );
  }
}
