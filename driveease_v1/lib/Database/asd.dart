// import 'package:driveease_v1/Model/car.dart';
// import 'package:driveease_v1/Model/corrida.dart';
// import 'package:driveease_v1/Model/service.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class BancoDeDados {
//   Future<Car> insertCar(Car car) async {
//     car.idCarro = await _database!.insert('carros', car.toMap());
//     return car;
//   }

//   Future<Corrida> insertDay(Corrida day) async {
//     day.id = await _database!.insert('diario', day.toMap());
//     return day;
//   }

//   Future<Service> insertService(Service service) async {
//     service.id = await _database!.insert('servicos', service.toMap());
//     return service;
//   }

//   Future<List<Car>> getCar() async {
//     final List<Map<String, dynamic>> result = await _database!.query('carros');
//     return result.map((e) => Car.fromMap(e)).toList();
//   }

//   Future<List<Corrida>> getDays() async {
//     final List<Map<String, dynamic>> result = await _database!.query('diario');
//     return result.map((e) => Corrida.fromMap(e)).toList();
//   }

//   Future<List<Service>> getServices() async {
//     final List<Map<String, dynamic>> result =
//         await _database!.query('servicos');
//     return result.map((e) => Service.fromMap(e)).toList();
//   }

//   Future<List<Corrida>> getWeeklyReport() async {
//     final now = DateTime.now();
//     final lastWeek = now.subtract(Duration(days: 7));

//     final List<Map<String, dynamic>> result = await _database!.query(
//       'diario',
//       where: 'datahora_start BETWEEN ? AND ?',
//       whereArgs: [lastWeek.toIso8601String(), now.toIso8601String()],
//     );
//     return result.map((e) => Corrida.fromMap(e)).toList();
//   }

//   Future<List<Corrida>> getMonthlyReport() async {
//     final now = DateTime.now();
//     final firstDayOfMonth = DateTime(now.year, now.month, 1);
//     final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

//     final List<Map<String, dynamic>> result = await _database!.query(
//       'diario',
//       where: 'datahora_start BETWEEN ? AND ?',
//       whereArgs: [
//         firstDayOfMonth.toIso8601String(),
//         lastDayOfMonth.toIso8601String(),
//       ],
//     );
//     return result.map((e) => Corrida.fromMap(e)).toList();
//   }

//   Future<List<Corrida>> getYearlyReport() async {
//     final now = DateTime.now();
//     final firstDayOfYear = DateTime(now.year, 1, 1);
//     final lastDayOfYear = DateTime(now.year + 1, 0, 0);

//     final List<Map<String, dynamic>> result = await _database!.query(
//       'diario',
//       where: 'datahora_start BETWEEN ? AND ?',
//       whereArgs: [
//         firstDayOfYear.toIso8601String(),
//         lastDayOfYear.toIso8601String(),
//       ],
//     );
//     return result.map((e) => Corrida.fromMap(e)).toList();
//   }
// }
