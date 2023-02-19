import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';
import 'package:liemie_app/src/Db/Model/Visite.dart';
import 'package:liemie_app/src/Db/Query.dart';
import 'package:liemie_app/src/Db/Repository/VisiteRepository.dart';
import 'package:liemie_app/src/Pages/patient.dart';
import 'package:liemie_app/src/Pages/profile.dart';
import 'package:liemie_app/src/Pages/visite.dart';
import 'package:liemie_app/src/Services/Http/QueryApi.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.personne, required this.visites})
      : super(key: key);
  final Personne personne;
  final List<Visite> visites;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexItem = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
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
                        '${widget.personne.prenom}',
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
                  // final json = await Model.getVisitesUser(id);
                  // setState(() {
                  //   visites.clear();
                  //   visites.addAll(json);
                  // });
                  QueryApi.getVisitesInfirmiere(widget.personne);
                  Query.selectVisitesInfirmiere(widget.personne);
                  setState(() {
                    widget.visites.clear();
                    widget.visites.addAll(VisiteRepository.visites);
                  });
                  // Navigator.of(context).pushAndRemoveUntil(
                  //   MaterialPageRoute(
                  //     builder: (context) => FirstPage(),
                  //   ),
                  //   (route) => false,
                  // );
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
                        personne: widget.personne,
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
                    // visites.length,
                    widget.visites.length,
                    (index) => visit(context,
                        // visite: visites[index],
                        personne: widget.personne,
                        visite: widget.visites[index],
                        isFirst: index > 0 ? false : true),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget visit(BuildContext context,
//     {required Map visite, required bool isFirst}) {
Widget visit(BuildContext context,
    {required Personne personne,
    required Visite visite,
    required bool isFirst}) {
  // print(visite);
  return ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        PageTransition(
          child: VisitePage(
            personne: personne,
            visite: visite,
          ),
          type: PageTransitionType.bottomToTop,
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 25,
      ),
      width: 170,
      height: 220,
      decoration: BoxDecoration(
        color: const {
          true: Color(0xFF1c50a7),
          false: Color(0xFFdcedff),
        }[isFirst],
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
                    // '${DateTime.parse(visite['date_prevue']).hour}:${DateTime.parse(visite['date_prevue']).minute}',
                    '${visite.datePrevue.hour}:${visite.datePrevue.minute}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: const {
                        true: Color(0xFFffffff),
                        false: Color(0xFF32dba9),
                      }[isFirst],
                    ),
                  ),
                  Text(
                    // 'Dec 7',
                    // '${DateFormat.MMM().format(DateTime.parse(visite['date_prevue']))} ${DateTime.parse(visite['date_prevue']).day}',
                    '${DateFormat.MMM().format(visite.datePrevue)} ${visite.datePrevue.day}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const {
                        true: Color(0xFFffffff),
                        false: Color(0xFF8fa1b7),
                      }[isFirst],
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
                    children: [
                      Text(
                        // 'Michael',
                        // '${visite['prenom']}',
                        '${visite.patient.prenom}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const {
                            true: Color(0xFFffffff),
                            false: Color(0xFF000000),
                          }[isFirst],
                        ),
                      ),
                      Text(
                        // 'Simpson',
                        // '${visite['nom']}',
                        '${visite.patient.nom}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const {
                            true: Color(0xFFffffff),
                            false: Color(0xFF000000),
                          }[isFirst],
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
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: PatientPage(
                        patient: visite.patient,
                      ),
                      type: PageTransitionType.bottomToTop,
                    ),
                  );
                },
                child: Text('Show patient',
                    style: TextStyle(
                        color: const {
                      true: Color(0xFFffffff),
                      false: Color(0xFF1c50a7),
                    }[isFirst])),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  // backgroundColor: const Color(0xFF32dba9),
                  primary: const {
                    true: Color(0xFF32dba9),
                    false: Color(0xFFffffff),
                  }[isFirst],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(0),
      primary: const Color(0xFFffffff),
      elevation: 0,
      shadowColor: Colors.transparent,
    ),
  );
}
