import 'package:driveease_v1/Model/metas.dart';

abstract class MetaDao {
  Future<Meta> inserir(Meta meta);
  Future excluir(Meta meta);
  Future editar(Meta meta);
  Future<List<Meta>> listar();
}
