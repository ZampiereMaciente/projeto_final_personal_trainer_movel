import 'package:flutter/material.dart';
import 'package:projeto_final_personal_trainer/controle/navegacao_controller.dart';
import 'package:projeto_final_personal_trainer/visao/dadosAluno1.dart';

class DadosAntropometria extends StatefulWidget {
  const DadosAntropometria({super.key});

  @override
  State<DadosAntropometria> createState() => _DadosAntropometriaState();
}

class _DadosAntropometriaState extends State<DadosAntropometria> {
  final _formKey = GlobalKey<FormState>();

  // Controllers - Dobras Cutâneas
  final tricepsController = TextEditingController();
  final subescapularController = TextEditingController();
  final suprailicaController = TextEditingController();
  final abdomenDobrasController = TextEditingController();

  // Controllers - Circunferências
  final bracoDirController = TextEditingController();
  final bracoEsqController = TextEditingController();
  final antebracoDirController = TextEditingController();
  final antebracoEsqController = TextEditingController();
  final abdomenCircController = TextEditingController();
  final quadrilController = TextEditingController();
  final cinturaController = TextEditingController();
  final coxaDirController = TextEditingController();
  final coxaEsqController = TextEditingController();
  final pernaDirController = TextEditingController();
  final pernaEsqController = TextEditingController();

  @override
  void dispose() {
    // Dispose de todos os controllers
    tricepsController.dispose();
    subescapularController.dispose();
    suprailicaController.dispose();
    abdomenDobrasController.dispose();

    bracoDirController.dispose();
    bracoEsqController.dispose();
    antebracoDirController.dispose();
    antebracoEsqController.dispose();
    abdomenCircController.dispose();
    quadrilController.dispose();
    cinturaController.dispose();
    coxaDirController.dispose();
    coxaEsqController.dispose();
    pernaDirController.dispose();
    pernaEsqController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dados Antropométricos')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Dobras Cutâneas (mm)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _buildTextField("Tríceps", tricepsController),
              _buildTextField("Subescapular", subescapularController),
              _buildTextField("Suprailíaca", suprailicaController),
              _buildTextField("Abdômen", abdomenDobrasController),

              const SizedBox(height: 24),
              const Text('Circunferências (cm)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              _buildTextField("Braço (dir)", bracoDirController),
              _buildTextField("Braço (esq)", bracoEsqController),
              _buildTextField("Anti Braço (dir)", antebracoDirController),
              _buildTextField("Anti Braço (esq)", antebracoEsqController),
              _buildTextField("Abdômen", abdomenCircController),
              _buildTextField("Quadril", quadrilController),
              _buildTextField("Cintura", cinturaController),
              _buildTextField("Coxa (dir)", coxaDirController),
              _buildTextField("Coxa (esq)", coxaEsqController),
              _buildTextField("Perna (dir)", pernaDirController),
              _buildTextField("Perna (esq)", pernaEsqController),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  NavegacaoController.irParaTelaComValidacao(
                    context: context,
                    formKey: _formKey,
                    proximaTela: const DadosAluno1(),
                  );
                },
                child: const Text("Próximo"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
