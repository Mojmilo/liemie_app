import 'package:flutter/material.dart';
import 'package:liemie_app/first.dart';
import 'package:liemie_app/home.dart';
import 'package:page_transition/page_transition.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.arguments}) : super(key: key);
  final Map arguments;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    int id = int.parse(widget.arguments['id'].toString());
    String nom = widget.arguments['nom'];
    String prenom = widget.arguments['prenom'];
    String sexe = widget.arguments['sexe'];
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 40,
                    color: Color(0xFF1c50a7),
                  ),
                ),
                const Text(
                  'Profile details',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: const Color(0xFFdcedff),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFdedddb),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: const Color(0xFFffffff),
                        width: 4,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${prenom} ${nom}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      (() {
                        if (sexe == 'H') {
                          return const Text(
                            'Male',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8fa1b7),
                            ),
                          );
                        } else {
                          if (sexe == 'F') {
                            return const Text(
                              'Female',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8fa1b7),
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        }
                      }()),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => FirstPage(),
                  ),
                  (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
