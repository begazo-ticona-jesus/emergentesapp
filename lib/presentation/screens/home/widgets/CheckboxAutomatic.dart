// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CheckboxAutomatic extends StatelessWidget {
  final bool isManual;
  final Function(bool?) onChanged;

  const CheckboxAutomatic({super.key, required this.isManual, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Automático',
            style: TextStyle(fontSize: 17.0),
          ),
          Checkbox(
            value: isManual,
            onChanged: onChanged,
            checkColor: Colors.white,
            activeColor: const Color(0xFF343764),
            shape: const OvalBorder(eccentricity: 0.5),
          ),
        ],
      ),
    );
  }
}
