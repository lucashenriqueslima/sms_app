import 'dart:io';

import 'package:sms_app/class/amostragem_class.dart';
import 'package:http/http.dart' as http;
import 'package:sms_app/db/db.dart';
import '../utils/api_routes.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class AmostragemModel with ChangeNotifier {
  List<AmostragemClass> items = [];

  AmostragemClass itemByIndex(int index) {
    return items[index];
  }

  int get itemsCount {
    return items.length;
  }

  List<AmostragemClass> itemsByPlanoAmostragem(paId) {
    List<AmostragemClass> itemsByEquipamento = [];
    List<AmostragemClass> itemsByPlanoAmostragem =
        items.where((element) => element.idPlanoAmostragem == paId).toList();

    if (itemsByPlanoAmostragem.length == 1) {
      return itemsByPlanoAmostragem;
    }

    for (int i = 0; i < itemsByPlanoAmostragem.length - 1; i++) {
      if (itemsByPlanoAmostragem[i].idEquipamento !=
          itemsByPlanoAmostragem[i + 1].idEquipamento) {
        itemsByEquipamento.add(itemsByPlanoAmostragem[i]);
      }
    }

    itemsByEquipamento
        .add(itemsByPlanoAmostragem[itemsByPlanoAmostragem.length - 1]);

    return itemsByEquipamento;
  }

  List<AmostragemClass> itemsByEquipamento(idEquipamento, paId) {
    return items
        .where((element) =>
            element.idEquipamento == idEquipamento &&
            element.idPlanoAmostragem == paId)
        .toList();
  }

  Future<void> loadAmostragem(pa) async {
    items.clear();
    deleteAmostragem();
    DB.update("UPDATE user SET status = 2");

    int localId = 0;

    final response = await http.get(
      Uri.parse('${ApiRoutes.BASE_URL}/getdataforamostragem?pa=$pa'),
    );

    Map<String, dynamic> data = jsonDecode(response.body);

    await data["data"].forEach((AmostragemData) {
      saveAmsotragem(localId, AmostragemData);

      items.add(
        AmostragemClass(
            localIdAmostragem: localId,
            idPlanoAmostragem:
                int.parse(AmostragemData["cod_plano_amostragem"]),
            idEquipamento: AmostragemData["NUM_EQUIP"],
            cod_barras: AmostragemData["cod_barras"],
            ensaio: AmostragemData["ensaio"],
            serie: AmostragemData["SERIE"] ?? "SEM INFORMAÇÃO",
            tag: AmostragemData["DESIGNACAO"] ?? "SEM INFORMAÇÃO",
            sub_estacao: AmostragemData["SUBESTACAO"] ?? "SEM INFORMAÇÃO",
            tipo: AmostragemData["DESC_EQUIP"] ?? "SEM INFORMAÇÃO",
            potencia: AmostragemData["POTENCIA"] ?? "SEM INFORMAÇÃO",
            tensao: AmostragemData["TENSAO"] ?? "SEM INFORMAÇÃO",
            statusAmostragemItem: 1,
            temp_amostra: '',
            temp_enrolamento: '',
            temp_equipamento: '',
            temp_ambiente: '',
            umidade_relativa: '',
            observacao: '',
            equipamento_energizado: false,
            image: File(''),
            latitude: '',
            longitude: ''),
      );

      localId++;
    });

    notifyListeners();
  }

  Future<void> reloadAmostragem() async {
    items.clear();

    final localDataAmostragemBefore =
        await DB.select("SELECT * FROM amostragemBefore");

    final localDataAmostragemLater =
        await DB.select("SELECT * FROM amostragemLater");

    for (int i = 0; i <= localDataAmostragemBefore.length - 1; i++) {
      items.add(
        AmostragemClass(
            localIdAmostragem: i,
            idPlanoAmostragem: localDataAmostragemBefore[i]
                ["idPlanoAmostragem"],
            idEquipamento: localDataAmostragemBefore[i]["idEquipamento"],
            cod_barras: localDataAmostragemBefore[i]["cod_barras"],
            ensaio: localDataAmostragemBefore[i]["ensaio"],
            serie: localDataAmostragemBefore[i]["serie"],
            tag: localDataAmostragemBefore[i]["tag"],
            sub_estacao: localDataAmostragemBefore[i]["sub_estacao"],
            tipo: localDataAmostragemBefore[i]["tipo"],
            potencia: localDataAmostragemBefore[i]["potencia"],
            tensao: localDataAmostragemBefore[i]["tensao"],
            statusAmostragemItem: localDataAmostragemLater[i]
                ["statusAmostragemItem"],
            temp_amostra: localDataAmostragemLater[i]["temp_amostra"],
            temp_enrolamento: localDataAmostragemLater[i]["temp_enrolamento"],
            temp_equipamento: localDataAmostragemLater[i]["temp_equipamento"],
            temp_ambiente: localDataAmostragemLater[i]["temp_ambiente"],
            umidade_relativa: localDataAmostragemLater[i]["umidade_relativa"],
            observacao: localDataAmostragemLater[i]["observacao"],
            equipamento_energizado:
                localDataAmostragemLater[i]["equipamento_energizado"] != 1
                    ? false
                    : true,
            image: File(localDataAmostragemLater[i]["image"]),
            latitude: localDataAmostragemLater[i]["latitude"],
            longitude: localDataAmostragemLater[i]["longitude"]),
      );
    }

    notifyListeners();
  }

  Future<void> saveAmsotragem(localIdAmostragem, AmostragemData) async {
    DB.insert("amostragemBefore", {
      'localIdAmostragem': localIdAmostragem,
      'idPlanoAmostragem': int.parse(AmostragemData["cod_plano_amostragem"]),
      'idEquipamento': AmostragemData["NUM_EQUIP"],
      'cod_barras': AmostragemData["cod_barras"],
      'ensaio': AmostragemData["ensaio"],
      'serie': AmostragemData["SERIE"] ?? "SEM INFORMAÇÃO",
      'tag': AmostragemData["DESIGNACAO"] ?? "SEM INFORMAÇÃO",
      'sub_estacao': AmostragemData["SUBESTACAO"] ?? "SEM INFORMAÇÃO",
      'tipo': AmostragemData["DESC_EQUIP"] ?? "SEM INFORMAÇÃO",
      'potencia': AmostragemData["POTENCIA"] ?? "SEM INFORMAÇÃO",
      'tensao': AmostragemData["TENSAO"] ?? "SEM INFORMAÇÃO",
    });

    DB.insert("amostragemLater", {
      'localIdAmostragem': localIdAmostragem,
      'statusAmostragemItem': 1,
      'temp_amostra': '',
      'temp_enrolamento': '',
      'temp_equipamento': '',
      'temp_ambiente': '',
      'umidade_relativa': '',
      'observacao': '',
      'equipamento_energizado': 0,
      'nao_conformidade': '',
      'image': '',
      'latitude': '',
      'longitude': ''
    });
  }

  Future<void> updateAmostragemById(statusAmostragemItem, localIdAmostragem,
      {List? location}) async {
    items[localIdAmostragem].statusAmostragemItem = statusAmostragemItem;

    if (statusAmostragemItem == 1) {
      items[localIdAmostragem].temp_amostra = '';
      items[localIdAmostragem].temp_enrolamento = '';
      items[localIdAmostragem].temp_ambiente = '';
      items[localIdAmostragem].temp_equipamento = '';
      items[localIdAmostragem].umidade_relativa = '';
      items[localIdAmostragem].observacao = '';
      items[localIdAmostragem].equipamento_energizado = false;
      items[localIdAmostragem].image = File('');
      items[localIdAmostragem].latitude = '';
      items[localIdAmostragem].longitude = '';
    }

    notifyListeners();

    if (statusAmostragemItem == 2) {
      DB.update('''UPDATE amostragemLater
        SET statusAmostragemItem = $statusAmostragemItem,
        temp_amostra = '${itemByIndex(localIdAmostragem).temp_amostra}',
        temp_enrolamento = '${itemByIndex(localIdAmostragem).temp_enrolamento}',
        temp_equipamento = '${itemByIndex(localIdAmostragem).temp_equipamento}',
        temp_ambiente = '${itemByIndex(localIdAmostragem).temp_ambiente}',
        umidade_relativa = '${itemByIndex(localIdAmostragem).umidade_relativa}',
        observacao =  '${itemByIndex(localIdAmostragem).observacao}',
        equipamento_energizado = ${itemByIndex(localIdAmostragem).equipamento_energizado != true ? 0 : 1},
        image = '${itemByIndex(localIdAmostragem).image != null ? itemByIndex(localIdAmostragem).image!.path : ''}',
        latitude = '${location?[0] ?? ''}',
        longitude = '${location?[1] ?? ''}'
        WHERE localIdAmostragem = $localIdAmostragem''');

      return;
    }

    DB.update('''UPDATE amostragemLater 
        SET statusAmostragemItem = $statusAmostragemItem, 
        temp_amostra = '', 
        temp_enrolamento = '', 
        temp_equipamento = '', 
        temp_ambiente = '', 
        umidade_relativa = '', 
        observacao =  '', 
        equipamento_energizado = 0,
        image = '',
        latitude = '',
        longitude = ''
        WHERE localIdAmostragem = $localIdAmostragem''');
  }

  void finishAmostragem(bool isOn) async {
    if (!isOn) {
      DB.update("UPDATE user SET status = 3");

      DB.insert("message", {
        "id_message": null,
        "module": "planoAmostragem",
        "type": "warning",
        "message":
            "Dados referente ao último Plano de Amostragem não foram enviados.",
        "sub_mensage": "Quando estiver conectado, clique para envia-los."
      });
    }

    final dataToSend = await DB.select(
        "SELECT al.*, ab.cod_barras, ab.idPlanoAmostragem FROM amostragemLater al INNER JOIN amostragemBefore ab ON al.localIdAmostragem = ab.localIdAmostragem");

    http.post(
      Uri.parse('${ApiRoutes.BASE_URL}/saveamostragembyplano'),
      body: jsonEncode(dataToSend),
    );

    await deleteAmostragem();

    DB.update("UPDATE user SET status = 1");
  }

  Future<void> deleteAmostragem() async {
    DB.delete("DELETE FROM amostragemBefore");
    DB.delete("DELETE FROM amostragemLater");
  }
}
