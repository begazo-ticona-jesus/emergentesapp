import 'package:flutter/material.dart';

class SliderIntensity extends StatelessWidget {
  final double intensity;
  final Function(double) onChanged;

  const SliderIntensity({super.key, required this.intensity, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 85,
      decoration: BoxDecoration(
        color: const Color(0xFF343764), // Establece el color de fondo del slider
        borderRadius: BorderRadius.circular(13.0), // Ajusta el radio para esquinas redondeadas
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const Text(
          "INTENSIDAD",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        SliderTheme(
            data: SliderThemeData(
              trackHeight: 12.0,
              activeTrackColor: Colors.blue,
              inactiveTrackColor: Colors.white,
              thumbColor: Colors.blueAccent,
              overlayColor: Colors.red.withAlpha(32),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
            ),
            child: Slider(
              value: intensity,
              min: 0.0,
              max: 1.0,
              divisions: 100,
              label: '$intensity',
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
