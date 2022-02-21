import 'package:sms_app/class/plano_amostragem_class.dart';
import 'package:http/http.dart' as http;
import 'package:sms_app/db/Db.dart';
import '../utils/api_routes.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class PlanoAmostragemOnModel with ChangeNotifier {
  List<PlanoAmostragemOnClass> items = [];

  int get itemsCount {
    return items.length;
  }

  Future<void> loadPlanoAmostragemOn(pa) async {
    items.clear();
    deletePlanoAmostragemOn();

    DB.update("UPDATE user SET status = 2");

    final response = await http.get(
      Uri.parse('${ApiRoutes.BASE_URL}/getplanoamostragemforamostragem?pa=$pa'),
    );

    Map<String, dynamic> data = jsonDecode(response.body);

    data["data"].forEach((planoAmostragemData) {
      savePlanoAmsotragemOn(planoAmostragemData);
      items.add(
        PlanoAmostragemOnClass(
          idPlanoAmostragem:
              int.parse(planoAmostragemData["cod_plano_amostragem"]),
          subEstacao: planoAmostragemData['SUBESTACAO'] ?? "Sem Informação",
          equipamentoMissing:
              int.parse(planoAmostragemData['equipamentoMissing']),
        ),
      );
    });

    notifyListeners();
  }

  Future<void> savePlanoAmsotragemOn(planoAmostragemData) async {
    DB.insert("planoAmostragemOn", {
      'idPlanoAmostragem':
          int.parse(planoAmostragemData["cod_plano_amostragem"]),
      'subEstacao': planoAmostragemData["SUBESTACAO"],
      'equipamentoMissing':
          int.parse(planoAmostragemData["equipamentoMissing"]),
    });
  }

  Future<void> reloadPlanoAmostragemOn() async {
    items.clear();

    // DB.update("UPDATE user SET status = 1");

    final localDataPlanoAmostragem =
        await DB.select("SELECT * FROM planoAmostragemOn");

    localDataPlanoAmostragem.forEach((planoOnData) {
      items.add(PlanoAmostragemOnClass(
        idPlanoAmostragem: planoOnData["idPlanoAmostragem"],
        subEstacao: planoOnData["subEstacao"],
        equipamentoMissing: planoOnData["equipamentoMissing"],
      ));
    });

    notifyListeners();
  }

  Future<void> deletePlanoAmostragemOn() async {
    DB.delete("DELETE FROM planoAmostragemOn");
  }
}
