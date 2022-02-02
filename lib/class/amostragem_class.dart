class AmostragemClass {
  final String localId;
  final String idAmostragem;
  final String ensaio;
  final String? temp_amostra;
  final String? temp_enrolamento;
  final String? temp_equipamento;
  final String? temp_ambiente;
  final String? umidade_relativa;
  final String? observacao;
  final bool? equipamento_energizado;
  final bool? nao_conformidade;
  final String? n_serie;
  final String? tag;
  final String? sub_estacao;
  final String? tipo;
  final String? potencia;
  final String? tensao;

  AmostragemClass(
      {required this.localId,
      required this.idAmostragem,
      required this.ensaio,
      this.temp_amostra,
      this.temp_enrolamento,
      this.temp_equipamento,
      this.temp_ambiente,
      this.umidade_relativa,
      this.observacao,
      this.equipamento_energizado,
      this.nao_conformidade,
      this.n_serie,
      this.tag,
      this.sub_estacao,
      this.tipo,
      this.potencia,
      this.tensao});
}
