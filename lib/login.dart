import 'package:flutter/material.dart';
import 'package:liemie_app/home.dart';
import 'package:liemie_app/services/connexion.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLogged = true;
  @override
  Widget build(BuildContext context) {
    String login = '';
    String password = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liemie App'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Login :',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 200,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a login';
                        } else {
                          login = value;
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          isLogged = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Password :',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 200,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a password';
                        } else {
                          password = value;
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          isLogged = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              (() {
                if (isLogged == false) {
                  return Column(
                    children: const <Widget>[
                      Text(
                        'Invalid login or password',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                } else {
                  return const SizedBox(
                    height: 0,
                  );
                }
              }()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var res = await testConnexion(login, password, context);
                        setState(() {
                          isLogged = res;
                        });
                      }
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
