import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String currentTime = '';
  String dayOfWeek = '';
  @override
  void initState() {
    super.initState();
    _updateTime(); // Chama a função de atualização imediatamente
    Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTime(); // Atualiza a hora a cada 1 segundo
    });
  } // Função para atualizar a hora e o dia da semana

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      currentTime = "${now.hour}:${now.minute}:${now.second}";
      dayOfWeek = _getDayOfWeek(now.weekday); // Pega o nome do dia da semana
    });
  }

  // Função para mapear o número do dia da semana para o nome
  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'Segunda-feira';
      case 2:
        return 'Terça-feira';
      case 3:
        return 'Quarta-feira';
      case 4:
        return 'Quinta-feira';
      case 5:
        return 'Sexta-feira';
      case 6:
        return 'Sábado';
      case 7:
        return 'Domingo';
      default:
        return 'Desconhecido';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sensor UV',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 51, 51, 56),

        leading: const Icon(
          Icons.cloud,
          color: Colors.white,
        ), // Ícone no início do AppBar
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 51, 51, 56), // Azul escuro
                Color.fromARGB(255, 21, 24, 26), // Azul claro
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          //  height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 119, 182, 253), // Azul escuro
                      Color.fromARGB(255, 0, 157, 255), // Azul claro
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                margin: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Dia da semana
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.sunny,
                          color: Colors.white,
                          size: 120,
                        ),
                        const SizedBox(width: 8), // Espaço entre os textos
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dayOfWeek,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 25),
                            ),
                            Text(currentTime,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 25)),
                            const Text(
                              "2322",
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Icon(
                              Icons.whatshot_outlined,
                              color: Colors.white,
                              size: 27,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(("awd"),
                                style: TextStyle(color: Colors.white)),
                            Text(
                              "teste",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(
                              Icons.wb_sunny_outlined,
                              color: Colors.white,
                              size: 27,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(("awd"),
                                style: TextStyle(color: Colors.white)),
                            Text(
                              "teste",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(
                              Icons.cloud_queue,
                              color: Colors.white,
                              size: 27,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(("awd"),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              "teste",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(15),
                        child: const Text(
                          "Informações",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(
                              20), // Borda arredondada para o Container principal
                        ),
                        child: ListTile(
                          trailing: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(
                                  15), // Borda arredondada para o leading
                            ),
                            child: const Text(
                              "23230",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          subtitle: const Text("Sensor UV"),
                          title: const Text(
                            "Alerta de radiação UV",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          leading: Container(
                            width: 50, // Define largura para o ícone
                            height: 50, // Define altura para o ícone
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(
                                      255, 119, 182, 253), // Azul escuro
                                  Color.fromARGB(
                                      255, 0, 157, 255), // Azul claro
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(
                                  15), // Borda arredondada para o leading
                            ),
                            child: const Icon(
                              Icons.warning_amber_rounded,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
