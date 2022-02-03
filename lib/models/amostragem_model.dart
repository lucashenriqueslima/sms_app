import 'package:sms_app/class/amostragem_class.dart';
import 'package:http/http.dart' as http;
import 'package:sms_app/db/Db.dart';
import '../utils/api_routes.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class AmostragemModel with ChangeNotifier {
  final String? _idUser;
  final int? _levelUser;
  List<AmostragemClass> _items = [];

  List<AmostragemClass> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  AmostragemModel([this._levelUser, this._idUser, this._items = const []]);

  Future<void> loadAmostragem(pa) async {
    _items.clear();

    final response = await http.get(
      Uri.parse('${ApiRoutes.BASE_URL}/getamostragemdataforamostragem?pa=$pa'),
    );

    Map<String, dynamic> data = jsonDecode(response.body);

    data["data"].forEach((LocalId, AmostragemData) {
      _items.add(AmostragemClass(
        localId: LocalId,
        idAmostragem: pa,
        cod_barras: AmostragemData["cod_barras"],
        ensaio: AmostragemData["ensaio"],
        serie: AmostragemData["SERIE"],
        tag: AmostragemData["DESIGNACAO"],
        sub_estacao: AmostragemData["SUBESTACAO"],
        tipo: AmostragemData["DESC_EQUIP"],
        potencia: AmostragemData["POTENCIA"],
        tensao: AmostragemData["TENSAO"],
      ));
    });

    notifyListeners();
  }
}
