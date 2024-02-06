import 'package:driveease_v1/Database/day.dart';
import 'package:driveease_v1/Database/service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BancoDeDados {
  Database? _database;

  Future<void> initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'driveease_v1.db'),
      onCreate: (db, version) {
        _createDayTable(db);
        _createServiceTable(db);
        _createDayCarro(db);
      },
      version: 1,
    );
  }

  Future<void> _createDayCarro(Database db) async {
    await db.execute(''' CREATE TABLE IF NOT EXISTS carro (
        id_carro INTAUTOINCREMENT,
        descricao TEXT(100),
        PRIMARY KEY(id_carro)
      )
    ''');
  }

  Future<void> _createDayTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS diario (
        id INT AUTOINCREMENT,
        id_carro INT,
        datahora_start TEXT(50),
        start_km REAL,
        datahora_stop TEXT(50),
        stop_km REAL,
        ganhos REAL,
        PRIMARY KEY(id),
        FOREIGN KEY(id_carro) REFERENCES carro(id_carro)
      )
    ''');
  }

  Future<void> _createServiceTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS servicos (
        id INT AUTOINCREMENT,
        id_carro INT,
        data TEXT,
        km REAL,
        servico TEXT,
        valor REAL,
        PRIMARY KEY(id),
        FOREIGN KEY(id_carro) REFERENCES carro(id_carro)
      )
    ''');
  }

  Future<void> insertDay(Day day) async {
    await _database!.insert(
      'diario',
      day.toMap(),
    );
  }

  Future<void> insertService(Service service) async {
    await _database!.insert(
      'servicos',
      service.toMap(),
    );
  }

  Future<List<Day>> getDays() async {
    final List<Map<String, dynamic>> maps = await _database!.query('diario');
    return List.generate(
      maps.length,
      (i) {
        return Day(
          id: maps[i]['id'],
          idCarro: maps[i]['id_carro'],
          dataHoraStart: maps[i]['datahora_start'],
          startKm: maps[i]['start_km'],
          dataHoraStop: maps[i]['datahora_stop'],
          stopKm: maps[i]['stop_km'],
          ganhos: maps[i]['ganhos'],
        );
      },
    );
  }

  Future<List<Service>> getServices() async {
    final List<Map<String, dynamic>> maps = await _database!.query('servicos');
    return List.generate(
      maps.length,
      (i) {
        return Service(
          id: maps[i]['id'],
          data: maps[i]['data'],
          km: maps[i]['km'],
          servico: maps[i]['servico'],
          valor: maps[i]['valor'],
        );
      },
    );
  }
}
