import 'package:sms_app/class/amostragem_class.dart';
import 'package:http/http.dart' as http;
import 'package:sms_app/db/db.dart';
import '../utils/api_routes.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class AmostragemModel with ChangeNotifier {
  List<AmostragemClass> _items = [];

  List<AmostragemClass> get items => [..._items];

  AmostragemClass itemByIndex(int index) {
    return _items[index];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadAmostragem(pa) async {
    _items.clear();
    deleteAmostragem();
    DB.update("UPDATE user SET status = 2");

    int localId = 0;

    final response = await http.get(
      Uri.parse('${ApiRoutes.BASE_URL}/getdataforamostragem?pa=$pa'),
    );

    Map<String, dynamic> data = jsonDecode(response.body);

    await data["data"].forEach((AmostragemData) {
      saveAmsotragem(localId, pa, AmostragemData);

      _items.add(AmostragemClass(
        localIdAmostragem: localId,
        idAmostragem: pa,
        cod_barras: AmostragemData["cod_barras"],
        ensaio: AmostragemData["ensaio"],
        serie: AmostragemData["SERIE"] ?? "Sem Informação",
        tag: AmostragemData["DESIGNACAO"] ?? "Sem Informação",
        sub_estacao: AmostragemData["SUBESTACAO"] ?? "Sem Informação",
        tipo: AmostragemData["DESC_EQUIP"] ?? "Sem Informação",
        potencia: AmostragemData["POTENCIA"] ?? "Sem Informação",
        tensao: AmostragemData["TENSAO"] ?? "Sem Informação",
      ));

      localId++;
    });

    notifyListeners();
  }

  Future<void> reloadAmsotragem() async {
    _items.clear();

    final localDataAmostragemBefore =
        await DB.select("SELECT * FROM amostragemBefore");

    final localDataAmostragemLater =
        await DB.select("SELECT * FROM amostragemLater");

    for (int i = 0; i <= localDataAmostragemBefore.length - 1; i++) {
      print(localDataAmostragemBefore);

      _items.add(AmostragemClass(
        localIdAmostragem: i,
        idAmostragem: localDataAmostragemBefore[i]["idAmostragem"],
        cod_barras: localDataAmostragemBefore[i]["cod_barras"],
        ensaio: localDataAmostragemBefore[i]["ensaio"],
        serie: localDataAmostragemBefore[i]["serie"],
        tag: localDataAmostragemBefore[i]["tag"],
        sub_estacao: localDataAmostragemBefore[i]["sub_estacao"],
        tipo: localDataAmostragemBefore[i]["tipo"],
        potencia: localDataAmostragemBefore[i]["potencia"],
        tensao: localDataAmostragemBefore[i]["tensao"],
        temp_amostra: localDataAmostragemLater[i]["temp_amostra"],
        temp_enrolamento: localDataAmostragemLater[i]["temp_enrolamento"],
        temp_equipamento: localDataAmostragemLater[i]["temp_equipamento"],
        temp_ambiente: localDataAmostragemLater[i]["temp_ambiente"],
        umidade_relativa: localDataAmostragemLater[i]["umidade_relativa"],
        observacao: localDataAmostragemLater[i]["observacao"],
        equipamento_energizado: localDataAmostragemLater[i]
            ["equipamento_energizado"],
        nao_conformidade: localDataAmostragemLater[i]["nao_conformidade"],
      ));
    }

    notifyListeners();
  }

  Future<void> saveAmsotragem(localIdAmostragem, pa, AmostragemData) async {
    DB.insert("amostragemBefore", {
      'localIdAmostragem': localIdAmostragem,
      'idAmostragem': pa,
      'cod_barras': AmostragemData["cod_barras"],
      'ensaio': AmostragemData["ensaio"],
      'serie': AmostragemData["SERIE"],
      'tag': AmostragemData["DESIGNACAO"],
      'sub_estacao': AmostragemData["SUBESTACAO"],
      'tipo': AmostragemData["DESC_EQUIP"],
      'potencia': AmostragemData["POTENCIA"],
      'tensao': AmostragemData["TENSAO"],
    });

    DB.insert("amostragemLater", {
      'localIdAmostragem': localIdAmostragem,
      'temp_amostra': AmostragemData["temp_amostra"],
      'temp_enrolamento': AmostragemData["temp_enrolamento"],
      'temp_equipamento': AmostragemData["temp_equipamento"],
      'temp_ambiente': AmostragemData["temp_ambiente"],
      'umidade_relativa': AmostragemData["umidade_relativa"],
      'observacao': AmostragemData["observacao"],
      'equipamento_energizado': AmostragemData["equipamento_energizado"],
      'nao_conformidade': AmostragemData["nao_conformidade"],
    });
  }

  Future<void> finishAmostragem() async {
    await deleteAmostragem();

    DB.update("UPDATE user SET status = 1");
  }

  Future<void> deleteAmostragem() async {
    DB.delete("DELETE FROM amostragemBefore");
    DB.delete("DELETE FROM amostragemLater");
  }
}
