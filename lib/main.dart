import 'package:emergentesapp/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg-iot.webp'),
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