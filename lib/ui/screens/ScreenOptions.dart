import 'dart:async';
import 'package:flutter/material.dart';
import 'package:emergentesapp/mqtt_client/MqttController.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class ScreenOptions extends StatefulWidget {
  const ScreenOptions({super.key});
  @override
  _ScreenOptionsState createState() => _ScreenOptionsState();
}

class _ScreenOptionsState extends State<ScreenOptions> {
  MqttServerClient? mqttController;
  String receivedMessage = 'Mensaje recibido: ';
  bool isConnected = false;

  @override
  void initState(){
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              publishToTopic(mqttController!, 'TOPIC_RONY', 'apaga tu foco');
            },
            child: const Text('Publish'),
          ),
          ElevatedButton(
            onPressed: () async {
              String message = await subscribeToTopic(mqttController!, 'TOPIC_RONY');
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
    );
  }
}