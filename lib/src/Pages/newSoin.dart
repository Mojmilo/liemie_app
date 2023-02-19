import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';
import 'package:liemie_app/src/Db/Model/Soin.dart';
import 'package:liemie_app/src/Db/Model/Visite.dart';
import 'package:liemie_app/src/Db/Model/VisiteSoin.dart';
import 'package:liemie_app/src/Db/Repository/SoinRepository.dart';

class NewSoinPage extends StatefulWidget {
  const NewSoinPage({Key? key, required this.personne, required this.visite})
      : super(key: key);
  final Personne personne;
  final Visite visite;

  @override
  State<NewSoinPage> createState() => _NewSoinPageState();
}

class _NewSoinPageState extends State<NewSoinPage> {
  final List<Soin> soins = [];
  @override
  Widget build(BuildContext context) {
    for (var soin in SoinRepository.soins) {
      bool isSoin = false;
      for (var visiteSoin in widget.visite.visiteSoins) {
        if (visiteSoin.soin.id != soin.id) {
          isSoin = true;
        } else {
          isSoin = false;
          break;
        }
      }
      if (isSoin) {
        soins.add(soin);
      }
    }
    return Scaffold(
      body: Container(
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
                  'New soin',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: const [
                Text(
                  'Select a soin',
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
                // itemCount: Soin.soins.length,
                itemCount: soins.length,
                itemBuilder: (context, index) {
                  return SoinWidget(
                    // soin: Soin.soins[index],
                    visite: widget.visite,
                    soin: soins[index],
                  );
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
  const SoinWidget({super.key, required this.visite, required this.soin});
  final Visite visite;
  final Soin soin;

  @override
  State<SoinWidget> createState() => _SoinWidgetState();
}

class _SoinWidgetState extends State<SoinWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        VisiteSoin.addVisiteSoin(widget.visite, widget.soin);
        Navigator.pop(context);
      },
      child: Container(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Soin ${widget.soin.id}',
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
                        '${widget.soin.libel}',
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
      ),
    );
  }
}
