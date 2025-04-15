class Aluno {
  String nome;
  String nascimento;
  String telefone;
  String email;
  String dataProximaAvaliacao;

  // Novos campos (tornados anuláveis)
  String? triceps;
  String? subescapular;
  String? suprailica;
  String? abdomenDobras;

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

  Aluno({
    required this.nome,
    required this.nascimento,
    required this.telefone,
    required this.email,
    required this.dataProximaAvaliacao,
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
}
