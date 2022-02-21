class PlanoAmostragemClass {
  final String idPlanoAmostragem;
  final String? razaoSocial;
  final String? nomeFantasia;
  String? dataPrevista = "Sem Informação";
  String? amostrador = "Sem Informação";

  PlanoAmostragemClass({
    required this.idPlanoAmostragem,
    required this.razaoSocial,
    required this.nomeFantasia,
    this.dataPrevista,
    this.amostrador,
  });
}

class PlanoAmostragemOnClass {
  int idPlanoAmostragem;
  String? subEstacao;
  int equipamentoMissing;

  PlanoAmostragemOnClass({
    required this.idPlanoAmostragem,
    this.subEstacao,
    required this.equipamentoMissing,
  });
}
