import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liemie_app/first.dart';
import 'package:liemie_app/models/Personne.dart';
import 'package:liemie_app/models/Soin.dart';
import 'package:liemie_app/models/Visite.dart';
import 'package:liemie_app/models/VisiteSoin.dart';
import 'package:liemie_app/patient.dart';
import 'package:liemie_app/profile.dart';
import 'package:liemie_app/services/Model.dart';
import 'package:liemie_app/visite.dart';
import 'package:page_transition/page_transition.dart';

class NewVisitePage extends StatefulWidget {
  NewVisitePage({Key? key, required this.personne, required this.visites})
      : super(key: key);
  final Personne personne;
  final List<Visite> visites;
  final Map<String, dynamic> visite = {
    'id': 0,
    'patient': 0,
    'infirmiere': 0,
    'date_prevue': DateTime.now(),
    'date_reelle': DateTime.now(),
    'duree': 0,
    'compte_rendu_infirmiere': '',
    'compte_rendu_patient': '',
  };

  @override
  State<NewVisitePage> createState() => _NewVisitePageState();
}

class _NewVisitePageState extends State<NewVisitePage> {
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
                  await Model.getVisitesUserDB(widget.personne.id);
                  await Model.getVisitesUser(widget.personne.id);
                  setState(() {
                    widget.visites.clear();
                    widget.visites.addAll(Visite.visites);
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
          Container(
            height: 500,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text(
                        'New visit',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Visit date',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Planned :',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(0001),
                                lastDate: DateTime(2100),
                              ).then(
                                (value) {
                                  widget.visite['date_prevue'] = DateTime(
                                    value!.year,
                                    value.month,
                                    value.day,
                                    widget.visite['date_prevue'].hour,
                                    widget.visite['date_prevue'].minute,
                                  );
                                  setState(() {});
                                },
                              ).onError((error, stackTrace) => null);
                            },
                            child: Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(widget.visite['date_prevue']),
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(
                                    widget.visite['date_prevue']),
                              ).then(
                                (value) {
                                  widget.visite['date_prevue'] = DateTime(
                                    widget.visite['date_prevue'].year,
                                    widget.visite['date_prevue'].month,
                                    widget.visite['date_prevue'].day,
                                    value!.hour,
                                    value.minute,
                                  );
                                  setState(() {});
                                },
                              ).onError((error, stackTrace) => null);
                            },
                            child: Text(
                              DateFormat('hh:mm')
                                  .format(widget.visite['date_prevue']),
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Real :',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(0001),
                                lastDate: DateTime(2100),
                              ).then(
                                (value) {
                                  widget.visite['date_reelle'] = DateTime(
                                    value!.year,
                                    value.month,
                                    value.day,
                                    widget.visite['date_reelle'].hour,
                                    widget.visite['date_reelle'].minute,
                                  );
                                  setState(() {});
                                },
                              ).onError((error, stackTrace) => null);
                            },
                            child: Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(widget.visite['date_reelle']),
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(
                                    widget.visite['date_reelle']),
                              ).then(
                                (value) {
                                  widget.visite['date_reelle'] = DateTime(
                                    widget.visite['date_reelle'].year,
                                    widget.visite['date_reelle'].month,
                                    widget.visite['date_reelle'].day,
                                    value!.hour,
                                    value.minute,
                                  );
                                  setState(() {});
                                },
                              ).onError((error, stackTrace) => null);
                            },
                            child: Text(
                              DateFormat('hh:mm')
                                  .format(widget.visite['date_reelle']),
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Time',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Duration :',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Duration'),
                                content: Container(
                                  width: 100,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: TextEditingController(
                                      text: widget.visite['duree'].toString(),
                                    ),
                                    onChanged: (value) {
                                      try {
                                        widget.visite['duree'] =
                                            double.parse(value);
                                        setState(() {});
                                      } catch (e) {}
                                    },
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          widget.visite['duree'].toString() + ' min',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: const [
                      Text(
                        'Comments',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Nursing report :',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            child: TextFormField(
                              maxLines: 3,
                              initialValue:
                                  widget.visite['compte_rendu_infirmiere'],
                              style: const TextStyle(
                                //color: Color(0xFFffffff),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                height: 2,
                              ),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 10,
                                  bottom: 10,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF8fa1b7),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF32dba9),
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                widget.visite['compte_rendu_infirmiere'] =
                                    value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Patient report :',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            child: TextFormField(
                              maxLines: 3,
                              initialValue:
                                  widget.visite['compte_rendu_patient'],
                              style: const TextStyle(
                                //color: Color(0xFFffffff),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                height: 2,
                              ),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 10,
                                  bottom: 10,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF8fa1b7),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF32dba9),
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                widget.visite['compte_rendu_patient'] = value;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Personne patient = Personne(
                        999999,
                        'test',
                        'retest',
                        'H',
                        DateTime.now(),
                        DateTime.now(),
                        'zer',
                        'tre',
                        'gf',
                        'retre',
                        'fdg',
                        'trh',
                        'ytj',
                      ); // A revoir pour le patient
                      setState(
                        () {
                          widget.visite['patient'] = patient.id;
                          widget.visite['infirmiere'] = widget.personne.id;
                        },
                      );
                      Visite visite =
                          Visite.fromJson(widget.visite, patient, []);
                      visite.addVisite();
                    },
                    child: Text(
                      'Create visit',
                      style: TextStyle(
                        color: const Color(0xFFffffff),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      // backgroundColor: const Color(0xFF32dba9),
                      primary: const Color(0xFF32dba9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
