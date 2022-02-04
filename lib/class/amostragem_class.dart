class AmostragemClass {
  final String? localIdAmostragem;
  final String? idAmostragem;
  final String? cod_barras;
  final String? ensaio;
  final String? serie;
  final String? tag;
  final String? sub_estacao;
  final String? tipo;
  final String? potencia;
  final String? tensao;
  String? temp_amostra = "Sem Informação";
  String? temp_enrolamento = "Sem Informação";
  String? temp_equipamento = "Sem Informação";
  String? temp_ambiente = "Sem Informação";
  String? umidade_relativa = "Sem Informação";
  String? observacao = "Sem Informação";
  bool? equipamento_energizado = false;
  bool? nao_conformidade = false;

  AmostragemClass({
    this.localIdAmostragem,
    this.idAmostragem,
    this.cod_barras,
    this.ensaio,
    this.serie,
    this.tag,
    this.sub_estacao,
    this.tipo,
    this.potencia,
    this.tensao,
    this.temp_amostra,
    this.temp_enrolamento,
    this.temp_equipamento,
    this.temp_ambiente,
    this.umidade_relativa,
    this.observacao,
    this.equipamento_energizado,
    this.nao_conformidade,
  });
}
