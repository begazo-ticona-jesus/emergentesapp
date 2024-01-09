// ignore_for_file: file_names, use_super_parameters, library_private_types_in_public_api

import 'package:emergentesapp/presentation/screens/home/widgets/CheckboxCommon.dart';
import 'package:emergentesapp/presentation/screens/home/widgets/SliderIntensity.dart';
import 'package:emergentesapp/presentation/screens/home/widgets/SwitchIcon.dart';
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
      child: ClipRect(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          verticalDirection: VerticalDirection.down,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                'Sistema de Control',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  //shadows: [ Shadow( color: Color(0xFF343764), offset: Offset(2.0, 2.0), blurRadius: 3.0, ),],
                ),
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  //CustomSwitchTheme(),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: SwitchIcon(
                      isSwitched: isSwitched,
                      onChanged: _changeSwitch,
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.only(right: 50.0, left: 50.0, top: 35),
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
                        const EdgeInsets.only(right: 50.0, left: 50.0, top: 25),
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
                          onPressed: mqttController == null ? null : () {
                            publishToTopic(mqttController!, 'TOPIC_RONY',
                                'apaga tu foco');
                          },
                          label: const Text(
                            'Enviar',
                            style: TextStyle(color: Color(0xFF343764)),
                          ),
                          icon: const Icon(
                            Icons.send,
                            color: Color(0xFF343764),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(right: 25, left: 25),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      );
  }
}
