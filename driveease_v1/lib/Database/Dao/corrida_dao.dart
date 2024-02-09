import 'package:driveease_v1/Model/corrida.dart';

abstract class CorridaDao {
  Future<Corrida> inserirStart(Corrida corrida);
  Future<Corrida> inserirStop(Corrida corrida, Corrida stop);
  Future excluir(Corrida corrida);
  Future atualizar(Corrida corrida);
  Future<List<Corrida>> listar();
  Future<List<Corrida>> listarSemana();
  Future<List<Corrida>> listarMes();
  Future<List<Corrida>> listarAno();
}
