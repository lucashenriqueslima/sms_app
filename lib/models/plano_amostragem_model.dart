import 'package:sms_app/class/plano_amostragem_class.dart';
import 'package:http/http.dart' as http;
import '../utils/api_routes.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class PlanoAmostragemModel with ChangeNotifier {
  final String? _idUser;
  final int? _levelUser;
  List<PlanoAmostragemClass> _items = [];

  List<PlanoAmostragemClass> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  PlanoAmostragemModel([this._levelUser, this._idUser, this._items = const []]);

  Future<void> loadPlanoAmostragem() async {
    _items.clear();

    final response = await http.get(
      Uri.parse(
          '${ApiRoutes.BASE_URL}/getplanoamostragem?level=$_levelUser&id=$_idUser'),
    );

    Map<String, dynamic> data = jsonDecode(response.body);

    data["data"].forEach((planoAmostragemData) {
      _items.add(
        PlanoAmostragemClass(
            idPlanoAmostragem: planoAmostragemData["id_plano_amostragem"],
            razaoSocial:
                planoAmostragemData['RAZAO_SOCIAL'] ?? "Sem Informação",
            nomeFantasia:
                planoAmostragemData['NOME_FANTASIA'] ?? "Sem Informação",
            dataPrevista:
                planoAmostragemData['data_prevista_inicio'] ?? "Sem Informação",
            amostrador: planoAmostragemData['amostrador'] ?? "Sem Informação"),
      );
    });
    notifyListeners();
  }
}
