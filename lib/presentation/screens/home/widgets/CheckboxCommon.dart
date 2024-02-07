// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CheckboxCommon extends StatelessWidget {
  final bool isManual;
  final bool isEnabled; // Nueva propiedad
  final Function(bool?) onChanged;

  const CheckboxCommon({
    Key? key,
    required this.isManual,
    required this.isEnabled, // Agregar la nueva propiedad
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155.0,
      height: 40,
      decoration: BoxDecoration(
        color: isEnabled ? Colors.white : Colors.grey.withOpacity(0.5), // Deshabilitar el color cuando no está habilitado
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
            onChanged: isEnabled ? onChanged : null, // Deshabilitar el cambio cuando no está habilitado
            checkColor: Colors.white,
            activeColor: isEnabled ? const Color(0xFF343764) : Colors.grey, // Deshabilitar el color activo cuando no está habilitado
            shape: const OvalBorder(eccentricity: 0.5),
          ),
        ],
      ),
    );
  }
}
