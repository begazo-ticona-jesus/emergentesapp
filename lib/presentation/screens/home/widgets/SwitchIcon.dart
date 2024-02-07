// ignore_for_file: file_names, library_prefixes

import 'package:flutter/material.dart';

class SwitchIcon extends StatelessWidget {
  final bool isSwitched;
  final bool isEnabled; // Nueva propiedad
  final Function(bool) onChanged;

  const SwitchIcon({
    Key? key,
    required this.isSwitched,
    required this.isEnabled, // Agregar la nueva propiedad
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        decoration: BoxDecoration(
          color: isEnabled ? const Color(0xFF343764).withOpacity(0.25) : Colors.grey.withOpacity(0.5), // Deshabilitar el color cuando no está habilitado
          borderRadius: BorderRadius.circular(200),
        ),
        child: Icon(
          isSwitched ? Icons.lightbulb_circle_outlined : Icons.lightbulb_circle_outlined,
          color: isEnabled ? (isSwitched ? Colors.yellow : const Color(0xFF343764)) : Colors.grey, // Deshabilitar el color cuando no está habilitado
          size: 250,
        ),
      ),
      onPressed: isEnabled
          ? () {
        onChanged(!isSwitched);
      }
          : null, // Deshabilitar el botón cuando no está habilitado
    );
  }
}