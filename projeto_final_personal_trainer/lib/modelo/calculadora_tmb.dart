class CalculadoraTmb {
  static String calcularTmb({
    required double peso,
    required double altura,
    required int idade,
    required String sexo,
  }) {
    double tmb;

    if (sexo == 'Masculino') {
      tmb = 66.47 + (13.75 * peso) + (5.0 * altura) - (6.76 * idade);
    } else {
      tmb = 655.1 + (9.56 * peso) + (1.85 * altura) - (4.68 * idade);
    }

    return "Sua Taxa Metabólica Basal é ${tmb.toStringAsFixed(2)}";
  }
}
