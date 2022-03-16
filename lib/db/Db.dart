import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  DB._();

  static late Database db;

  static final DB instance = DB._();

  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  static Future<List<Map<String, dynamic>>> select(String query) async {
    db = await await DB.instance.database;
    try {
      return db.rawQuery(query);
    } catch (_) {
      return [];
    }
  }

  static Future<void> insert(table, data) async {
    db = await DB.instance.database;

    await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(sql) async {
    db = await DB.instance.database;
    db.rawUpdate(sql);
  }

  static Future<void> delete(sql) async {
    db = await DB.instance.database;
    db.rawDelete(sql);
  }

  _initDatabase() async {
    return await openDatabase(
        join(
          await getDatabasesPath(),
          "samplemanagersystem8.db",
        ),
        version: 1,
        onCreate: _onCreate);
  }

  Future<void> _onCreate(db, version) async {
    await db.execute(_user);
    await db.execute(_amostragemBefore);
    await db.execute(_amostragemLater);
    await db.execute(_planoAmostragemOn);
  }

  String get _user => '''
CREATE TABLE user (
    id TEXT PRIMARY KEY, 
    email TEXT, passwd TEXT, 
    name TEXT, level INTEGER, 
    status INTEGER, 
    remember BOOLEAN)
    ''';

  String get _planoAmostragemOn => '''
CREATE TABLE planoAmostragemOn (
    idPlanoAmostragem INTEGER PRIMARY KEY, 
    subEstacao TEXT, 
    equipamentoMissing INTEGER)
    ''';

  String get _amostragemBefore => '''
CREATE TABLE amostragemBefore (
    localIdAmostragem INTEGER PRIMARY KEY, 
    idPlanoAmostragem INTEGER, 
    idEquipamento TEXT,
    cod_barras TEXT, 
    ensaio TEXT, 
    serie TEXT, 
    tag TEXT, 
    sub_estacao TEXT, 
    tipo TEXT, 
    potencia TEXT,
    tensao TEXT)
''';

  String get _amostragemLater => '''
CREATE TABLE amostragemLater(    
    localIdAmostragem INTEGER PRIMARY KEY, 
    statusAmostragemItem INTEGER,
    temp_amostra TEXT, 
    temp_enrolamento TEXT, 
    temp_equipamento TEXT, 
    temp_ambiente TEXT, 
    umidade_relativa TEXT, 
    observacao TEXT, 
    equipamento_energizado BOOLEAN, 
    nao_conformidade TEXT,
    image TEXT)
''';
}
