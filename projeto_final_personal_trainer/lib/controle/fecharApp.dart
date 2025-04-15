import 'dart:io';
import 'package:flutter/material.dart';

class FecharApp {
  static void fecharApp(BuildContext context) async {
    final bool? confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sair do App"),
        content: const Text("Tem certeza que deseja sair do aplicativo?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Sair"),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      exit(0);
    }
  }
}
