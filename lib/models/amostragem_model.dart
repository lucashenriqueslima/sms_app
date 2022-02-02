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
      Uri.parse('${ApiRoutes.BASE_URL}/getamostragemdata?pa=$pa'),
    );

    Map<String, dynamic> data = jsonDecode(response.body);

    notifyListeners();
  }
}
