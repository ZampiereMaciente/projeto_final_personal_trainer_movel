import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class FormatadoresInput {
  /// Formato: DD/MM/AAAA
  static final data = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  /// Formato: (99) 99999-9999
  static final telefone = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  /// Formato: CPF - 999.999.999-99
  static final cpf = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  /// Formato: peso com 2 casas decimais - ex: 75.50
  static final peso = MaskTextInputFormatter(
    mask: '###.##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  /// Idade (2 dígitos)
  static final idade = MaskTextInputFormatter(
    mask: '##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  /// Altura customizada (ex: 1.75) com ponto após o primeiro dígito
  static final altura = _AlturaInputFormatter();

  /// Formato: Hora (24h) - HH:mm
  static final hora = MaskTextInputFormatter(
    mask: '##:##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
}

class _AlturaInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digitsOnly.isEmpty) {
      return const TextEditingValue().copyWith(
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    // Limita a altura a 3 dígitos (ex: 2.15)
    if (digitsOnly.length > 3) {
      digitsOnly = digitsOnly.substring(0, 3);
    }

    // Formata como X.XX
    String formatted = digitsOnly.length == 1
        ? digitsOnly
        : '${digitsOnly.substring(0, 1)}.${digitsOnly.substring(1)}';

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
