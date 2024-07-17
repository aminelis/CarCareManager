// main.dart

import 'package:flutter/material.dart';
import 'package:manage_cars/screens/Home.dart';  // Remplacez par votre écran principal

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion Entretien Véhicule',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),  // Remplacez par votre écran principal
    );
  }
}
