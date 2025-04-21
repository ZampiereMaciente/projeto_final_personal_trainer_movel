import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_final_personal_trainer/visao/dados_antropometria.dart';
import '../modelo/aluno.dart';
import 'package:projeto_final_personal_trainer/util/formatadores_input.dart';

class NovaAvaliacao extends StatefulWidget {
  const NovaAvaliacao({Key? key}) : super(key: key);

  @override
  _NovaAvaliacaoState createState() => _NovaAvaliacaoState();
}

class _NovaAvaliacaoState extends State<NovaAvaliacao> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final nascimentoController = TextEditingController();
  final telefoneController = TextEditingController();
  final emailController = TextEditingController();
  final dataProxController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    nascimentoController.dispose();
    telefoneController.dispose();
    emailController.dispose();
    dataProxController.dispose();
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
          // Fundo com imagem
          Positioned.fill(
            child: Image.asset(
              'assets/images/academia2.png',
              fit: BoxFit.cover,
            ),
          ),
          // Camada escura sobre a imagem
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),
          // Conteúdo principal
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
                          validator: (value) => value == null || value.isEmpty ? "Digite o nome" : null,
                        ),
                        _buildTextField(
                          controller: nascimentoController,
                          label: "Data de Nascimento",
                          hint: "DD/MM/AAAA",
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            DataInputFormatter(),
                          ],
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter(),
                          ],
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            DataInputFormatter(),
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Informe a data';
                            final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
                            if (digits.length != 8) return 'Data incompleta';
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
