import 'package:rotigolovers_groupf/firebase_options.dart';
import 'package:rotigolovers_groupf/pages/halaman_laporan_penjualan.dart';
import 'package:rotigolovers_groupf/pages/halaman_menu.dart';
import 'package:rotigolovers_groupf/pages/login_admin.dart';
import 'package:rotigolovers_groupf/pages/login_page.dart';
import 'package:rotigolovers_groupf/pages/register_page.dart';
import 'package:rotigolovers_groupf/pages/welcome_page.dart';
import 'package:rotigolovers_groupf/pages/welcome_page_admin.dart';
import 'package:rotigolovers_groupf/pages/welcome_page_staff.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'welcome_page',
      routes: {
        'welcome_page': (context) => WelcomePage(),
        'welcome_page_admin': (context) => WelcomePgA(),
        'welcome_page_staff': (context) => WelcomePgS(),
        'login_page': (context) => LoginPage(),
        'register_page': (context) => RegisterPage(),
        'login_admin': (context) => AdminLoginPage(),
        'halaman_menu': (context) => RotigoloversList(),
        'halaman_laporan_penjualan': (context) => RotigoloversLaporan()
      },
    );
  }
}
