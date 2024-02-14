import 'package:driveease_v1/Database/Dao/servico_dao.dart';
import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Model/servico.dart';

class ServicoDaoDb implements ServicoDao {
  final Mediator mediator = Mediator();

  @override
  Future editar(Servico servico) {
    throw UnimplementedError();
  }

  @override
  Future excluir(Servico servico) {
    throw UnimplementedError();
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
}
