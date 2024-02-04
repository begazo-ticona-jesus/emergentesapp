// ignore_for_file: file_names, use_super_parameters, library_private_types_in_public_api

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
  bool isManual = true;
  MqttServerClient? mqttController;
  bool isConnected = false;
  double _intensity = 0.5;
  bool isShakeEnabled = false;

  @override
  void initState() {
    super.initState();
    connect().then((value) {
      if (value != null) {
        setState(() {
          mqttController = value;
          isConnected = true;
        });
      }
    });
    print("sensores");
    startShakeDetection();
  }

  void startShakeDetection() {
      accelerometerEventStream().listen((AccelerometerEvent event) {
      double x = event.x;
      double y = event.y;
      double z = event.z;
      double rango = 35;
      bool agitacionEnRango = (x > rango || x < -rango || y > rango || y < -rango || z > rango || z < -rango);

      if (!isManual && agitacionEnRango) {
        setState(() {
          isSwitched = !isSwitched;
        });
        String valor = isSwitched ? 'on' : 'off';
        print("shake detected");
        print("instruccion: "+valor);
        print("intesidad: "+_intensity.toString());
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
                      onPressed: isConnected && mqttController != null
                          ? () {
                              String valor = isSwitched?  'on' : 'off';
                              publishToTopic(mqttController!, 'TOPIC_RONY',
                                  valor);
                              print("instruccion: "+valor);
                              print("intesidad: "+_intensity.toString());
                            }
                          : null,
                      label: const Text(
                        'Enviar',
                        style: TextStyle(
                          color: Colors.white,
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
