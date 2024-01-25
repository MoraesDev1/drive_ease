// import 'package:driveease_v1/Database/day.dart';
// import 'package:driveease_v1/Database/service.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class BancoDeDados {
//   Database? _database;

//   Future<void> initializeDatabase() async {
//     _database = await openDatabase(
//       join(await getDatabasesPath(), 'driveease_v1.db'),
//       onCreate: (db, version) {
//         _createDayTable(db);
//         _createServiceTable(db);
//       },
//       version: 1,
//     );
//   }

//   Future<void> _createDayTable(Database db) async {
//     await db.execute('''
//       CREATE TABLE IF NOT EXISTS diario (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         data DATE,
//         start_km REAL,
//         stop_km REAL,
//         ganhos REAL
//       )
//     ''');
//   }

//   Future<void> _createServiceTable(Database db) async {
//     await db.execute('''
//       CREATE TABLE IF NOT EXISTS servicos (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         data TEXT,
//         km REAL,
//         servico TEXT,
//         valor REAL
//       )
//     ''');
//   }

//   Future<void> insertDay(Day day) async {
//     await _database.insert('days', day.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<void> insertService(Service service) async {
//     await _database.insert('services', service.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<List<Day>> getDays() async {
//     final List<Map<String, dynamic>> maps = await _database.query('days');

//     return List.generate(maps.length, (i) {
//       return Day(
//         id: maps[i]['id'],
//         data: maps[i]['data'],
//         startKm: maps[i]['startKm'],
//         stopKm: maps[i]['stopKm'],
//         ganhos: maps[i]['ganhos'],
//       );
//     });
//   }

//   Future<List<Service>> getServices() async {
//     final List<Map<String, dynamic>> maps = await _database.query('services');

//     return List.generate(maps.length, (i) {
//       return Service(
//         id: maps[i]['id'],
//         data: maps[i]['data'],
//         km: maps[i]['km'],
//         servico: maps[i]['servico'],
//         valor: maps[i]['valor'],
//       );
//     });
//   }
// }
