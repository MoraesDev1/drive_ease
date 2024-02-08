import 'package:driveease_v1/Database/Dao/corrida_dao.dart';
import 'package:driveease_v1/Database/database.dart';
import 'package:driveease_v1/Model/corrida.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CorridaDaoDb implements CorridaDao {

  final LocalDatabase _db = LocalDatabase();

  @override
  Future atualizar(Corrida corrida) {
    // TODO: implement atualizar
    throw UnimplementedError();
  }

  @override
  Future excluir(Corrida corrida) {
    // TODO: implement excluir
    throw UnimplementedError();
  }

  @override
  Future<List<Corrida>> listar() async {
      final List<Map<String, dynamic>> result = await _db.query(
      'diario',
    );
    return result.map((e) => Corrida.fromMap(e)).toList();
  }
  
  @override
  Future<Corrida> start(Corrida corrida) {
    // TODO: implement start
    throw UnimplementedError();
  }
  
  @override
  Future<Corrida> stop(Corrida corrida) {
    // TODO: implement stop
    throw UnimplementedError();
  }
  }

  @override
  Future<Corrida> start(Corrida corrida) async {
    corrida.id = await _db!.insert('diario', Corrida.start.toMap());
    return corrida;
  }

  @override
  Future<Corrida> stop(Corrida corrida) async {
    corrida.id = await _db!.insert('diario', Corrida.stop.toMap());
    return corrida;
  }
}
