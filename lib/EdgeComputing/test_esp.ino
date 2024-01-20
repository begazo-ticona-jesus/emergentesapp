#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <ArduinoJson.h>  // Incluye la biblioteca ArduinoJSON


const char* ssid = "Harold.V";
const char* password = "1234567890.";
const char* mqtt_server = "192.168.5.199";

const int lightPin = A0;
bool systemOn = true;

WiFiClient espClient;
PubSubClient client(espClient);

void callback(char *topic, byte *payload, unsigned int length) {
  Serial.print("Mensaje recibido en [");
  Serial.print(topic);
  Serial.println("]");

  String message = "";
  for (int i = 0; i < length; i++) {
    message += (char)payload[i];
  }
  Serial.println(message);
  /*
  const size_t capacity = JSON_OBJECT_SIZE(5);
  DynamicJsonDocument jsonDoc(capacity);
  DeserializationError error = deserializeJson(jsonDoc, message);

  if (error) {
    Serial.print("deserializeJson() failed: ");
    Serial.println(error.c_str());
    return;
  }
 
  String command = jsonDoc["command"];
  */
  if (message.equals("ON")) {
    systemOn = true;
    digitalWrite(BUILTIN_LED, LOW);  // Enciende el LED incorporado
  } else if (message.equals("OFF")) {
    systemOn = false;
    digitalWrite(BUILTIN_LED, HIGH);   // Apaga el LED incorporado
  }
  //Serial.println(command);
}


void setup() {
Serial.begin(115200);  // Inicia la comunicación serie
  Serial.println("Iniciando...");

  pinMode(BUILTIN_LED, OUTPUT);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Conectando WiFi...");
  }

  Serial.println("Conectado a la red...");
  client.setServer(mqtt_server, 1883);
  client.setCallback(callback);
  client.subscribe("iot_in");
}



void loop() {
  if (!client.connected()) {
    reconnect();
  }
  client.loop();
  if (systemOn) {
    // Leer el valor del sensor de luz y publicar en el broker
    int lightValue = analogRead(lightPin);
    client.publish("light", String(lightValue).c_str());
    Serial.print("Valor de luz: ");
    Serial.println(lightValue);
  }

  delay(1000);
}



void reconnect() {
  while (!client.connected()) {
    Serial.println("Intentando reconectar al MQTT Broker...");
    if (client.connect("ESP8266_Cliente")) {
      Serial.println("Conectado al MQTT Broker");
      client.subscribe("iot_in");
    } else {
      Serial.print("Error de conexión - Estado: ");
      Serial.println(client.state());
      delay(5000);
    }
  }
}



/**
const int lightPin = A0;
const int motionPin = D6;
const int ledPin = D2;

bool systenOn = true;

void setup() {
  Serial.begin(115200);
  pinMode(lightPin, INPUT);
  pinMode(motionPin, INPUT);
 

  // Es necesario esperar para estabilizar el sensor.
  Serial.println("Estabilizando");
  delay(60*1000);
  Serial.println("Fin setup");
}
/* Lectura de datos 
int lightValue = analogRead(lightPin);
int motionValue = digitalRead(motionPin);

Serial.println(lightValue);


if (lightValue < 300) {
  digitalWrite(BUILTIN_LED, HIGH);
}
else {
  digitalWrite(BUILTIN_LED, LOW);
}
Encendido y apagado del foco segun sea el caso 
**/
