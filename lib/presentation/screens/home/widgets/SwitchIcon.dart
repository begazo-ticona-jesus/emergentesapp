// ignore_for_file: file_names, library_prefixes

import 'package:flutter/material.dart';

import '../../../components/stateSwitched.dart';
import 'package:provider/provider.dart';
import '../../../components/Actions.dart' as MyActions;
import '../../../components/stateActions.dart';

class SwitchIcon extends StatelessWidget {
  final bool isSwitched;
  final Function(bool) onChanged;

  const SwitchIcon({super.key, required this.isSwitched, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        decoration: BoxDecoration(
          color:  Colors.transparent,
          borderRadius: BorderRadius.circular(300),
        ),
        child: Icon(
          isSwitched ? Icons.lightbulb_circle : Icons.lightbulb_circle_outlined,
          color: isSwitched ? const Color(0xFF343764) : Colors.white,
          size: 250,
        ),
      ),
      onPressed: () {
        onChanged(!isSwitched);

        // Llamar a la función onChanged del Switch cuando se presiona el IconButton
        context.read<StateWitched>().isSwitched = !context.read<StateWitched>().isSwitched;

        if (context.read<StateWitched>().isSwitched) {
          // Acción cuando el switch se enciende
          MyActions.Actions newAction = MyActions.Actions('Foco Encendido', DateTime.now());
          appState.listOfActions.add(newAction);
        } else {
          // Acción cuando el switch se apaga
          MyActions.Actions newAction = MyActions.Actions('Foco Apagado', DateTime.now());
          appState.listOfActions.add(newAction);
        }
      },
    );
  }
}
