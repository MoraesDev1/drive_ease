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
    throw UnimplementedError();
  }

  @override
  Future<Corrida> inserirStart(Corrida corrida) async {
    corrida.id = await conexao.db.insert('start', corrida.toMap());
    return corrida;
  }

  @override
  Future<Corrida> inserirStop(Corrida corrida, Corrida start) async {
    final List<Map<String, dynamic>> startResults = await conexao.db.query(
      'start',
      limit: 1,
    );
    if (startResults.isNotEmpty) {
      final Map<String, dynamic> startCorrida = startResults.first;
      start.id = startCorrida['id'];
      start.dataHoraStart = startCorrida['datahora_start'];
      start.startKm = startCorrida['start_km'];

      corrida.dataHoraStart = start.dataHoraStart;
      corrida.id = await conexao.db.insert('corrida', corrida.toMap());
      await conexao.db.delete(
        'start',
        where: 'id = ?',
        whereArgs: [start.id],
      );
      return corrida;
    } else {
      throw Exception('Nenhuma corrida iniciada para parar.');
    }
  }

  @override
  Future<List<Corrida>> listar() async {
    final List<Map<String, dynamic>> result = await conexao.db.query('corrida');
    return result.map((e) => Corrida.fromMap(e)).toList();
  }

  @override
  Future<List<Corrida>> listarSemana() async {
    final now = DateTime.now();
    final lastWeek = now.subtract(Duration(days: 7));

    final List<Map<String, dynamic>> result = await conexao.db.query(
      'corrida',
      where: 'datahora_start BETWEEN ? AND ?',
      whereArgs: [lastWeek.toIso8601String(), now.toIso8601String()],
    );
    return result.map((e) => Corrida.fromMap(e)).toList();
  }

  @override
  Future<List<Corrida>> listarMes() async {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    final List<Map<String, dynamic>> result = await conexao.db.query(
      'corrida',
      where: 'datahora_start BETWEEN ? AND ?',
      whereArgs: [
        firstDayOfMonth.toIso8601String(),
        lastDayOfMonth.toIso8601String(),
      ],
    );
    return result.map((e) => Corrida.fromMap(e)).toList();
  }

  Future<List<Corrida>> listarAno() async {
    final now = DateTime.now();
    final firstDayOfYear = DateTime(now.year, 1, 1);
    final lastDayOfYear = DateTime(now.year + 1, 0, 0);

    final List<Map<String, dynamic>> result = await conexao.db.query(
      'corrida',
      where: 'datahora_start BETWEEN ? AND ?',
      whereArgs: [
        firstDayOfYear.toIso8601String(),
        lastDayOfYear.toIso8601String(),
      ],
    );
    return result.map((e) => Corrida.fromMap(e)).toList();
  }
}
