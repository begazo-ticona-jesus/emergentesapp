// ignore_for_file: file_names, use_build_context_synchronously, library_prefixes, use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../components/Actions.dart' as MyActions;
import '../../components/stateActions.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:emergentesapp/presentation/screens/userLogin/ScreenLogin.dart';


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

    User? user = FirebaseAuth.instance.currentUser;
    String userName = user != null ? user.displayName ?? 'Usuario' : 'Usuario';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome, ',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            userName,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
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
                              style: const TextStyle(fontSize: 15),
                              
                            ),
                        )
                            
                      ),
                    );
                  },
                )),
          ),

          ElevatedButton(
            onPressed: () async {
              await GoogleSignIn().signOut(); // Cerrar sesión de Google
              await FirebaseAuth.instance.signOut(); // Cerrar sesión de Firebase

              // Navegar de regreso a la pantalla de inicio de sesión
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const ScreenLogin()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            child: const Text('Sing Out'),
          )

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