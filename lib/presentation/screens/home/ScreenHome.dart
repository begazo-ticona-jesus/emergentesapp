// ignore_for_file: file_names, use_super_parameters, library_private_types_in_public_api
import 'dart:convert';

import 'package:emergentesapp/presentation/screens/home/widgets/CheckboxAutomatic.dart';
import 'package:emergentesapp/presentation/screens/home/widgets/CheckboxCommon.dart';
import 'package:emergentesapp/presentation/screens/home/widgets/SliderIntensity.dart';
import 'package:emergentesapp/presentation/screens/home/widgets/SwitchIcon.dart';
import 'package:emergentesapp/presentation/screens/home/widgets/SwitchTeme.dart';
import 'package:flutter/material.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../../../domain/services/mqtt/MqttController.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  bool isSwitched = false;
  bool isManual = true;
  bool isAutomatic = false;
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
    print("sensores");
    startShakeDetection();
  }


  void startShakeDetection() {
      accelerometerEventStream().listen((AccelerometerEvent event) {
      double x = event.x;
      double y = event.y;
      double z = event.z;
      double rango = 50;
      bool agitacionEnRango = (x > rango || x < -rango || y > rango || y < -rango || z > rango || z < -rango);

      if (!isManual && agitacionEnRango) {
        setState(() {
          isSwitched = !isSwitched;
        });
        String valor = isSwitched ? 'on' : 'off';
        Map<String, dynamic> jsonMessage = {
          'comand': valor,
          'intensity': _intensity.toString(),
          'automatic': isAutomatic
        };
        String jsonString = json.encode(jsonMessage);
        publishToTopic(mqttController!, 'in_topic', jsonString);
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
                isEnabled: !isAutomatic,
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
                  isEnabled: !isAutomatic,
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
                        },
                        isEnabled: !isAutomatic,
                    ),
                    ElevatedButton.icon(
                      onPressed: mqttController == null
                          ? null : () {
                              String valor = isSwitched ? 'on' : 'off';
                              Map<String, dynamic> jsonMessage = {
                                'comand': valor,
                                'intensity': _intensity.toString(),
                                'automatic': isAutomatic
                              };
                              String jsonString = json.encode(jsonMessage);
                              publishToTopic(mqttController!, 'in_topic', jsonString);
                            },
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
              Padding(
                padding:
                  const EdgeInsets.only( top: 10),
                child: CheckboxAutomatic(
                isManual: isAutomatic,
                  onChanged: (bool? value) {
                    setState(() {
                    isAutomatic = value!;
                    isManual = true;
                  });
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
