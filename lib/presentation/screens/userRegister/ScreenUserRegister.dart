// ignore_for_file: file_names, no_logic_in_create_state, annotate_overrides, prefer_const_constructors, unnecessary_new, duplicate_ignore, use_build_context_synchronously, avoid_print
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:emergentesapp/presentation/components/CustomForm.dart';

class ScreenRegister extends StatefulWidget {
  const ScreenRegister({super.key});

  @override
  State<ScreenRegister> createState() => _RegisterState();
}

class _RegisterState extends State<ScreenRegister> {
  String error = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _email = '';
  String _password = '';

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.only(top: 150.0),
                child: Image.asset(
                  'assets/login2.png',
                  height: 250,
                  width: 250,
                  fit: BoxFit.contain,
                ),
              ),
              const Text(
                'Hello',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                child: Text(
                  'Welcome to Gleam & Glow \nwhere you can control the light in your home',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Offstage(
                offstage: error == '',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomForm(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  onEmailSaved: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                  onPasswordSaved: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      UserCredential? credenciales =
                          await crear(_email, _password);
                      if (credenciales != null) {
                        if (credenciales.user != null) {
                          await credenciales.user!.sendEmailVerification();
                          Navigator.of(context).pop();
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
                    backgroundColor: Color(0xFF343764),
                  ),
                  child: Text(
                    "Registrarse",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ]),
      ),
    );
  }

  Future<UserCredential?> crear(String email, String passwd) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (isValidEmail(_email)) {
        if (e.code == 'email-already-in-use') {
          //todo correo en uso
          setState(() {
            error = "El correo ya se encuentra en uso";
          });
        }
        if (e.code == 'weak-password') {
          //todo contrasena muy debil
          setState(() {
            error = "contrasenna debil";
          });
        }
      } else {
        setState(() {
            error = "Email invalido";
          });
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }
}
