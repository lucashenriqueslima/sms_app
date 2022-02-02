import 'package:sms_app/class/plano_amostragem_class.dart';
import 'package:sms_app/routes/api_routes.dart';
import 'package:http/http.dart' as http;
import '../routes/api_routes.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class PlanoAmostragemModel with ChangeNotifier {
  final String _idUser;
  final int _levelUser;
  List<PlanoAmostragemClass> _items = [];

  List<PlanoAmostragemClass> get items => [..._items];

  PlanoAmostragemModel(
      [this._levelUser = 0, this._idUser = '-2', this._items = const []]);

  Future<void> loadProducts() async {
    _items.clear();

    final response = await http.get(
      Uri.parse(
          '${ApiRoutes.BASE_URL}/getplanoamostragem?level=$_levelUser&id=$_idUser'),
    );
    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);

    if (data["data"] == 'null') return;

    data["data"].forEach((planoAmostragemData) {
      _items.add(
        PlanoAmostragemClass(
            idPlanoAmostragem: planoAmostragemData["id_plano_amostragem"],
            razaoSocial: planoAmostragemData['RAZAO_SOCIAL'],
            nomeFantasia: planoAmostragemData['description'],
            dataPrevista: planoAmostragemData['data_prevista_inicio'],
            amostrador: planoAmostragemData['amostrador']),
      );
    });
    notifyListeners();
  }
}
