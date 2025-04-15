class CalculadoraImc {
  static String classificarImc(double peso, double altura, String sexo) {
    final imc = peso / (altura * altura);
    String classificacao;

    if (sexo.toLowerCase() == 'masculino') {
      if (imc < 20.7) {
        classificacao = 'Abaixo do peso';
      } else if (imc < 26.4) {
        classificacao = 'Peso ideal';
      } else if (imc < 27.8) {
        classificacao = 'Um pouco acima do peso';
      } else if (imc < 31.1) {
        classificacao = 'Acima do peso';
      } else {
        classificacao = 'Obesidade';
      }
    } else if (sexo.toLowerCase() == 'feminino') {
      if (imc < 19.1) {
        classificacao = 'Abaixo do peso';
      } else if (imc < 25.8) {
        classificacao = 'Peso ideal';
      } else if (imc < 27.3) {
        classificacao = 'Um pouco acima do peso';
      } else if (imc < 32.3) {
        classificacao = 'Acima do peso';
      } else {
        classificacao = 'Obesidade';
      }
    } else {
      classificacao = 'Sexo não reconhecido';
    }

    return 'IMC: ${imc.toStringAsFixed(2)} - $classificacao';
  }
}
