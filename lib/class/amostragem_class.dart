import 'dart:io';

class AmostragemClass {
  final int? localIdAmostragem;
  final int? idPlanoAmostragem;
  final String? idEquipamento;
  final String cod_barras;
  final String? ensaio;
  final String? serie;
  final String? tag;
  final String? sub_estacao;
  final String? tipo;
  final String? potencia;
  final String? tensao;
  int? statusAmostragemItem;
  String? temp_amostra;
  String? temp_enrolamento;
  String? temp_equipamento;
  String? temp_ambiente;
  String? umidade_relativa;
  String? observacao;
  bool? equipamento_energizado = false;
  File? image;
  String? latitude;
  String? longitude;

  AmostragemClass(
      {required this.localIdAmostragem,
      required this.idPlanoAmostragem,
      required this.idEquipamento,
      required this.cod_barras,
      this.ensaio,
      this.serie,
      this.tag,
      this.sub_estacao,
      this.tipo,
      this.potencia,
      this.tensao,
      required this.statusAmostragemItem,
      this.temp_amostra,
      this.temp_enrolamento,
      this.temp_equipamento,
      this.temp_ambiente,
      this.umidade_relativa,
      this.observacao,
      this.equipamento_energizado,
      this.image,
      this.latitude,
      this.longitude});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idPlanoAmostragem'] = idPlanoAmostragem;
    data['cod_barras'] = cod_barras;
    data['statusAmostragem'] = statusAmostragemItem;
    data['temp_amostra'] = temp_amostra;
    data['temp_enrolamento'] = temp_enrolamento;
    data['temp_equipamento'] = temp_equipamento;
    data['temp_ambiente'] = temp_ambiente;
    data['umidade_relativa'] = umidade_relativa;
    data['observacao'] = observacao;
    data['image'] = image;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
