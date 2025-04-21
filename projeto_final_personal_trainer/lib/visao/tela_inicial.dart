import 'package:flutter/material.dart';
import 'package:projeto_final_personal_trainer/controle/fechar_app_controle.dart';
import 'package:projeto_final_personal_trainer/visao/nova_avaliacao.dart';
import '../servicos/abrir_pdf_tela.dart';
import 'package:projeto_final_personal_trainer/visao/rainbow_text.dart';


class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagem de fundo
          SizedBox.expand(
            child: Image.asset(
              'assets/images/academia9.png',
              fit: BoxFit.cover,
            ),
          ),

          // Conteúdo sobre a imagem
          Container(
            color: Colors.black.withOpacity(0.3), // escurece a imagem de fundo
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const RainbowText(text: 'Bem-vindo!'),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NovaAvaliacao()),
                        );
                      },
                      icon: const Icon(Icons.assignment),
                      label: const Text('Iniciar Nova Avaliação'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AbrirPdfTela()),
                        );
                      },
                      icon: const Icon(Icons.folder_open),
                      label: const Text('Abrir Avaliação (PDF)'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        FecharApp.fecharApp(context);
                      },
                      icon: const Icon(Icons.exit_to_app),
                      label: const Text('Fechar Aplicativo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
