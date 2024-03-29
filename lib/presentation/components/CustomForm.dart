// custom_form.dart

// ignore_for_file: must_be_immutable, file_names, use_super_parameters

import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function(String) onEmailSaved;
  final Function(String) onPasswordSaved;

  const CustomForm({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onEmailSaved,
    required this.onPasswordSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          buildEmail(),
          const Padding(padding: EdgeInsets.only(top: 12)),
          buildPassword(),
        ],
      ),
    );
  }

  Widget buildEmail() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0), // Ajusta los valores según tus necesidades
      child: TextFormField(
        controller: emailController,
        decoration: InputDecoration(
          labelText: "Correo",
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        onSaved: (String? value) {
          onEmailSaved(value!);
        },
        validator: (value) {
          if (value!.isEmpty) {
            return "Este campo es obligatorio";
          }
          return null;
        },
      ),
    );
  }

  Widget buildPassword() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0), // Ajusta los valores según tus necesidades
      child: TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
          labelText: "Password",
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black))),
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return "Este campo es obligatorio";
        }
        return null;
      },
      onSaved: (String? value) {
        onPasswordSaved(value!);
      },
    ),
    );
  }
}
