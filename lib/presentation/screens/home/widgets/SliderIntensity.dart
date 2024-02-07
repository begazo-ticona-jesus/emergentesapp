// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SliderIntensity extends StatelessWidget {
  final double intensity;
  final bool isEnabled; // Nueva propiedad
  final Function(double) onChanged;

  const SliderIntensity({
    Key? key,
    required this.intensity,
    required this.isEnabled, // Agregar la nueva propiedad
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 85,
      decoration: BoxDecoration(
        color: isEnabled ? const Color(0xFF343764).withOpacity(0.75) : Colors.grey.withOpacity(0.5), // Deshabilitar el color cuando no está habilitado
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const Text(
          "Nivel de Intensidad",
          style: TextStyle(
            color: Color(0xFF343764),
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
          ),
        ),
        SliderTheme(
            data: SliderThemeData(
              trackHeight: 12.0,
              activeTrackColor: isEnabled ? const Color(0xFF343764) : Colors.grey, // Deshabilitar el color activo cuando no está habilitado
              inactiveTrackColor: Colors.white, // pista inactiva
              thumbColor: isEnabled ? const Color(0xFF343764) : Colors.grey, // Deshabilitar el color de la bolita cuando no está habilitado
              overlayColor: Colors.white.withAlpha(32),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
            ),
            child: Slider(
              value: intensity,
              min: 0.0,
              max: 1.0,
              divisions: 100,
              label: '$intensity',
              onChanged: isEnabled ? onChanged : null, // Deshabilitar el cambio cuando no está habilitado
            ),
          ),
        ],
      ),
    );
  }
}