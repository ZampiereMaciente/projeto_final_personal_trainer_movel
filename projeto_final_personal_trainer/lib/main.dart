import 'package:flutter/material.dart';
import 'package:projeto_final_personal_trainer/visao/tela_inicial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avaliação Física',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TelaInicial(),
      debugShowCheckedModeBanner: false,
    );
  }
}
