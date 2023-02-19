import 'package:flutter/material.dart';
import 'package:liemie_app/src/Pages/login.dart';
import 'package:page_transition/page_transition.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1c50a7),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 200,
            ),
            const Text(
              'Virtual',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Color(0xFF32dba9),
              ),
            ),
            const Text(
              'Ecosystem.',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Color(0xFFffffff),
              ),
            ),
            const Text(
              'You are a nursing specialist, on a single tech platform, simplifying access for anyone, anywhere.',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8fa1b7),
                height: 2,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, '/login');
                    Navigator.push(
                      context,
                      PageTransition(
                        child: LoginPage(),
                        type: PageTransitionType.rightToLeft,
                      ),
                    );
                  },
                  child: const Icon(Icons.arrow_forward),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF32dba9),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(25),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Get',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFffffff),
                      ),
                    ),
                    Text(
                      'Started',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFffffff),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
