import 'package:flutter/material.dart';
import 'package:rotigolovers_groupf/utils/rounded_button.dart';

class WelcomePgA extends StatefulWidget {
  @override
  State<WelcomePgA> createState() => _WelcomePgAState();
}

class _WelcomePgAState extends State<WelcomePgA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text("Welcome Page Admin"),
          backgroundColor: Color(0xFF5D4037),
          foregroundColor: Colors.white),
      backgroundColor: Color.fromARGB(221, 226, 226, 226),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Gambar dengan format PNG
            Image.asset(
              'assets/welcome.png',
              height: 200,
              width: 200,
            ),
            SizedBox(height: 20),
            // Tombol Log In
            RoundedButton(
              colour: Color.fromARGB(255, 87, 55, 27),
              title: 'Log In',
              onPressed: () {
                Navigator.pushNamed(context, 'login_admin');
              },
            ),
          ],
        ),
      ),
    );
  }
}
