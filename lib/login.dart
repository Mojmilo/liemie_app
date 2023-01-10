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
      backgroundColor: Color(0xFF1c50a7),
      body: Form(
        key: _formKey,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 150,
              ),
              const Text(
                'Hello,',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF32dba9),
                ),
              ),
              const Text(
                'Login now.',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFffffff),
                ),
              ),
              const Text(
                'Welcome back. Please fill in the form to sign in and continue.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8fa1b7),
                  height: 2,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                child: TextFormField(
                  style: const TextStyle(
                    color: Color(0xFFffffff),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 2,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(
                      bottom: 20,
                    ),
                    labelText: 'Login',
                    labelStyle: TextStyle(
                      color: Color(0xFF8fa1b7),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    floatingLabelStyle: TextStyle(
                      color: Color(0xFF32dba9),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF8fa1b7),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF32dba9),
                      ),
                    ),
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
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: TextFormField(
                  obscureText: true,
                  obscuringCharacter: '*',
                  style: const TextStyle(
                    color: Color(0xFFffffff),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 2,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(
                      bottom: 20,
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Color(0xFF8fa1b7),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    floatingLabelStyle: TextStyle(
                      color: Color(0xFF32dba9),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF8fa1b7),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF32dba9),
                      ),
                    ),
                    suffixIcon: Icon(
                      Icons.visibility,
                      color: Color(0xFF8fa1b7),
                    ),
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
                          fontSize: 15,
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
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var res = await testConnexion(login, password, context);
                    setState(() {
                      isLogged = res;
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Text('Login', style: TextStyle(fontSize: 15)),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF01b693),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.all(7),
                      child: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF32dba9),
                  // shape: const CircleBorder(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.all(15),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Pour revenir en arrière.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFffffff),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Retour',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF32dba9),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
