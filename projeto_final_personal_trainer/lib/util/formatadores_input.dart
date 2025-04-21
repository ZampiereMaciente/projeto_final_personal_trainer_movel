import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AlturaInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (newText.isEmpty) {
      return newValue.copyWith(text: '', selection: const TextSelection.collapsed(offset: 0));
    }

    String formatted = '';
    if (newText.length == 1) {
      formatted = '0.${newText}';
    } else {
      final beforeDot = newText.substring(0, newText.length - 1);
      final afterDot = newText.substring(newText.length - 1);
      formatted = '$beforeDot.$afterDot';
    }

    final newOffset = formatted.length;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }
}

class DataInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length > 8) digits = digits.substring(0, 8);

    String newText = '';
    for (int i = 0; i < digits.length; i++) {
      if (i == 2 || i == 4) newText += '/';
      newText += digits[i];
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class TelefoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String digits = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Limita a 11 dígitos (formato brasileiro com DDD)
    if (digits.length > 11) {
      digits = digits.substring(0, 11);
    }

    // Se o campo estiver vazio, retorna diretamente
    if (digits.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    String formatted = '';
    if (digits.length < 3) {
      formatted = '(${digits.substring(0, digits.length)}';
    } else if (digits.length < 7) {
      formatted = '(${digits.substring(0, 2)}) ${digits.substring(2)}';
    } else if (digits.length <= 10) {
      formatted =
      '(${digits.substring(0, 2)}) ${digits.substring(2, 6)}-${digits.substring(6)}';
    } else {
      formatted =
      '(${digits.substring(0, 2)}) ${digits.substring(2, 7)}-${digits.substring(7)}';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
