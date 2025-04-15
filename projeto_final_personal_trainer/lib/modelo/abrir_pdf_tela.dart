import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AbrirPdfTela extends StatefulWidget {
  const AbrirPdfTela({super.key});

  @override
  _AbrirPdfTelaState createState() => _AbrirPdfTelaState();
}

class _AbrirPdfTelaState extends State<AbrirPdfTela> {
  // Lista para armazenar os nomes dos PDFs
  List<String> _pdfList = [];

  @override
  void initState() {
    super.initState();
    _listarPdfs();
  }

  // Método para localizar e listar todos os arquivos PDF no diretório
  Future<void> _listarPdfs() async {
    final dir = await getApplicationDocumentsDirectory();
    final directory = Directory(dir.path);

    // Lista todos os arquivos no diretório
    final List<FileSystemEntity> files = directory.listSync();

    // Filtra apenas os arquivos com extensão '.pdf'
    final pdfFiles = files.where((file) => file.path.endsWith('.pdf')).toList();

    setState(() {
      _pdfList = pdfFiles.map((file) => file.uri.pathSegments.last).toList();
    });
  }

  // Método para abrir o PDF selecionado
  void _abrirPdf(String pdfName) async {
    final dir = await getApplicationDocumentsDirectory();
    final pdfPath = '${dir.path}/$pdfName';

    if (File(pdfPath).existsSync()) {
      await OpenFilex.open(pdfPath);  // Abre o arquivo PDF
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Arquivo PDF não encontrado!")),
      );
    }
  }

  // Método para deletar o PDF
  void _deletarPdf(String pdfName) async {
    final dir = await getApplicationDocumentsDirectory();
    final pdfPath = '${dir.path}/$pdfName';
    final file = File(pdfPath);

    // Exibe um alerta de confirmação para deletar o arquivo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar Exclusão"),
          content: Text("Tem certeza de que deseja excluir o arquivo '$pdfName'?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();  // Fecha o alerta sem excluir
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                // Deleta o arquivo se existir
                if (await file.exists()) {
                  await file.delete();
                  setState(() {
                    _pdfList.remove(pdfName);  // Remove da lista
                  });
                  Navigator.of(context).pop();  // Fecha o alerta
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Arquivo excluído com sucesso!")),
                  );
                }
              },
              child: const Text("Excluir"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Abrir PDF"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Se não houver PDFs, exibe uma mensagem
            if (_pdfList.isEmpty)
              const Center(child: Text("Nenhum PDF encontrado.")),

            // Lista de PDFs disponíveis
            if (_pdfList.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _pdfList.length,
                  itemBuilder: (context, index) {
                    final pdfName = _pdfList[index];
                    return ListTile(
                      title: Text(pdfName),
                      onTap: () => _abrirPdf(pdfName), // Ao clicar, abre o PDF
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deletarPdf(pdfName), // Ao clicar, deleta o PDF
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
