import 'package:flutter/material.dart';

class CheckboxCommon extends StatelessWidget {
  final bool isManual;
  final Function(bool?) onChanged;

  const CheckboxCommon({super.key, required this.isManual, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.0,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("MANUAL"),
          Checkbox(
            value: isManual,
            onChanged: onChanged,
            checkColor: Colors.white,
            activeColor: Colors.pink,
            shape: const OvalBorder(),
          ),
        ],
      ),
    );
  }
}
