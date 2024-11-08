import 'package:flutter/material.dart';
import 'package:sensor_uv/Screens/Home.dart';
import 'package:sensor_uv/mqt/MQTTService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MQTTService mqttService;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    mqttService = MQTTService();
    mqttService.onConnectionStatusChanged = (status) {
      setState(() {
        isConnected = status;
      });
    };
    mqttService.connect(); // Inicia a conexão ao app iniciar
  }

  @override
  void dispose() {
    mqttService.client.disconnect(); // Desconecta ao fechar o app
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: isConnected ? const MyWidget() : DisconnectedScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Exemplo de tela de desconexão
class DisconnectedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Desconectado do broker MQTT',
        style: TextStyle(fontSize: 24, color: Colors.red),
      ),
    );
  }
}
