import 'package:sms_app/class/amostragem_class.dart';
import 'package:http/http.dart' as http;
import 'package:sms_app/db/Db.dart';
import '../utils/api_routes.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class AmostragemModel with ChangeNotifier {
  List<AmostragemClass> _items = [];
  final String createTable =
      "CREATE TABLE amostragem (localId TEXT PRIMARY KEY, idAmostragem TEXT, cod_barras TEXT, ensaio TEXT, serie TEXT, tag TEXT, sub_estacao TEXT, tipo TEXT, potencia TEXT, tensao TEXT, temp_amostra TEXT, temp_enrolamento TEXT, temp_equipamento TEXT, temp_ambiente TEXT, umidade_relativa TEXT, observacao TEXT, equipamento_energizado BOOLEAN, nao_conformidade TEXT)";

  List<AmostragemClass> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadAmostragem(pa) async {
    _items.clear();

    final response = await http.get(
      Uri.parse('${ApiRoutes.BASE_URL}/getdataforamostragem?pa=$pa'),
    );

    Map<String, dynamic> data = jsonDecode(response.body);

    await data["data"].forEach((AmostragemData) {
      _items.add(AmostragemClass(
        localId: '1',
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

  // Future<void> saveAmostragem() async {
  //   Db.insert(createTable, "amostragem", {
  //     'localId:'
  //     'idAmostragem:'
  //     'cod_barras:'
  //     'ensaio:'
  //     'serie:'
  //     'tag:'
  //     'sub_estacao:'
  //     'tipo:'
  //     'potencia:'
  //     'tensao:'
  //   });
  // }
}
