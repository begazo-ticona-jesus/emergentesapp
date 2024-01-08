// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../components/Actions.dart' as MyActions;
import '../../components/stateActions.dart';

class ScreenAccount extends StatefulWidget {
  const ScreenAccount({Key? key}) : super(key: key);

  @override
  _ScreenAccountState createState() => _ScreenAccountState();
}

class _ScreenAccountState extends State<ScreenAccount> {
  List<MyActions.Actions> listOfActions = appState.listOfActions;
  bool _openingActionAdded = false;

  @override
  void initState() {
    super.initState();

    // Asegurarse de que _addOpeningAction se ejecute solo una vez
    if (!_openingActionAdded) {
      _addOpeningAction();
      _openingActionAdded = true;
    }

    // ... otros códigos de initState ...
  }

  void _addOpeningAction() {
    if (!listOfActions.any((action) => action.name == "Ingreso")) {
      DateTime now = DateTime.now();
      MyActions.Actions openingAction = MyActions.Actions("Ingreso", now);
      listOfActions.add(openingAction);
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('es', null);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome, Rian',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
              height:
                  10), // Agrega un espacio vertical entre el texto y la fecha
          Text(
            _getCurrentDateFormatted(),
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.only(
                    top: 30,
                    bottom: 10), // Ajusta este valor según tus necesidades
                child: ListView.builder(
                  itemCount: listOfActions.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: const Color.fromARGB(235, 255, 255, 255),
                      child: ListTile(
                        title: Row(
                          children: [
                            const Icon(Icons.access_time),
                            const SizedBox(width: 8),
                            Text(listOfActions[index].name),
                          ],
                        ),
                        subtitle:Container(
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                          child: Text(
                              _getCurrentTime(listOfActions[index].time),
                              style: TextStyle(fontSize: 15),
                              
                            ),
                        )
                            
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }

  String _getCurrentDateFormatted() {
    var now = DateTime.now();
    var formatter = DateFormat('d MMMM, yyyy',
        'es'); // 'es' para idioma español, puedes ajustar según tu idioma
    return formatter.format(now);
  }

  String _getCurrentTime(DateTime time) {
    var formatter = DateFormat('HH:mm:ss');
    return formatter.format(time);
  }
}