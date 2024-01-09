// ignore_for_file: file_names, no_logic_in_create_state, annotate_overrides, prefer_const_constructors, unnecessary_new, duplicate_ignore, use_build_context_synchronously, avoid_print
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class ScreenRegister extends StatefulWidget{
  const ScreenRegister({super.key});

  @override
  State<ScreenRegister> createState() => _RegisterState();
}


class _RegisterState extends State<ScreenRegister> {
  late String email, password;
  final _formKey = GlobalKey<FormState>();
  String error = '';

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Register Page",
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
            ),
            Offstage(
              offstage: error == '',
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(error, style: TextStyle(color: Colors.red, fontSize: 16),),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: formulario(),
            ),
            butonCreate(),
          ]),
    );
  }

  Widget formulario() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            buildEmail(),
            const Padding(padding: EdgeInsets.only(top: 12)),
            buildPassword(),
          ],
        ));
  }

  Widget buildEmail() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Correo",
          border: OutlineInputBorder(
              // ignore: unnecessary_new
              borderRadius: new BorderRadius.circular(8),
              borderSide: new BorderSide(color: Colors.black))),
      keyboardType: TextInputType.emailAddress,
      onSaved: (String? value) {
        email = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Este campo es obligatorio";
        }
        return null;
      },
    );
  }

  Widget buildPassword() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: "Password",
          border: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(8),
              borderSide: new BorderSide(color: Colors.black))),
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Este campo es obligatorio";
        }
        return null;
      },
      onSaved: (String? value) {
        password = value!;
      },
    );
  }

  Widget butonCreate() {
    return FractionallySizedBox(
      widthFactor: 0.6,
      child: ElevatedButton(
          onPressed: () async{

            if(_formKey.currentState!.validate()){
              _formKey.currentState!.save();
              UserCredential? credenciales = await crear(email, password);
              if(credenciales !=null){
                if(credenciales.user != null){
                  await credenciales.user!.sendEmailVerification();
                  Navigator.of(context).pop();
                }
              }
            }
          },
          child: Text("Registrarse")
      ),
    );
  }

  Future<UserCredential?> crear(String email, String passwd) async {
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email,
          password: password);
      return userCredential;
    } on FirebaseAuthException catch(e){
      if(e.code == 'email-already-in-use'){
        //todo correo en uso
        setState(() {
          error = "El correo ya se encuentra en uso";
        });
      }
      if(e.code == 'weak-password'){
        //todo contrasenna muy debil
        setState(() {
          error = "contrasenna debil";
        });
      }
    }catch(e){
      print(e.toString());
    }
    return null;
  }


  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(email);
  }

}
