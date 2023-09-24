import 'package:emergentesapp/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widtgets/CustomTextField.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  _ScreenLoginState createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isEmailSelected = false;
  bool isPasswordSelected = false;
  bool showError = false;
  bool isLoading = false;
  bool passView = false;

  void userLogin() {
    String email = emailController.text;
    String password = passwordController.text;

    if (checkValues(email, password)) {
      Future.delayed(const Duration(seconds: 2), () {
        print('object......................................................');
        //context.go('/initial');
      });
      setState(() {
        isLoading = true;
      });

    } else {
      setState(() {
        showError = true;
      });
    }
  }

  bool checkValues(String email, String password) {
    return email.isNotEmpty && password.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              labelText: "Correo electrónico",
              isEmailField: true,
              isFieldSelected: isEmailSelected,
              onChanged: (value) {
                setState(() {
                  isEmailSelected = true;
                });
              },
              suffixIcon: Icons.email,
            ),

            CustomTextField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              labelText: "Contraseña",
              isObscure: !passView,
              isFieldSelected: isPasswordSelected,
              onChanged: (value) {
                setState(() {
                  isPasswordSelected = true;
                });
              },
              suffixIcon: passView ? Icons.visibility_off : Icons.visibility,
            ),

            ElevatedButton(
              //onPressed: userLogin,
              onPressed: () => context.go('/initial'),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "INGRESAR",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}