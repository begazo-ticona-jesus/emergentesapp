// ignore_for_file: use_build_context_synchronously, dead_code, file_names, annotate_overrides, prefer_const_constructors, avoid_print, non_constant_identifier_names, unnecessary_nullable_for_final_variable_declarations, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:emergentesapp/main.dart';
import 'package:emergentesapp/presentation/screens/userRegister/ScreenUserRegister.dart';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:emergentesapp/presentation/screens/userLogin/widgets/CustomForm.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _LoginPageState();
}

class _LoginPageState extends State<ScreenLogin> {
  //late String email, password;
  //final _formKey = GlobalKey<FormState>();
  String error = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _email = '';
  String _password = '';

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FocusScope(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Login Page",
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
            ),
            
            Column(
                children: [
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
                        FocusScope.of(context).unfocus();
                      //A travez de la llave del formulario "_formKey" llamamos a validate para que se llamen los metodos validate de password y email
                      if (_formKey.currentState!.validate()) {
                        //Lllamamos al save para el Onsave de los componentes y se guarden estos valores
                        _formKey.currentState!.save();
                        //quien use login devolvera un UserCredential
                        if (isValidEmail(_email)) {
                          // Quien use login devolverá un UserCredential
                          UserCredential? credenciales =
                              await login(_email, _password);
                          //si estas credenciales son diferentes de null
                          if (credenciales != null) {
                            //Y si el usuario es diferente de null
                            if (credenciales.user != null) {
                              //Y su correo a sido verificado
                              if (credenciales.user!.emailVerified) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyAppScaffold()),
                                    (Route<dynamic> route) => false);
                              } else {
                                //todo Mostrar al usuario que debe verificar su email
                                setState(() {
                                  error =
                                      "Debes verificar tu correo antes de acceder";
                                });
                              }
                            }
                          } else {
                            setState(() {
                              error =
                                  "Datos incorrectos";
                            });
                      }
                        } else {
                          setState(() {
                            error = "Formato de correo";
                          });
                        }
                      }
                    },
                    child: Text('Login'),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("No tiene una cuenta"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScreenRegister()));
                          },
                          child: Text("Registrarse")),
                    ],
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.6,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Divider()),
                        Text("ó"),
                        Expanded(child: Divider()),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SignInButton(Buttons.Google, onPressed: () async {
                        await signInWithGoogle();
                        if (FirebaseAuth.instance.currentUser != null) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyAppScaffold()),
                              (Route<dynamic> route) => false);
                        }
                      }),
                      //para que el boton en android no se muestre
                      Offstage(
                        offstage: !Platform.isIOS,
                        child: SignInButton(Buttons.Apple, onPressed: () async {
                          await signInWithApple();
                          if (FirebaseAuth.instance.currentUser != null) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyAppScaffold()),
                                (Route<dynamic> route) => false);
                          }
                        }),
                      )
                    ],
                  ),
                ],
              ),
          ]
        ),
      ),
    );
  }

  Future<UserCredential?> login(String email, String passwd) async {
    try {
      // Usamos las credenciales con email y contraseña
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: passwd);
      if (mounted) {
        setState(() {
          error = "";
        });
      }
      print("Credenciales de usuario: ${userCredential.user}");
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Usuario no encontrado
        setState(() {
          error = "Usuario no encontrado";
        });
      }
      if (e.code == 'wrong-password') {
        // Contraseña incorrecta
        setState(() {
          error = "Contraseña incorrecta";
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          error = "Error durante el inicio de sesión: $e";
        });
      }
      print("Error durante el inicio de sesión: $e");
    }
    return null;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        print("Error: Usuario de Google no seleccionado");
        return Future.error("Usuario de Google no seleccionado");
      }

      final GoogleSignInAuthentication? authentication =
          await googleUser.authentication;

      if (authentication == null) {
        // Manejar el caso en que la autenticación es nula
        print("Error: Autenticación de Google nula");
        return Future.error("Error de autenticación de Google");
      }

      final credentials = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credentials);
      print(
          "Inicio de sesión exitoso con Google: ${userCredential.user?.displayName}");

      return userCredential;
    } catch (error) {
      // Manejar errores durante el inicio de sesión con Google
      print("Error durante el inicio de sesión con Google: $error");
      return Future.error("Error durante el inicio de sesión con Google");
    }
  }

  Future<UserCredential> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256toString(rawNonce);

    final appleCredentials = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
        nonce: nonce);

    final authCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredentials.identityToken, rawNonce: rawNonce);

    return await FirebaseAuth.instance.signInWithCredential(authCredential);
  }

  String sha256toString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

}
