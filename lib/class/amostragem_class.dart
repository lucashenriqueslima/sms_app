class AmostragemClass {
  final int localIdAmostragem;
  final String? idAmostragem;
  final String? cod_barras;
  final String? ensaio;
  final String? serie;
  final String? tag;
  final String? sub_estacao;
  final String? tipo;
  final String? potencia;
  final String? tensao;
  String? temp_amostra;
  String? temp_enrolamento;
  String? temp_equipamento;
  String? temp_ambiente;
  String? umidade_relativa;
  String? observacao;
  bool? equipamento_energizado = false;
  bool? nao_conformidade = false;

  AmostragemClass({
    required this.localIdAmostragem,
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
