import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liemie_app/first.dart';
import 'package:liemie_app/home.dart';
import 'package:liemie_app/models/Personne.dart';
import 'package:liemie_app/models/Visite.dart';
import 'package:liemie_app/models/VisiteSoin.dart';
import 'package:liemie_app/services/Model.dart';
import 'package:page_transition/page_transition.dart';

class VisitePage extends StatefulWidget {
  const VisitePage({Key? key, required this.visite}) : super(key: key);
  final Visite visite;

  @override
  State<VisitePage> createState() => _VisitePageState();
}

// class _VisitePageState extends State<VisitePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.all(30),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: const Icon(
//                     Icons.arrow_back,
//                     size: 40,
//                     color: Color(0xFF1c50a7),
//                   ),
//                 ),
//                 const Text(
//                   'Visite details',
//                   style: TextStyle(
//                     fontSize: 20,
//                   ),
//                 ),
//                 const SizedBox(),
//               ],
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             Expanded(child:
//               SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Column(
//                   children: [
//                     Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             Text(
//                               'Informations',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 50,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               children: [
//                                 Row(
//                                   children: const [
//                                     Text(
//                                       'Scheduled date',
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.w500,
//                                         color: Color(0xFF8fa1b7),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                         color: const Color(0xFFdcedff),
//                                         borderRadius: BorderRadius.circular(20),
//                                       ),
//                                       child: Text(
//                                         DateFormat.MMM().format(widget.visite.date_prevue) + ' ' + DateFormat.d().format(widget.visite.date_prevue) + ' / ' + DateFormat.H().format(widget.visite.date_prevue) + ':' + DateFormat.m().format(widget.visite.date_prevue),
//                                         style: const TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 Row(
//                                   children: const [
//                                     Text(
//                                       'Actual date',
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.w500,
//                                         color: Color(0xFF8fa1b7),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                         color: const Color(0xFFdcedff),
//                                         borderRadius: BorderRadius.circular(20),
//                                       ),
//                                       child: Text(
//                                         DateFormat.MMM().format(widget.visite.date_reelle) + ' ' + DateFormat.d().format(widget.visite.date_reelle) + ' / ' + DateFormat.H().format(widget.visite.date_reelle) + ':' + DateFormat.m().format(widget.visite.date_reelle),
//                                         style: const TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 15,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Column(
//                               children: [
//                                 Row(
//                                   children: const [
//                                     Text(
//                                       'Duration',
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.w500,
//                                         color: Color(0xFF8fa1b7),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                         color: const Color(0xFFdcedff),
//                                         borderRadius: BorderRadius.circular(20),
//                                       ),
//                                       child: Text(
//                                         widget.visite.duree.toString() + ' min',
//                                         style: const TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 15,
//                         ),
//                         Row(
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: const [
//                                     Text(
//                                       "Nurse's report",
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.w500,
//                                         color: Color(0xFF8fa1b7),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                         // color: const Color(0xFFdcedff),
//                                         borderRadius: BorderRadius.circular(20),
//                                         border: Border.all(
//                                           color: const Color(0xFFdcedff),
//                                           width: 3,
//                                         ),
//                                       ),
//                                       // height: 200,
//                                       width: 300,
//                                       // width: double.infinity,
//                                       child: TextFormField(
//                                         initialValue: widget.visite.compte_rendu_infirmiere,
//                                         // readOnly: true,
//                                         maxLines: 3,
//                                         decoration: const InputDecoration(
//                                           border: InputBorder.none,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 15,
//                         ),
//                         Row(
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: const [
//                                     Text(
//                                       "Patient report",
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.w500,
//                                         color: Color(0xFF8fa1b7),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                         // color: const Color(0xFFdcedff),
//                                         borderRadius: BorderRadius.circular(20),
//                                         border: Border.all(
//                                           color: const Color(0xFFdcedff),
//                                           width: 3,
//                                         ),
//                                       ),
//                                       // height: 200,
//                                       width: 300,
//                                       child: TextFormField(
//                                         initialValue: widget.visite.compte_rendu_infirmiere,
//                                         // readOnly: true,
//                                         maxLines: 3,
//                                         decoration: const InputDecoration(
//                                           border: InputBorder.none,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         ElevatedButton(
//                           onPressed: () async {
//                             // if (_formKey.currentState!.validate()) {
//                             //   var res = await testConnexion(login, password, context);
//                             //   setState(() {
//                             //     isLogged = res;
//                             //   });
//                             // }
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SizedBox(),
//                               Text('Save informations', style: TextStyle(fontSize: 15)),
//                             ],
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             primary: const Color(0xFF32dba9),
//                             // shape: const CircleBorder(),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                             padding: const EdgeInsets.all(15),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _VisitePageState extends State<VisitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: const [
                Text(
                  'All treatments',
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
            Expanded(
              child: ListView.builder(
                itemCount: widget.visite.visiteSoins.length,
                itemBuilder: (context, index) {
                  return SoinWidget(
                      visiteSoin: widget.visite.visiteSoins[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SoinWidget extends StatefulWidget {
  const SoinWidget({super.key, required this.visiteSoin});
  final VisiteSoin visiteSoin;

  @override
  State<SoinWidget> createState() => _SoinWidgetState();
}

class _SoinWidgetState extends State<SoinWidget> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      // width: 200,
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFdcedff),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  isChecked = !isChecked;
                  setState(() {
                    isChecked = isChecked;
                  });
                },
                icon: isChecked
                    ? const Icon(
                        Icons.check_box,
                        color: Color(0xFF1c50a7),
                      )
                    : const Icon(
                        Icons.check_box_outline_blank_outlined,
                        color: Color(0xFF1c50a7),
                      ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Soin ${widget.visiteSoin.soin.id}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    child: Text(
                      '${widget.visiteSoin.soin.libel}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8fa1b7),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                // '5:45PM',
                // '${DateTime.parse(visite['date_prevue']).hour}:${DateTime.parse(visite['date_prevue']).minute}',
                '${DateTime.parse('2016-11-17 20:31:10').hour}:${DateTime.parse('2016-11-17 20:31:10').minute}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF32dba9),
                ),
              ),
              Text(
                // 'Dec 7',
                // '${DateFormat.MMM().format(DateTime.parse(visite['date_prevue']))} ${DateTime.parse(visite['date_prevue']).day}',
                '${DateFormat.MMM().format(DateTime.parse('2016-11-17 20:31:10'))} ${DateTime.parse('2016-11-17 20:31:10').day}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF8fa1b7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
