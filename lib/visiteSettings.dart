import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liemie_app/first.dart';
import 'package:liemie_app/app.dart';
import 'package:liemie_app/models/Personne.dart';
import 'package:liemie_app/models/Visite.dart';
import 'package:liemie_app/models/VisiteSoin.dart';
import 'package:liemie_app/services/Model.dart';
import 'package:page_transition/page_transition.dart';

class VisiteSettingsPage extends StatefulWidget {
  const VisiteSettingsPage({Key? key, required this.visite}) : super(key: key);
  final Visite visite;

  @override
  State<VisiteSettingsPage> createState() => _VisiteSettingsPageState();
}

class _VisiteSettingsPageState extends State<VisiteSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
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
                    'Visit settings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 40,
                      color: Color(0xFF1c50a7),
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
                            initialDate: widget.visite.date_prevue.toString() !=
                                    '-0001-11-30 00:00:00.000'
                                ? widget.visite.date_prevue
                                : DateTime.now(),
                            firstDate: DateTime(0001),
                            lastDate: DateTime(2100),
                          ).then(
                            (value) {
                              widget.visite.setDateTimePrevue(
                                DateTime(
                                  value!.year,
                                  value.month,
                                  value.day,
                                  widget.visite.date_prevue.hour,
                                  widget.visite.date_prevue.minute,
                                ),
                              );
                              setState(() {});
                            },
                          ).onError((error, stackTrace) => null);
                        },
                        child: Text(
                          widget.visite.date_prevue.toString() !=
                                  '-0001-11-30 00:00:00.000'
                              ? DateFormat('dd/MM/yyyy')
                                  .format(widget.visite.date_prevue)
                              : 'Not set',
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
                                widget.visite.date_prevue),
                          ).then(
                            (value) {
                              widget.visite.setDateTimePrevue(
                                DateTime(
                                  widget.visite.date_prevue.year,
                                  widget.visite.date_prevue.month,
                                  widget.visite.date_prevue.day,
                                  value!.hour,
                                  value.minute,
                                ),
                              );
                              setState(() {});
                            },
                          ).onError((error, stackTrace) => null);
                        },
                        child: Text(
                          DateFormat('hh:mm').format(widget.visite.date_prevue),
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
                            initialDate: widget.visite.date_reelle.toString() !=
                                    '-0001-11-30 00:00:00.000'
                                ? widget.visite.date_reelle
                                : DateTime.now(),
                            firstDate: DateTime(0001),
                            lastDate: DateTime(2100),
                          ).then(
                            (value) {
                              widget.visite.setDateTimeReelle(
                                DateTime(
                                  value!.year,
                                  value.month,
                                  value.day,
                                  widget.visite.date_reelle.hour,
                                  widget.visite.date_reelle.minute,
                                ),
                              );
                              setState(() {});
                            },
                          ).onError((error, stackTrace) => null);
                        },
                        child: Text(
                          widget.visite.date_reelle.toString() !=
                                  '-0001-11-30 00:00:00.000'
                              ? DateFormat('dd/MM/yyyy')
                                  .format(widget.visite.date_reelle)
                              : 'Not set',
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
                                widget.visite.date_reelle),
                          ).then(
                            (value) {
                              widget.visite.setDateTimeReelle(
                                DateTime(
                                  widget.visite.date_reelle.year,
                                  widget.visite.date_reelle.month,
                                  widget.visite.date_reelle.day,
                                  value!.hour,
                                  value.minute,
                                ),
                              );
                              setState(() {});
                            },
                          ).onError((error, stackTrace) => null);
                        },
                        child: Text(
                          DateFormat('hh:mm').format(widget.visite.date_reelle),
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
                  // Text(
                  //   widget.visite.duree.toString() + ' min',
                  //   style: const TextStyle(
                  //     fontSize: 20,
                  //   ),
                  // ),
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
                                  text: widget.visite.duree.toString(),
                                ),
                                onChanged: (value) {
                                  try {
                                    widget.visite.setDuree(double.parse(value));
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
                      widget.visite.duree.toString() + ' min',
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
                          initialValue: widget.visite.compte_rendu_infirmiere,
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
                            widget.visite.setCompteRenduInfirmiere(value);
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
                          initialValue: widget.visite.compte_rendu_patient,
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
                            widget.visite.setCompteRenduPatient(value);
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
