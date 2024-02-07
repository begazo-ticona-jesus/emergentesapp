// ignore_for_file: avoid_print, use_super_parameters

import 'package:firebase_core/firebase_core.dart';

import 'package:emergentesapp/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'presentation/components/stateSwitched.dart';

import 'package:emergentesapp/presentation/screens/userLogin/ScreenLogin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    print("Firebase inicializado correctamente.");
  } catch (e) {
    print("Error al inicializar Firebase: $e");
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => StateWitched(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScreenLogin(),
    );
  }
}

class MyAppScaffold extends StatelessWidget {
  const MyAppScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Fondo2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: MaterialApp.router(
          routerConfig: goRouter,
        ),
      ),
    );
  }
}
