// ignore_for_file: file_names, library_prefixes

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
          color: const Color(0xFF343764).withOpacity(0.25),
          borderRadius: BorderRadius.circular(200),
        ),
        child: Icon(
          isSwitched ? Icons.lightbulb_circle_outlined : Icons.lightbulb_circle_outlined,
          color: isSwitched ? Colors.yellow : const Color(0xFF343764),
          size: 250,
        ),
      ),
      onPressed: () {
        onChanged(!isSwitched);
      },
    );
  }
}
