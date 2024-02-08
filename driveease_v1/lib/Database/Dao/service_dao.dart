import 'package:driveease_v1/Model/service.dart';

abstract class ServiceDao {
  Future<Service> salvar(Service service);
  Future excluir(Service service);
  Future atualizar(Service service);
  Future<List<Service>> listar();
}
