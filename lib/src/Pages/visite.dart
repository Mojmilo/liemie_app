import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liemie_app/src/Db/Model/Personne.dart';
import 'package:liemie_app/src/Db/Model/Visite.dart';
import 'package:liemie_app/src/Db/Model/VisiteSoin.dart';
import 'package:liemie_app/src/Pages/newSoin.dart';
import 'package:liemie_app/src/Pages/visiteSettings.dart';
import 'package:page_transition/page_transition.dart';

class VisitePage extends StatefulWidget {
  const VisitePage({Key? key, required this.personne, required this.visite})
      : super(key: key);
  final Personne personne;
  final Visite visite;

  @override
  State<VisitePage> createState() => _VisitePageState();
}

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
                  'Info visit',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: VisiteSettingsPage(
                          visite: widget.visite,
                        ),
                        type: PageTransitionType.rightToLeft,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.settings,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'All treatments',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: NewSoinPage(
                          personne: widget.personne,
                          visite: widget.visite,
                        ),
                        type: PageTransitionType.rightToLeft,
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 40,
                    color: Color(0xFF1c50a7),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      // width: 200,
      height: 100,
      decoration: BoxDecoration(
        color: widget.visiteSoin.isRealise
            ? const Color(0x77dcedff)
            : const Color(0xFFdcedff),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              widget.visiteSoin.isPrevu
                  ? IconButton(
                      onPressed: () {
                        widget.visiteSoin
                            .setIsRealise(!widget.visiteSoin.isRealise);
                        setState(() {});
                      },
                      icon: widget.visiteSoin.isRealise
                          ? const Icon(
                              Icons.check_box,
                              color: Color(0xFF1c50a7),
                            )
                          : const Icon(
                              Icons.check_box_outline_blank_outlined,
                              color: Color(0xFF1c50a7),
                            ),
                    )
                  : const Icon(
                      Icons.check_box,
                      color: Color(0xFF1c50a7),
                    ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Soin ${widget.visiteSoin.soin.id}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      decoration: widget.visiteSoin.isRealise
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
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
