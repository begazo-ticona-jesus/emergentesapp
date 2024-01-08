import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/Actions.dart' as MyActions;
import '../../../components/stateActions.dart';
import '../../../components/stateSwitched.dart'; // Asegúrate de importar el paquete de Provider

class CustomSwitchTheme extends StatefulWidget {
  @override
  SwitchState createState() => SwitchState();
}

class SwitchState extends State<CustomSwitchTheme> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            "Cambiar Tema",
            style: TextStyle(
                color: Color(0xFF343764)
            ),
          ),
          Switch(
            value: context.watch<StateWitched>().isSwitched,
            onChanged: (value) {
              context.read<StateWitched>().isSwitched = value;
              if (value) {
                // Acción cuando el switch se enciende
                MyActions.Actions newAction =
                MyActions.Actions('Switch ON', DateTime.now());
                appState.listOfActions.add(newAction);
              } else {
                // Acción cuando el switch se apaga
                MyActions.Actions newAction =
                MyActions.Actions('Switch OFF', DateTime.now());
                appState.listOfActions.add(newAction);
              }
            },
            activeTrackColor: Color.fromARGB(255, 248, 205, 220),
            activeColor: Color(0xFFdb99b0),
          ),
        ],
      ),
    );
  }
}
