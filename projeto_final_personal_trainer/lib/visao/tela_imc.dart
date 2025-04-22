// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_final_personal_trainer/visao/tela_inicial.dart';
import '../controle/navegacao_controle.dart';
import '../modelo/aluno.dart';
import '../modelo/calculadora_imc.dart';
import '../modelo/calculadora_tmb.dart';
import '../modelo/gerador_pdf.dart';
import '../util/formatadores_input.dart'; // Importa os formatadores

class TelaImc extends StatefulWidget {
  final Aluno aluno;

  const TelaImc({super.key, required this.aluno});

  @override
  State<TelaImc> createState() => _TelaImcState();
}

class _TelaImcState extends State<TelaImc> {
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();

  String _resultadoImc = "";
  String _resultadoTmb = "";
  String _sexoSelecionado = "Masculino";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _calcularImc() {
    final double? altura = double.tryParse(_alturaController.text.replaceAll(',', '.'));
    final double? peso = double.tryParse(_pesoController.text.replaceAll(',', '.'));

    if (altura == null || peso == null || altura <= 0 || peso <= 0) {
      setState(() {
        _resultadoImc = "Insira valores válidos para altura e peso.";
      });
      return;
    }

    final resultado = CalculadoraImc.classificarImc(peso, altura, _sexoSelecionado);
    setState(() {
      _resultadoImc = "IMC: $resultado";
    });
  }

  void _calcularTmb() {
    final double? altura = double.tryParse(_alturaController.text.replaceAll(',', '.'));
    final double? peso = double.tryParse(_pesoController.text.replaceAll(',', '.'));
    final int? idade = int.tryParse(_idadeController.text);

    if (altura == null || peso == null || idade == null || altura <= 0 || peso <= 0 || idade <= 0) {
      setState(() {
        _resultadoTmb = "Insira valores válidos para altura, peso e idade.";
      });
      return;
    }

    final resultado = CalculadoraTmb.calcularTmb(
      peso: peso,
      altura: altura,
      idade: idade,
      sexo: _sexoSelecionado,
    );

    setState(() {
      _resultadoTmb = "TMB: $resultado kcal/dia";
    });
  }

  void _gerarPdf() {
    GeradorPdf.gerarPdf(
      nomeAluno: widget.aluno.nome,
      dadosPessoais: {
        'Nome': widget.aluno.nome,
        'Data de Nascimento': widget.aluno.nascimento,
        'Telefone': widget.aluno.telefone,
        'Email': widget.aluno.email,
        'Data da Próxima Avaliação': widget.aluno.dataProximaAvaliacao,
        'Horário da Próxima Avaliação': widget.aluno.horarioProximaAvaliacao,
      },
      dobrasCutaneas: {
        'Tríceps': widget.aluno.triceps ?? 'Não informado',
        'Subescapular': widget.aluno.subescapular ?? 'Não informado',
        'Suprailíaca': widget.aluno.suprailica ?? 'Não informado',
        'Abdômen (Dobra)': widget.aluno.abdomenDobras ?? 'Não informado',
      },
      circunferencias: {
        'Braço (dir)': widget.aluno.bracoDir ?? 'Não informado',
        'Braço (esq)': widget.aluno.bracoEsq ?? 'Não informado',
        'Antibraço (dir)': widget.aluno.antebracoDir ?? 'Não informado',
        'Antibraço (esq)': widget.aluno.antebracoEsq ?? 'Não informado',
        'Abdômen': widget.aluno.abdomenCirc ?? 'Não informado',
        'Quadril': widget.aluno.quadril ?? 'Não informado',
        'Cintura': widget.aluno.cintura ?? 'Não informado',
        'Coxa (dir)': widget.aluno.coxaDir ?? 'Não informado',
        'Coxa (esq)': widget.aluno.coxaEsq ?? 'Não informado',
        'Perna (dir)': widget.aluno.pernaDir ?? 'Não informado',
        'Perna (esq)': widget.aluno.pernaEsq ?? 'Não informado',
      },
      dadosImcTmb: {
        'Altura': _alturaController.text,
        'Peso': _pesoController.text,
        'Idade': _idadeController.text,
        'Sexo': _sexoSelecionado,
        'Resultado IMC': _resultadoImc,
        'Resultado TMB': _resultadoTmb,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Cálculo de IMC e TMB',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(color: Colors.black, blurRadius: 4, offset: Offset(2, 2)),
            ],
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/academia8.png', fit: BoxFit.cover),
          ),
          Container(color: Colors.black.withOpacity(0.5)),
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 100, left: 24.0, right: 24.0, bottom: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(_alturaController, 'Altura em metros (ex: 1.70)', FormatadoresInput.altura),
                  const SizedBox(height: 16),
                  _buildTextField(_pesoController, 'Peso em Kilos (ex: 75)', FormatadoresInput.peso),
                  const SizedBox(height: 16),
                  _buildTextField(_idadeController, 'Idade (ex: 23)', FormatadoresInput.idade),
                  const SizedBox(height: 16),
                  _buildDropdownSexo(),
                  const SizedBox(height: 24),
                  _buildBotao("Calcular Índice de Massa Corporal (IMC)", _calcularImc),
                  const SizedBox(height: 12),
                  _buildResultadoTexto(_resultadoImc),
                  const SizedBox(height: 32),
                  _buildBotao("Calcular Taxa Metabólica Basal (TMB)", _calcularTmb),
                  const SizedBox(height: 12),
                  _buildResultadoTexto(_resultadoTmb),
                  const SizedBox(height: 32),
                  _buildBotao("Gerar PDF", _gerarPdf, color: Colors.redAccent),
                  const SizedBox(height: 24),
                  _buildBotao(
                    "Ir para Tela Principal",
                        () {
                      NavegacaoController.irParaTelaComValidacao(
                        context: context,
                        formKey: _formKey,
                        proximaTela: TelaInicial(),
                      );
                    },
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, TextInputFormatter formatter) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [formatter],
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira o valor';
        }
        return null;
      },
    );
  }

  Widget _buildDropdownSexo() {
    return DropdownButtonFormField<String>(
      value: _sexoSelecionado,
      dropdownColor: Colors.grey[900],
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: 'Sexo',
        labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
      ),
      items: const [
        DropdownMenuItem(value: 'Masculino', child: Text('Masculino', style: TextStyle(color: Colors.white))),
        DropdownMenuItem(value: 'Feminino', child: Text('Feminino', style: TextStyle(color: Colors.white))),
      ],
      onChanged: (value) {
        setState(() {
          _sexoSelecionado = value!;
        });
      },
    );
  }

  Widget _buildBotao(String texto, VoidCallback onPressed, {Color color = Colors.teal}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(texto),
    );
  }

  Widget _buildResultadoTexto(String resultado) {
    return Text(
      resultado,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      textAlign: TextAlign.center,
    );
  }
}
