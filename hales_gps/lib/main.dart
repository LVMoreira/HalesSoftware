import 'package:flutter/material.dart';
import 'package:hales_gps/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove a faixa de debug
      title: 'GPS Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(), // Aqui chamamos a HomePage que criámos antes
    );
  }
}