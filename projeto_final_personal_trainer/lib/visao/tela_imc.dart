import 'package:flutter/material.dart';
import 'package:projeto_final_personal_trainer/visao/telaInicial.dart';
import '../controle/navegacao_controller.dart';
import '../modelo/aluno.dart';
import '../modelo/calculadora_imc.dart';
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

  String _resultado = "";
  String _sexoSelecionado = "Masculino";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Adicionando uma chave para o formulário

  void _calcularImc() {
    final double? altura = double.tryParse(_alturaController.text);
    final double? peso = double.tryParse(_pesoController.text);

    if (altura == null || peso == null || altura <= 0 || peso <= 0) {
      setState(() {
        _resultado = "Insira valores válidos para altura e peso.";
      });
      return;
    }

    final resultado = CalculadoraImc.classificarImc(peso, altura, _sexoSelecionado);
    setState(() {
      _resultado = resultado;
    });
  }

  void _gerarPdf() {
    GeradorPdf.gerarPdf(
      nomeAluno: widget.aluno.nome,  // Passando o nome do aluno para gerar o nome do arquivo
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
      resultadoImc: _resultado,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cálculo de IMC"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Form(
              key: _formKey, // Formulário usando a chave de validação
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
            ElevatedButton(
              onPressed: _calcularImc,
              child: const Text("Calcular IMC"),
            ),
            const SizedBox(height: 24),
            Text(
              _resultado,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
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
                  proximaTela: TelaInicial(), // Substitua TelaInicial() pela sua tela principal
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
