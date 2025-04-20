import 'package:flutter/material.dart';
import 'package:projeto_final_personal_trainer/visao/dados_antropometria.dart';
import '../modelo/aluno.dart';
import 'teste.dart'; // Aqui está sua classe Aluno

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dados Pessoais do Aluno")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: "Nome"),
                validator: (value) => value == null || value.isEmpty ? "Digite o nome" : null,
              ),
              TextFormField(
                controller: nascimentoController,
                decoration: const InputDecoration(labelText: "Data de Nascimento"),
              ),
              TextFormField(
                controller: telefoneController,
                decoration: const InputDecoration(labelText: "Telefone"),
                keyboardType: TextInputType.phone,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "E-mail"),
                keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(
                controller: dataProxController,
                decoration: const InputDecoration(labelText: "Data da Proxima Avaliação"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _irParaProximaTela,
                child: const Text("Próximo"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
