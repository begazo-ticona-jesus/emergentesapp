// ignore_for_file: file_names, library_prefixes

import 'package:flutter/material.dart';
import '../../../components/stateSwitched.dart';
import 'package:provider/provider.dart';
import '../../../components/Actions.dart' as MyActions;
import '../../../components/stateActions.dart';

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
      }
          : null,
    );
  }
}