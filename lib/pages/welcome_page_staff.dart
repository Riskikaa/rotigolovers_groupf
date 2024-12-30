import 'package:flutter/material.dart';
import 'package:rotigolovers_groupf/utils/rounded_button.dart';

class WelcomePgS extends StatefulWidget {
  @override
  State<WelcomePgS> createState() => _WelcomePgSState();
}

class _WelcomePgSState extends State<WelcomePgS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text("Welcome Page Staff"),
          backgroundColor: Color(0xFF5D4037),
          foregroundColor: Colors.white),
      backgroundColor: const Color.fromARGB(221, 226, 226, 226),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              '../assets/welcome.png', // Menggunakan PNG alih-alih SVG
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 20),
            RoundedButton(
              colour: const Color.fromARGB(255, 87, 55, 27),
              title: 'Log In Staff',
              onPressed: () {
                Navigator.pushNamed(context, 'login_page');
              },
            ),
            RoundedButton(
              colour: const Color.fromARGB(255, 151, 103, 24),
              title: 'Register Staff',
              onPressed: () {
                Navigator.pushNamed(context, 'register_page');
              },
            ),
          ],
        ),
      ),
    );
  }
}
