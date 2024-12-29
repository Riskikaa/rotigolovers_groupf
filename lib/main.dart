import 'package:flutter/material.dart';
import 'package:rotigolovers_groupf/halaman_menu.dart';
import 'package:rotigolovers_groupf/halaman_keranjang.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rotigolovers Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RotigoloversList(),
    );
  }
}
