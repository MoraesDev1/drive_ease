import 'package:driveease_v1/Database/Dao/corrida_dao.dart';
import 'package:driveease_v1/Database/conexao_db.dart';
import 'package:driveease_v1/Model/corrida.dart';

class CorridaDaoDb implements CorridaDao {
  final ConexaoDb conexao = ConexaoDb();

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

  Future<List<Corrida>> listarCorrida() async {
    final List<Map<String, dynamic>> result = await conexao.db.query('corrida');
    return result.map((e) => Corrida.fromMap(e)).toList();
  }

  @override
  Future<Corrida> start(Corrida corrida) async {
    await conexao.db.insert('start', corrida.toMap());
    return corrida;
  }

  @override
  Future<Corrida> stop(Corrida corrida) async {
    corrida.id = await conexao.db.insert('corrida', corrida.toMap());
    return corrida;
  }

  @override
  Future<List<Corrida>> listar() {
    // TODO: implement listar
    throw UnimplementedError();
  }
}
