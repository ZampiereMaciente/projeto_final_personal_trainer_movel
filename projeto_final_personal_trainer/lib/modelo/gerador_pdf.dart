import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

class GeradorPdf {
  static Future<void> gerarPdf({
    required Map<String, String> dadosPessoais,
    required Map<String, String> dobrasCutaneas,
    required Map<String, String> circunferencias,
    required Map<String, String> dadosImcTmb, // <- Novo parâmetro
    required String nomeAluno,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text('Avaliação Física', style: pw.TextStyle(fontSize: 24)),
          ),

          // Seção: Dados Pessoais
          pw.Text('Dados Pessoais', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          _criarTabela(dadosPessoais),
          pw.SizedBox(height: 20),

          // Seção: Dobras Cutâneas
          pw.Text('Dobras Cutâneas (mm)', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          _criarTabela(dobrasCutaneas),
          pw.SizedBox(height: 20),

          // Seção: Circunferências
          pw.Text('Circunferências (cm)', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          _criarTabela(circunferencias),
          pw.SizedBox(height: 20),

          // Nova Seção: IMC e TMB
          pw.Text('Cálculo de IMC e TMB', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          _criarTabela(dadosImcTmb),
        ],
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final fileName = '${nomeAluno}.pdf';
    final file = File('${dir.path}/$fileName');

    await file.writeAsBytes(await pdf.save());
    await OpenFilex.open(file.path);
  }

  static pw.Widget _criarTabela(Map<String, String> dados) {
    return pw.Table.fromTextArray(
      border: pw.TableBorder.all(),
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
      headers: ['Campo', 'Valor'],
      data: dados.entries.map((entry) => [entry.key, entry.value]).toList(),
    );
  }
}
