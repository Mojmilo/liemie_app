import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liemie_app/first.dart';
import 'package:liemie_app/home.dart';
import 'package:liemie_app/models/Personne.dart';
import 'package:liemie_app/models/Soin.dart';
import 'package:liemie_app/models/Visite.dart';
import 'package:liemie_app/models/VisiteSoin.dart';
import 'package:liemie_app/newVisite.dart';
import 'package:liemie_app/patient.dart';
import 'package:liemie_app/profile.dart';
import 'package:liemie_app/services/Model.dart';
import 'package:liemie_app/visite.dart';
import 'package:page_transition/page_transition.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key, required this.personne, required this.visites})
      : super(key: key);
  final Personne personne;
  final List<Visite> visites;

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int indexItem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexItem,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'New',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            indexItem = index;
          });
          if (index == 1) {}
          if (index == 2) {
            // Navigator.push(
            //   context,
            //   PageTransition(
            //     child: ProfilePage(
            //       personne: widget.personne,
            //     ),
            //     type: PageTransitionType.rightToLeft,
            //   ),
            // );
          }
        },
        selectedItemColor: const Color(0xFF1c50a7),
        unselectedItemColor: const Color(0xFF8fa1b7),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.shifting,
      ),
      body: indexItem == 0
          ? HomePage(
              personne: widget.personne,
              visites: widget.visites,
            )
          : indexItem == 1
              ? HomePage(
                  personne: widget.personne,
                  visites: widget.visites,
                )
              : HomePage(
                  personne: widget.personne,
                  visites: widget.visites,
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
      print(visite.id);
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
                    '${visite.date_prevue.hour}:${visite.date_prevue.minute}',
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
                    '${DateFormat.MMM().format(visite.date_prevue)} ${visite.date_prevue.day}',
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
