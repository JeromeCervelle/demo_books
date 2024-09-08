import 'package:flutter/material.dart';
import 'package:demo/controller/BookController.dart'; // Import du contrôleur

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BookController(), // Redirection vers le contrôleur
    );
  }
}
