import 'package:emergentesapp/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './components/stateSwitched.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => StateWitched(),
      child: const MyApp(),
    ),
  );
}
/*
void main() {
  runApp(const MyApp());
}
 */

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyAppScaffold(),
    );
  }
}

class MyAppScaffold extends StatelessWidget {
  const MyAppScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: context.watch<StateWitched>().isSwitched
                ? const AssetImage('assets/Fondo2.jpg')
                : const AssetImage('assets/Fondo1.jpg'),
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

/*

class MyAppScaffold extends StatelessWidget {
  const MyAppScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Fondo1.jpg'),
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




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Fondo1.jpg'),
            fit: BoxFit.cover, // Ajusta la imagen al tamaño del contenedor
          ),
        ),
        child: MaterialApp.router(
          routerConfig: goRouter,
        ),//const NavBar()
      ),
    );
  }
}
 */