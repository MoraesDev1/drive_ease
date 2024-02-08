import 'package:driveease_v1/Model/corrida.dart';

abstract class CorridaDao {
  Future<Corrida> start(Corrida corrida);
  Future<Corrida> stop(Corrida corrida);
  Future excluir(Corrida corrida);
  Future atualizar(Corrida corrida);
  Future<List<Corrida>> listar();
}
