import 'package:emergentesapp/presentation/screens/home/widgets/CheckboxCommon.dart';
import 'package:emergentesapp/presentation/screens/home/widgets/SliderIntensity.dart';
import 'package:emergentesapp/presentation/screens/home/widgets/SwitchIcon.dart';
import 'package:emergentesapp/presentation/screens/home/widgets/SwitchTeme.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
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
  bool isConnected = false;
  double _intensity = 0.5;
  bool isShakeEnabled = false;

  @override
  void initState() {
    super.initState();
    connect().then((value) {
      setState(() {
        mqttController = value;
        isConnected = true;
      });
    });
    _startShakeDetection();
  }

  void toggleShake() {
    setState(() {
      isShakeEnabled = !isShakeEnabled;
    });
  }

  void _startShakeDetection() {
    accelerometerEventStream().listen((AccelerometerEvent event) {
      double x = event.x;
      double y = event.y;
      double z = event.z;
      double rango = 30;
      bool agitacionEnRango = (x > rango || x < -rango || y > rango || y < -rango || z > rango || z < -rango);

      if (isShakeEnabled && agitacionEnRango) {
        print('Shake detected!');
        // Code to shake the screen
      }
    });
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
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 70.0, bottom: 10.0),
            child: Text(
              'Opciones de control',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Color(0xFF343764),
                    offset: Offset(2.0, 2.0),
                    blurRadius: 3.0,
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomSwitchTheme(),
              SwitchIcon(
                isSwitched: isSwitched,
                onChanged: _changeSwitch,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SliderIntensity(
                  // Usa el widget del slider de intensidad
                  intensity: _intensity,
                  onChanged: (double value) {
                    setState(() {
                      _intensity = value;
                    });
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 50.0, left: 50.0, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CheckboxCommon(
                        isManual: isManual,
                        onChanged: (bool? value) {
                          setState(() {
                            isManual = value!;
                          });
                        }),
                    ElevatedButton.icon(
                      onPressed: mqttController == null
                          ? null
                          : () {
                              publishToTopic(mqttController!, 'TOPIC_RONY',
                                  'apaga tu foco');
                            },
                      label: const Text(
                        'Enviar',
                        style: TextStyle(
                          color: Colors
                              .white, // Cambia el color del texto según tus preferencias
                        ),
                      ),
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ), // Cambia el icono según tus preferencias
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFa4acf4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
