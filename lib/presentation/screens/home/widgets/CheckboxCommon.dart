// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CheckboxCommon extends StatelessWidget {
  final bool isManual;
  final Function(bool?) onChanged;

  const CheckboxCommon({super.key, required this.isManual, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.0,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Manual',
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
