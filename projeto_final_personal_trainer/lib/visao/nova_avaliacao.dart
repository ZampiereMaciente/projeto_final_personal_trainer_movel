import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_final_personal_trainer/visao/dados_antropometria.dart';
import '../modelo/aluno.dart';
import 'package:projeto_final_personal_trainer/util/formatadores_input.dart';

class NovaAvaliacao extends StatefulWidget {
  const NovaAvaliacao({Key? key}) : super(key: key);

  @override
  State<NovaAvaliacao> createState() => _NovaAvaliacaoState();
}

class _NovaAvaliacaoState extends State<NovaAvaliacao> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final nascimentoController = TextEditingController();
  final telefoneController = TextEditingController();
  final emailController = TextEditingController();
  final dataProxController = TextEditingController();
  final horarioProxController = TextEditingController(); // Controller para horário

  @override
  void dispose() {
    nomeController.dispose();
    nascimentoController.dispose();
    telefoneController.dispose();
    emailController.dispose();
    dataProxController.dispose();
    horarioProxController.dispose(); // Dispose do controller de horário
    super.dispose();
  }

  void _irParaProximaTela() {
    if (_formKey.currentState!.validate()) {
      final aluno = Aluno(
        nome: nomeController.text,
        nascimento: nascimentoController.text,
        telefone: telefoneController.text,
        email: emailController.text,
        dataProximaAvaliacao: dataProxController.text,
        horarioProximaAvaliacao: horarioProxController.text, // Passando o horário para o objeto aluno
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DadosAntropometria(aluno: aluno),
        ),
      );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    List<TextInputFormatter>? inputFormatters,
    TextInputType? keyboardType,
    String? hint,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: Colors.white70,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Dados Pessoais do Aluno',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.black,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
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
            child: Image.asset(
              'assets/images/academia2.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: screenHeight),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: kToolbarHeight + 16),
                        _buildTextField(
                          controller: nomeController,
                          label: "Nome",
                          validator: (value) =>
                          value == null || value.isEmpty ? "Digite o nome" : null,
                        ),
                        _buildTextField(
                          controller: nascimentoController,
                          label: "Data de Nascimento",
                          hint: "DD/MM/AAAA",
                          keyboardType: TextInputType.number,
                          inputFormatters: [FormatadoresInput.data],
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Informe a data';
                            final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
                            if (digits.length != 8) return 'Data incompleta';
                            return null;
                          },
                        ),
                        _buildTextField(
                          controller: telefoneController,
                          label: "Telefone",
                          hint: "(XX) XXXXX-XXXX",
                          keyboardType: TextInputType.phone,
                          inputFormatters: [FormatadoresInput.telefone],
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Informe o telefone';
                            final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
                            if (digits.length < 10) return 'Telefone inválido';
                            return null;
                          },
                        ),
                        _buildTextField(
                          controller: emailController,
                          label: "E-mail",
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Informe o e-mail';
                            if (!value.contains('@') || !value.contains('.')) {
                              return 'E-mail inválido';
                            }
                            return null;
                          },
                        ),
                        _buildTextField(
                          controller: dataProxController,
                          label: "Data da Próxima Avaliação",
                          hint: "DD/MM/AAAA",
                          keyboardType: TextInputType.number,
                          inputFormatters: [FormatadoresInput.data],
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Informe a data';
                            final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
                            if (digits.length != 8) return 'Data incompleta';
                            return null;
                          },
                        ),
                        _buildTextField(
                          controller: horarioProxController,
                          label: "Horário da Próxima Avaliação",
                          hint: "HH:mm",
                          keyboardType: TextInputType.number,
                          inputFormatters: [FormatadoresInput.hora], // Usando o formatador de hora
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Informe o horário';
                            final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
                            // Alterando a verificação para aceitar o formato HH:mm
                            if (digits.length != 4) return 'Horário incompleto. Exemplo: 08:30';
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _irParaProximaTela,
                            child: const Text("Próximo"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightGreen,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
