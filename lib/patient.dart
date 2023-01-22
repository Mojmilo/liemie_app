import 'package:flutter/material.dart';
import 'package:liemie_app/first.dart';
import 'package:liemie_app/app.dart';
import 'package:liemie_app/models/Personne.dart';
import 'package:liemie_app/services/Model.dart';
import 'package:page_transition/page_transition.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({Key? key, required this.patient}) : super(key: key);
  final Personne patient;

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage> {
  @override
  Widget build(BuildContext context) {
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
              height: 30,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(30),
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
                                '${widget.patient.prenom} ${widget.patient.nom}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              (() {
                                if (widget.patient.sexe == 'H') {
                                  return const Text(
                                    'Male',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF8fa1b7),
                                    ),
                                  );
                                } else {
                                  if (widget.patient.sexe == 'F') {
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
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 15),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1c50a7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Share his',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFffffff),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'patient profile',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFffffff),
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Share profile'),
                            style: ElevatedButton.styleFrom(
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
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              'Patient profile',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'First name',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF8fa1b7),
                              ),
                            ),
                            Text(
                              '${widget.patient.prenom}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1c50a7),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Last name',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF8fa1b7),
                              ),
                            ),
                            Text(
                              '${widget.patient.nom}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1c50a7),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Date of birth',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF8fa1b7),
                              ),
                            ),
                            Text(
                              '${widget.patient.date_naiss}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1c50a7),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'City',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF8fa1b7),
                              ),
                            ),
                            Text(
                              '${widget.patient.ville}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1c50a7),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Address',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF8fa1b7),
                              ),
                            ),
                            Text(
                              '${widget.patient.ad1}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1c50a7),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'CP',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF8fa1b7),
                              ),
                            ),
                            Text(
                              '${widget.patient.cp}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1c50a7),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Phone number',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF8fa1b7),
                              ),
                            ),
                            Text(
                              '${widget.patient.tel_port}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1c50a7),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF8fa1b7),
                              ),
                            ),
                            Text(
                              '${widget.patient.mail}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1c50a7),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
