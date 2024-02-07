import 'dart:async';
import 'dart:io';
import 'package:emergentesapp/domain/services/mqtt/MqttConfig.dart';
import 'package:flutter/services.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';

Future<MqttServerClient?> connect() async {
  MqttServerClient? client;


  client = MqttServerClient.withPort(MqttConfig.mqttServerUri, '1', 8883);
  client.secure = true;
  client.keepAlivePeriod = 20;
  client.logging(on: false);
  print('instancia creada');
  ByteData rootCA = await rootBundle.load(MqttConfig.caFile);
  ByteData deviceCert = await rootBundle.load(MqttConfig.certFile);
  ByteData privateKey = await rootBundle.load(MqttConfig.keyFile);
  print('Contexto');
  SecurityContext clientContext = SecurityContext.defaultContext;
  clientContext.setTrustedCertificatesBytes(rootCA.buffer.asUint8List());
  clientContext.useCertificateChainBytes(deviceCert.buffer.asUint8List());
  clientContext.usePrivateKeyBytes(privateKey.buffer.asUint8List());
  client.securityContext = clientContext;
  try {
    print('Conectando...');
    await client.connect();
    print('Conectado');
  } catch (e) {
    print('Excepción de conexión: $e');
    client?.disconnect();
  }
  return client;
}

Future<void> publishToTopic(MqttServerClient client, String topic, String message) async {
  final builder = MqttPayloadBuilder();
  builder.addString(message);
  try {
    print('EXAMPLE:: <<<< PUBLISH 1 >>>>');
    client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
    print('EXAMPLE:: <<<< CORRECT PUBLISH $topic>>>>');
  } catch (e) {
    print('Error publishing message: $e');
  }
}

/*Stream<List<MqttReceivedMessage<MqttMessage>>>subscribeToTopic(MqttServerClient client, String topic) {
  client.subscribe(topic, MqttQos.atLeastOnce);
  return client.updates!;
}*/
