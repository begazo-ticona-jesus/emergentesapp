import 'dart:async';
import 'dart:io';
import 'package:emergentesapp/domain/services/mqtt/MqttConfig.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

Future<MqttServerClient> connect() async {

  final client = MqttServerClient.withPort(MqttConfig.mqttServerUri, '', 8883);
  client.secure = true;
  client.keepAlivePeriod = 20;
  client.setProtocolV311();
  client.logging(on: false);

  ByteData rootCA = await rootBundle.load(MqttConfig.caFile);
  ByteData deviceCert = await rootBundle.load(MqttConfig.certFile);
  ByteData privateKey = await rootBundle.load(MqttConfig.keyFile);

  SecurityContext clientContext = SecurityContext.defaultContext;
  clientContext.setClientAuthoritiesBytes(rootCA.buffer.asUint8List());
  clientContext.useCertificateChainBytes(deviceCert.buffer.asUint8List());
  clientContext.usePrivateKeyBytes(privateKey.buffer.asUint8List());
  client.securityContext = clientContext;

  try {
    await client.connect();
    print('conectado');
    //subscribeToTopic(client, 'TOPIC_RONY');
  } catch (e) {
    print('Exception: $e');
    client.disconnect();
    throw Exception('Error connecting to MQTT server');
  }
  return client;
}

Future<void> publishToTopic(MqttServerClient client, String topic, String message) async {
  final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
  builder.addString(message);

  try {
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
    print('Message published to topic $topic');
  } catch (e) {
    print('Error publishing message: $e');
  }
}

/*Stream<List<MqttReceivedMessage<MqttMessage>>>subscribeToTopic(MqttServerClient client, String topic) {
  client.subscribe(topic, MqttQos.atLeastOnce);
  return client.updates!;
}*/
