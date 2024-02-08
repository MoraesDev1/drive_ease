import 'package:driveease_v1/Model/servico.dart';

abstract class ServicoDao {
  Future<Servico> salvar(Servico servico);
  Future excluir(Servico servico);
  Future atualizar(Servico servico);
  Future<List<Servico>> listar();
}
