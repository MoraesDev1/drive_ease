import 'package:driveease_v1/Model/car.dart';
import 'package:driveease_v1/Model/day.dart';
import 'package:driveease_v1/Model/service.dart';
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
        _createCarTable(db);
      },
      version: 1,
    );
  }

  Future<void> _createCarTable(Database db) async {
    await db.execute(''' CREATE TABLE IF NOT EXISTS carros (
        id_carro INTEGER   AUTOINCREMENT,
        descricao TEXT(100),
        PRIMARY KEY(id_carro)
      )
    ''');
  }

  Future<void> _createDayTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS diario (
        id INTEGER AUTOINCREMENT,
        id_carro INTEGER,
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
        id INTEGER AUTOINCREMENT,
        id_carro INTEGER,
        data TEXT,
        km REAL,
        servico TEXT,
        valor REAL,
        PRIMARY KEY(id),
        FOREIGN KEY(id_carro) REFERENCES carro(id_carro)
      )
    ''');
  }

  Future<Car> insertCar(Car car) async {
    car.idCarro = await _database!.insert('carros', car.toMap());
    return car;
  }

  Future<Day> insertDay(Day day) async {
    day.id = await _database!.insert('diario', day.toMap());
    return day;
  }

  Future<Service> insertService(Service service) async {
    service.id = await _database!.insert('servicos', service.toMap());
    return service;
  }

  Future<List<Car>> getCar() async {
    final List<Map<String, dynamic>> result = await _database!.query('carros');
    return result.map((e) => Car.fromMap(e)).toList();
  }

  Future<List<Day>> getDays() async {
    final List<Map<String, dynamic>> result = await _database!.query('diario');
    return result.map((e) => Day.fromMap(e)).toList();
  }

  Future<List<Service>> getServices() async {
    final List<Map<String, dynamic>> result =
        await _database!.query('servicos');
    return result.map((e) => Service.fromMap(e)).toList();
  }

  Future<List<Day>> getWeeklyReport() async {
    final now = DateTime.now();
    final lastWeek = now.subtract(Duration(days: 7));

    final List<Map<String, dynamic>> result = await _database!.query(
      'diario',
      where: 'datahora_start BETWEEN ? AND ?',
      whereArgs: [lastWeek.toIso8601String(), now.toIso8601String()],
    );
    return result.map((e) => Day.fromMap(e)).toList();
  }

  Future<List<Day>> getMonthlyReport() async {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    final List<Map<String, dynamic>> result = await _database!.query(
      'diario',
      where: 'datahora_start BETWEEN ? AND ?',
      whereArgs: [
        firstDayOfMonth.toIso8601String(),
        lastDayOfMonth.toIso8601String(),
      ],
    );
    return result.map((e) => Day.fromMap(e)).toList();
  }

  Future<List<Day>> getYearlyReport() async {
    final now = DateTime.now();
    final firstDayOfYear = DateTime(now.year, 1, 1);
    final lastDayOfYear = DateTime(now.year + 1, 0, 0);

    final List<Map<String, dynamic>> result = await _database!.query(
      'diario',
      where: 'datahora_start BETWEEN ? AND ?',
      whereArgs: [
        firstDayOfYear.toIso8601String(),
        lastDayOfYear.toIso8601String(),
      ],
    );
    return result.map((e) => Day.fromMap(e)).toList();
  }
}
