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
        //color: Colors.white.withOpacity(0.5),
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
              activeTrackColor: const Color(0xFF343764),//pista activa
              inactiveTrackColor: Colors.white,//pista inactiva
              thumbColor: const Color(0xFF343764),//bolita
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
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}