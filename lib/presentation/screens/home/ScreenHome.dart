import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import '../../../domain/services/mqtt/MqttController.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  bool isSwitched = false;
  bool isManual = false;

  MqttServerClient? mqttController;
  String receivedMessage = 'Mensaje recibido: ';
  bool isConnected = false;

  double _intensity = 0.5;

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

  void _changeSwitch(bool newValue) {
    setState(() {
      isSwitched = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.black, // color de fondo
                borderRadius: BorderRadius.circular(300), // radio de borde redondeado
              ),
              child: Icon(
                isSwitched ? Icons.lightbulb : Icons.lightbulb_outline,
                color: isSwitched ? Colors.yellow : Colors.white,
                size: 300,
              ),
            ),
            onPressed: () {
              _changeSwitch(!isSwitched);
            },
          ),
          // Slider de intensidad agregado aquí
          Slider(
            value: _intensity,
            min: 0.0,
            max: 1.0,
            divisions: 100,
            label: '$_intensity',
            onChanged: (double value) {
              setState(() {
                _intensity = value;
              });
            },
          ),
          // Checkbox manual agregado aquí
          CheckboxListTile(
            title: const Text('Manual'),
            value: isManual,
            onChanged: (bool? value) {
              setState(() {
                isManual = value!;
              });
            },
          ),
          ElevatedButton(
            onPressed: mqttController == null
                ? null
                : () {
              publishToTopic(
                  mqttController!, 'TOPIC_RONY', 'apaga tu foco');
            },
            child: const Text('Publish'),
          ),
        ],
      ),
    );
  }
}