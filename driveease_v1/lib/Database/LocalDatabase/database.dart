import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final Map<int, List<String>> _migrationScripts = {
    1: [
      '''
      CREATE TABLE corrida (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        datahora_start TEXT(50),
        start_km REAL,
        datahora_stop TEXT(50),
        stop_km REAL,
        ganhos REAL
      );
    ''',
      '''
      CREATE TABLE servico (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tipo TEXT,
        data TEXT,
        km REAL,
        descricao TEXT,
        valor REAL
      );
    ''',
      '''CREATE TABLE start (
        datahora_start TEXT(50),
        start_km REAL
      );
    ''',
      '''CREATE TABLE meta (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        inicio TEXT(50),
        fim TEXT(50),
        valor REAL,
        descricao TEXT
);
''',
    ],
  };

  static Future<Database> initDatabase(String fname) async {
    return await openDatabase(join(await getDatabasesPath(), fname),
        version: _migrationScripts.length, onCreate: (db, version) async {
      for (final script in _migrationScripts.values) {
        for (String sql in script) {
          await db.execute(sql);
        }
      }
    }, onUpgrade: (db, oldVersion, newVersion) async {
      for (int i = oldVersion + 1; i <= newVersion; i++) {
        for (String sql in (_migrationScripts[i] as List<String>)) {
          await db.execute(sql);
        }
      }
    });
  }
}
