import 'package:flutter/material.dart';
import 'package:liemie_app/first.dart';
import 'package:liemie_app/profile.dart';
import 'package:liemie_app/services/Model.dart';
import 'package:page_transition/page_transition.dart';

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
    int id = int.parse(widget.arguments['id'].toString());
    String nom = widget.arguments['nom'];
    String prenom = widget.arguments['prenom'];
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFdedddb),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome back',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8fa1b7),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${prenom}',
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () async {
                    final json = await Model.getVisitesUser(id);
                    // print(json);
                  },
                  icon: const Icon(
                    Icons.import_export,
                    size: 40,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: ProfilePage(
                          arguments: widget.arguments,
                        ),
                        type: PageTransitionType.rightToLeft,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.menu,
                    size: 40,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Row(
                  children: const [
                    Text(
                      'Visite',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
