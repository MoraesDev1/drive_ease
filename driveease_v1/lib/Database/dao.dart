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
      },
      version: 1,
    );
  }

  Future<void> _createDayTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS diario (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_carro,
        datahora_start TEXT,
        start_km REAL,
        stop_km REAL,
        ganhos REAL
      )
    ''');
  }

  Future<void> _createServiceTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS servicos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        data TEXT,
        km REAL,
        servico TEXT,
        valor REAL
      )
    ''');
  }

  Future<void> insertDay(Day day) async {
    await _database!.insert(
      'days',
      day.toMap(),
    );
  }

  Future<void> insertService(Service service) async {
    await _database!.insert(
      'services',
      service.toMap(),
    );
  }

  Future<List<Day>> getDays() async {
    final List<Map<String, dynamic>> maps = await _database!.query('days');
    return List.generate(
      maps.length,
      (i) {
        return Day(
          id: maps[i]['id'],
          idCarro: maps[i]['id_carro'],
          dataHoraStart: maps[i]['datahora_start'],
          startKm: maps[i]['startKm'],
          dataHoraStop: maps[i]['datahora_stop'],
          stopKm: maps[i]['stopKm'],
          ganhos: maps[i]['ganhos'],
        );
      },
    );
  }

  Future<List<Service>> getServices() async {
    final List<Map<String, dynamic>> maps = await _database!.query('services');
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
