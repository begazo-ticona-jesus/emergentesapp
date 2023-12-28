// ignore_for_file: library_private_types_in_public_api, file_names

//import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:emergentesapp/mqtt_client/MqttController.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import '../../components/Actions.dart' as MyActions;
import '../../components/stateActions.dart';
import 'package:intl/intl.dart';
import '../../components/stateSwitched.dart';
import 'package:provider/provider.dart';

class ScreenOptions extends StatefulWidget {
  const ScreenOptions({super.key});
  @override
  _ScreenOptionsState createState() => _ScreenOptionsState();
}

class _ScreenOptionsState extends State<ScreenOptions> {
  MqttServerClient? mqttController;
  String receivedMessage = 'Mensaje recibido: ';
  bool isConnected = false;

  bool _isSwitched = false;

  @override
  void initState() {
    connect().then((value) {
      setState(() {
        mqttController = value;
        isConnected = true;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    if (isConnected) {
      mqttController!.disconnect();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Good night',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox( height: 10), 
          // Agrega un espacio vertical entre el texto y la fecha
          Text(
            _getCurrentDateFormatted(),
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          Switch(
            value: context.watch<StateWitched>().isSwitched,
            onChanged: (value) {
              context.read<StateWitched>().isSwitched = value;
              
              if (value) {
                // Acción cuando el switch se enciende
                MyActions.Actions newAction = MyActions.Actions('Switch ON', DateTime.now());
                appState.listOfActions.add(newAction);
              } else {
                // Acción cuando el switch se apaga
                MyActions.Actions newAction = MyActions.Actions('Switch OFF', DateTime.now());
                appState.listOfActions.add(newAction);
              }

            },
            activeTrackColor: const Color(0xFFdb99b0),
            activeColor: const Color(0xFFdb99b0),
          ),

          const SizedBox( height: 100), 
                  
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    publishToTopic(
                        mqttController!, 'TOPIC_RONY', 'apaga tu foco');
                  },
                  child: const Text('Publish'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String message =
                        await subscribeToTopic(mqttController!, 'TOPIC_RONY');
                    setState(() {
                      receivedMessage = 'Mensaje recibido: $message';
                    });
                  },
                  child: const Text('Subscribe'),
                ),
                const SizedBox(height: 20),
                Text(
                  receivedMessage,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),

          const Spacer(),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(0),
              child: 
              Container(
                padding: EdgeInsets.all(10),
                //color: Colors.black.withOpacity(0.5), // Ajusta la opacidad según tus necesidades
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: const Color.fromARGB(235, 255, 255, 255),
                    child: const ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.access_time),
                          SizedBox(width: 8),
                          Text('Mensaje Recibido - hora'),
                        ],
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                        child: Text(
                            'Dato recibido*',
                            style: TextStyle(
                              fontSize: 15,
                              ),
                            
                          ),
                      )
                          
                    ),
                  ),

                  ],
                )
              )
            ),
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
}
