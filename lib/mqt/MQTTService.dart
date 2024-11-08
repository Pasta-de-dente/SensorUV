import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTService {
  late MqttServerClient client;
  final String broker = 'broker.hivemq.com';
  final int port = 1883;
  final String topic = 'dispositivo/dados';

  // Callback para notificar mudanças no estado de conexão
  Function(bool)? onConnectionStatusChanged;

  MQTTService() {
    client = MqttServerClient(broker, '');
    client.port = port;
    client.logging(on: true);
    client.keepAlivePeriod = 20;

    // Configura callbacks para eventos de conexão
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;
  }

  Future<void> connect() async {
    try {
      await client.connect();
    } catch (e) {
      print('Erro ao conectar: $e');
      client.disconnect();
      onConnectionStatusChanged?.call(false); // Notifica desconexão
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('Conectado ao broker');
      onConnectionStatusChanged?.call(true); // Notifica conexão
      client.subscribe(topic, MqttQos.atMostOnce);
    } else {
      print('Falha ao conectar: ${client.connectionStatus}');
      onConnectionStatusChanged?.call(false); // Notifica desconexão
    }

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> events) {
      final MqttPublishMessage recMess =
          events[0].payload as MqttPublishMessage;
      final String payload =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      print('Mensagem recebida: $payload');
      // Processar a mensagem recebida (como atualizar o estado do app)
    });
  }

  // Callback de eventos de conexão
  void onConnected() {
    print('Conectado ao broker!');
    onConnectionStatusChanged?.call(true); // Notifica conexão
  }

  void onDisconnected() {
    print('Desconectado do broker');
    onConnectionStatusChanged?.call(false); // Notifica desconexão
  }

  void onSubscribed(String topic) => print('Inscrito no tópico: $topic');
  void onUnsubscribed(String? topic) =>
      print('Cancelou inscrição no tópico: $topic');
  void onSubscribeFail(String topic) =>
      print('Falha ao se inscrever no tópico: $topic');
  void pong() => print('Ping recebido do broker');
}
