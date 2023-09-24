import 'package:flutter/cupertino.dart';

class ScreenOptions extends StatelessWidget {
  const ScreenOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Options Screen',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}