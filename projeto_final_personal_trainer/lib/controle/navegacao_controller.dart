import 'package:flutter/material.dart';

class NavegacaoController {
  static void irParaTelaComValidacao({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required Widget proximaTela,
  }) {
    if (formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => proximaTela),
      );
    }
  }
}
