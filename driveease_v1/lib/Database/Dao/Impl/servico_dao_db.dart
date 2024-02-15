import 'package:driveease_v1/Database/Dao/servico_dao.dart';
import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Model/servico.dart';

class ServicoDaoDb implements ServicoDao {
  final Mediator mediator = Mediator();

  @override
  Future editar(Servico servico) async {
    await mediator.db.update(
      'servico',
      servico.toMap(),
      where: 'id = ?',
      whereArgs: [servico.id],
    );
  }

  @override
  Future excluir(Servico servico) async {
    await mediator.db.delete(
      'servico',
      where: 'id = ?',
      whereArgs: [servico.id],
    );
  }

  @override
  Future<List<Servico>> listar() async {
    final List<Map<String, dynamic>> result =
        await mediator.db.query('servico');
    return result.map((e) => Servico.fromMap(e)).toList();
  }

  @override
  Future<Servico> inserir(Servico servico) async {
    servico.id = await mediator.db.insert('servico', servico.toMap());
    return servico;
  }

  Future<List<Servico>> listarSemana(DateTime now) async {
    final lastWeek = now.subtract(const Duration(days: 7));

    final List<Map<String, dynamic>> result = await mediator.db.query(
      'corrida',
      where: 'datahora_start BETWEEN ? AND ?',
      whereArgs: [lastWeek.toIso8601String(), now.toIso8601String()],
    );
    return result.map((e) => Servico.fromMap(e)).toList();
  }

  Future<List<Servico>> listarMes(DateTime now) async {
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    final List<Map<String, dynamic>> result = await mediator.db.query(
      'corrida',
      where: 'datahora_start BETWEEN ? AND ?',
      whereArgs: [
        firstDayOfMonth.toIso8601String(),
        lastDayOfMonth.toIso8601String(),
      ],
    );
    return result.map((e) => Servico.fromMap(e)).toList();
  }

  Future<List<Servico>> listarAno(DateTime now) async {
    final firstDayOfYear = DateTime(now.year, 1, 1);
    final lastDayOfYear = DateTime(now.year + 1, 0, 0);

    final List<Map<String, dynamic>> result = await mediator.db.query(
      'corrida',
      where: 'datahora_start BETWEEN ? AND ?',
      whereArgs: [
        firstDayOfYear.toIso8601String(),
        lastDayOfYear.toIso8601String(),
      ],
    );
    return result.map((e) => Servico.fromMap(e)).toList();
  }
}
