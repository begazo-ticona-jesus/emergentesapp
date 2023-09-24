import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String labelText;
  final bool isObscure;
  final bool isEmailField;
  final bool isFieldSelected;
  final Function(String) onChanged;
  final IconData? suffixIcon;

  const CustomTextField({
    required this.controller,
    required this.keyboardType,
    required this.textInputAction,
    required this.labelText,
    this.isObscure = false,
    this.isEmailField = false,
    this.isFieldSelected = false,
    required this.onChanged,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscureText: isObscure,
        decoration: InputDecoration(
          labelText: labelText,
          fillColor: Colors.white,
          labelStyle: TextStyle(
            color: (isFieldSelected || controller.text.isNotEmpty) ? Colors.pink : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.pink),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          filled: true,
          suffixIcon: suffixIcon != null
              ? GestureDetector(
            child: Icon(
              suffixIcon,
              color: isFieldSelected ? Colors.pink : Colors.black,
            ),
            onTap: () {
              onChanged(''); // Hacer algo cuando se toca el icono (si es necesario)
            },
          )
              : null,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
