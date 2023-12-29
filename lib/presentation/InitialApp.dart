// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:emergentesapp/presentation/components/NavBar.dart';
import 'package:flutter/material.dart';

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