import 'package:rotigolovers_groupf/pages/welcome_page_admin.dart';
import 'package:rotigolovers_groupf/pages/welcome_page_staff.dart';
import 'package:rotigolovers_groupf/utils/rounded_button.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(221, 226, 226, 226),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Banner Title
            Text(
              "ROTIGOLOVERS",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 87, 55, 27),
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 20),
            // PNG Image
            Image.asset(
              'assets/welcome.png',
              height: 200,
              width: 200,
            ),
            SizedBox(height: 20),
            // Row to make buttons horizontal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Button for Staff
                RoundedButton(
                  colour: Color.fromARGB(255, 87, 55, 27),
                  title: 'Staff',
                  onPressed: () {
                    Navigator.pushNamed(context, 'welcome_page_staff');
                  },
                ),
                // Button for Admin
                RoundedButton(
                  colour: Color.fromARGB(255, 151, 103, 24),
                  title: 'Admin',
                  onPressed: () {
                    Navigator.pushNamed(context, 'welcome_page_admin');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
