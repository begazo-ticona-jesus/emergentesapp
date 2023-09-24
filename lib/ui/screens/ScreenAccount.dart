import 'package:flutter/material.dart';

class ScreenAccount extends StatelessWidget {
  const ScreenAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Account Screen',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}