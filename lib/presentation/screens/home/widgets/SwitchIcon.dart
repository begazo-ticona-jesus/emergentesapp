import 'package:flutter/material.dart';

class SwitchIcon extends StatelessWidget {
  final bool isSwitched;
  final Function(bool) onChanged;

  const SwitchIcon({super.key, required this.isSwitched, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF343764),
          borderRadius: BorderRadius.circular(300),
        ),
        child: Icon(
          isSwitched ? Icons.lightbulb : Icons.lightbulb_outline,
          color: isSwitched ? Colors.yellow : Colors.white,
          size: 300,
        ),
      ),
      onPressed: () {
        onChanged(!isSwitched);
      },
    );
  }
}
