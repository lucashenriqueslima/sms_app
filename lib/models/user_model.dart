import '../db/Db.dart';
import '../utils/api_routes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:convert';

class UserModel with ChangeNotifier {
  String? _id;
  String? email;
  String? passwd;
  String? name;
  int? _level;
  int? status;
  bool? remember;
  final String createTable =
      "CREATE TABLE user (id TEXT PRIMARY KEY, email TEXT, passwd TEXT, name TEXT, level INTEGER, status INTEGER, remember BOOLEAN)";

  int? get level {
    return _level;
  }

  String? get id {
    return _id;
  }

  loginUser(String email, String passwd, bool remember) async {
    final response = await http.get(
      Uri.parse('${ApiRoutes.BASE_URL}/login?email=$email&passwd=$passwd'),
    );

    Map<String, dynamic> data = jsonDecode(response.body);

    if (data['status'] != "success") {
      return false;
    }

    _id = data["data"]["cod_usuario"];
    this.email = email;
    this.passwd = passwd;
    name = data["data"]["nome_usuario"] ?? "SEM NOME";
    _level = int.parse(data["data"]["nivel"]);
    status = 1;
    this.remember = remember;

    deleteUser();
    saveUser(data["data"], passwd, remember);

    notifyListeners();
    return true;
  }

  Future<void> logoutUser() async {
    deleteUser();

    _id = null;
    email = null;
    passwd = null;
    name = null;
    _level = null;
    status = 0;
    remember = null;

    notifyListeners();
  }

  redirectUser() async {
    final userData = await Db.getData(createTable, "SELECT * FROM user");

    if (userData.isEmpty) {
      return;
    }

    _id = userData[0]["id"];
    email = userData[0]["email"];
    passwd = userData[0]["passwd"];
    name = userData[0]["name"] ?? "SEM NOME";
    _level = userData[0]["level"];
    status = userData[0]["status"];
    remember = remember;
  }

  Future<void> saveUser(user, passwd, remember) async {
    Db.insert(createTable, "user", {
      'id': user["cod_usuario"],
      'email': user["email"],
      'passwd': passwd,
      'name': user["nome_usuario"],
      'level': user["nivel"],
      'status': 1,
      'remember': remember == true ? 1 : 0
    });
  }

  Future<void> deleteUser() async {
    Db.deleteData(createTable, "DELETE FROM user");
  }

  Future getDataUser() async {}
}
