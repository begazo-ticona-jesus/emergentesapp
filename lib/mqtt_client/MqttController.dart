import 'dart:async';
import 'dart:io';
import 'package:emergentesapp/mqtt_client/MqttConfig.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

Future<MqttServerClient> connect() async {
  MqttServerClient client = MqttServerClient('a12ynynm96xfyz-ats.iot.us-east-1.amazonaws.com', 'clientID');

  client.secure = true;
  client.keepAlivePeriod = 20;
  client.setProtocolV311();
  client.logging(on: false);

  ByteData rootCA = await rootBundle.load('assets/certificates/RootCA.pem');
  ByteData deviceCert = await rootBundle.load('assets/certificates/DeviceCertificate.crt');
  ByteData privateKey = await rootBundle.load('assets/certificates/Private.key');

  SecurityContext clientContext = SecurityContext.defaultContext;
  clientContext.setClientAuthoritiesBytes(rootCA.buffer.asUint8List());
  clientContext.useCertificateChainBytes(deviceCert.buffer.asUint8List());
  clientContext.usePrivateKeyBytes(privateKey.buffer.asUint8List());
  client.securityContext = clientContext;

  client.logging(on: true);
  client.keepAlivePeriod = 20;
  client.port = 8883;
  client.secure = true;

  try {
    await client.connect();
  } catch (e) {
    print('Exception: $e');
    client.disconnect();
    throw Exception('Error connecting to MQTT server');
  }
  return client;
}

Future<String> subscribeToTopic(MqttServerClient client, String topic) {
  final Completer<String> completer = Completer<String>();

  client.subscribe(topic, MqttQos.atMostOnce);
  client.updates?.listen((List<MqttReceivedMessage<MqttMessage>> c) {
    final MqttMessage recMess = c[0].payload!;

    if (recMess is MqttPublishMessage) {
      final MqttPublishPayload payload = recMess.payload;
      final String message =
      MqttPublishPayload.bytesToStringAsString(payload.message);
      print('Received message: $message from topic: ${c[0].topic}');
      completer.complete(message);
    } else {
      print('Received unsupported message type');
      completer.completeError('Received unsupported message type');
    }
  });

  return completer.future;
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
