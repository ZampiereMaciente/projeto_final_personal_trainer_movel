class Aluno {
  // Informações básicas
  final String nome;
  final String nascimento;
  final String telefone;
  final String email;

  // Avaliação futura
  final String dataProximaAvaliacao;
  final String horarioProximaAvaliacao;

  // Dobras cutâneas (opcional)
  String? triceps;
  String? subescapular;
  String? suprailica;
  String? abdomenDobras;

  // Circunferências (opcional)
  String? bracoDir;
  String? bracoEsq;
  String? antebracoDir;
  String? antebracoEsq;
  String? abdomenCirc;
  String? quadril;
  String? cintura;
  String? coxaDir;
  String? coxaEsq;
  String? pernaDir;
  String? pernaEsq;

  // Construtor
  Aluno({
    required this.nome,
    required this.nascimento,
    required this.telefone,
    required this.email,
    required this.dataProximaAvaliacao,
    required this.horarioProximaAvaliacao,
    this.triceps,
    this.subescapular,
    this.suprailica,
    this.abdomenDobras,
    this.bracoDir,
    this.bracoEsq,
    this.antebracoDir,
    this.antebracoEsq,
    this.abdomenCirc,
    this.quadril,
    this.cintura,
    this.coxaDir,
    this.coxaEsq,
    this.pernaDir,
    this.pernaEsq,
  });

  // Métodos utilitários (ex: converter para Map)
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'nascimento': nascimento,
      'telefone': telefone,
      'email': email,
      'dataProximaAvaliacao': dataProximaAvaliacao,
      'horarioProximaAvaliacao': horarioProximaAvaliacao,
      'triceps': triceps,
      'subescapular': subescapular,
      'suprailica': suprailica,
      'abdomenDobras': abdomenDobras,
      'bracoDir': bracoDir,
      'bracoEsq': bracoEsq,
      'antebracoDir': antebracoDir,
      'antebracoEsq': antebracoEsq,
      'abdomenCirc': abdomenCirc,
      'quadril': quadril,
      'cintura': cintura,
      'coxaDir': coxaDir,
      'coxaEsq': coxaEsq,
      'pernaDir': pernaDir,
      'pernaEsq': pernaEsq,
    };
  }
}
