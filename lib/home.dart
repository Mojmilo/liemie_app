import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final visites = [];
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
                    setState(() {
                      visites.clear();
                      visites.addAll(json);
                    });
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Upcoming visits',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        size: 30,
                        color: Color(0xFF1c50a7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      visites.length,
                      (index) => visit(context, visite: visites[index]),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget visit(BuildContext context, {required Map visite}) {
  print(visite);
  return Container(
    margin: const EdgeInsets.only(right: 20),
    padding: const EdgeInsets.symmetric(
      horizontal: 25,
      vertical: 25,
    ),
    width: 170,
    height: 220,
    decoration: BoxDecoration(
      color: const Color(0xFF1c50a7),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFdedddb),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: const Color(0xFF1e79d6),
                  width: 3,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  // '5:45PM',
                  '${DateTime.parse(visite['date_prevue']).hour}:${DateTime.parse(visite['date_prevue']).minute}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  // 'Dec 7',
                  '${DateFormat.MMM().format(DateTime.parse(visite['date_prevue']))} ${DateTime.parse(visite['date_prevue']).day}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Michael',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Simpson',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Show more'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                // backgroundColor: const Color(0xFF32dba9),
                primary: const Color(0xFF32dba9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
