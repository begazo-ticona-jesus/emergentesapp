import 'package:flutter/material.dart';
import '../components/NavBar.dart';

class InitialApp extends StatefulWidget {
  const InitialApp({super.key});

  @override
  _InitialAppState createState() => _InitialAppState();
}

class _InitialAppState extends State<InitialApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NavBar(),
    );
  }
}