import 'package:driveease_v1/Database/Dao/servico_dao.dart';
import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Model/servico.dart';

class ServicoDaoDb implements ServicoDao {
  final Mediator conexao = Mediator();

  @override
  Future atualizar(Servico servico) {
    // TODO: implement atualizar
    throw UnimplementedError();
  }

  @override
  Future excluir(Servico servico) {
    // TODO: implement excluir
    throw UnimplementedError();
  }

  @override
  Future<List<Servico>> listar() async {
    final List<Map<String, dynamic>> result = await conexao.db.query('servico');
    return result.map((e) => Servico.fromMap(e)).toList();
  }

  @override
  Future<Servico> inserir(Servico servico) async {
    servico.id = await conexao.db.insert('servico', servico.toMap());
    return servico;
  }
}
