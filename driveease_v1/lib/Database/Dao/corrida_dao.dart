import 'package:driveease_v1/Model/corrida.dart';

abstract class CorridaDao {
  Future<Corrida> inserirStart(Corrida corrida);
  Future<Corrida> inserirStop(Corrida corrida);
  Future excluir(Corrida corrida);
  Future editar(Corrida corrida);
  Future<List<Corrida>> listar();
  Future<List<Corrida>> listarSemana(DateTime now);
  Future<List<Corrida>> listarMes(DateTime now);
  Future<List<Corrida>> listarAno(DateTime now);
}
