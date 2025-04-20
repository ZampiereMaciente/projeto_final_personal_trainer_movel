import 'package:flutter/material.dart';
import 'package:projeto_final_personal_trainer/visao/tela_inicial.dart';
import '../controle/navegacao_controle.dart';
import '../modelo/aluno.dart';
import '../modelo/calculadora_imc.dart';
import '../modelo/calculadora_tmb.dart';
import '../modelo/gerador_pdf.dart';

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
    final double? altura = double.tryParse(_alturaController.text);
    final double? peso = double.tryParse(_pesoController.text);

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
    final double? altura = double.tryParse(_alturaController.text);
    final double? peso = double.tryParse(_pesoController.text);
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
        'Nome': widget.aluno.nome ?? 'Não informado',
        'Data de Nascimento': widget.aluno.nascimento ?? 'Não informado',
        'Telefone': widget.aluno.telefone ?? 'Não informado',
        'Email': widget.aluno.email ?? 'Não informado',
        'Data da Próxima Avaliação': widget.aluno.dataProximaAvaliacao ?? 'Não informado',
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
        'Altura': _alturaController.text,
        'Peso': _pesoController.text,
        'Idade': _idadeController.text,
        'Sexo': _sexoSelecionado,
      },
      resultadoImc: _resultadoImc,
      resultadoTmb: _resultadoTmb, // <-- Adicionado aqui
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cálculo de IMC e TMB"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextField(
                    controller: _alturaController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Altura com ponto, Exemplo: 1.60',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _pesoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Peso, Exemplo: 60',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _idadeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Idade, Exemplo: 25',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _sexoSelecionado,
                    decoration: const InputDecoration(
                      labelText: 'Sexo',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
                      DropdownMenuItem(value: 'Feminino', child: Text('Feminino')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _sexoSelecionado = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            /// Botão de Calcular IMC
            ElevatedButton(
              onPressed: _calcularImc,
              child: const Text("Calcular IMC"),
            ),
            const SizedBox(height: 12),
            Text(
              _resultadoImc,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            /// Botão de Calcular TMB
            ElevatedButton(
              onPressed: _calcularTmb,
              child: const Text("Calcular TMB"),
            ),
            const SizedBox(height: 12),
            Text(
              _resultadoTmb,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _gerarPdf,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Gerar PDF"),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                NavegacaoController.irParaTelaComValidacao(
                  context: context,
                  formKey: _formKey,
                  proximaTela: TelaInicial(),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text("Ir para Tela Principal"),
            ),
          ],
        ),
      ),
    );
  }
}
