import 'package:driveease_v1/Database/Dao/meta_dao.dart';
import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Model/metas.dart';

class MetaDaoDb implements MetaDao {
  final Mediator mediator = Mediator();

  @override
  Future editar(Meta meta) async {
    await mediator.db.update(
      'meta',
      meta.toMap(),
      where: 'id = ?',
      whereArgs: [meta.id],
    );
  }

  @override
  Future excluir(Meta meta) async {
    await mediator.db.delete(
      'meta',
      where: 'id = ?',
      whereArgs: [meta.id],
    );
  }

  @override
  Future<Meta> inserir(Meta meta) async {
    meta.id = await mediator.db.insert(
      'meta',
      meta.toMap(),
    );
    return meta;
  }

  @override
  Future<List<Meta>> listar() async {
    final List<Map<String, dynamic>> result = await mediator.db.query('meta');
    return result.map((e) => Meta.fromMap(e)).toList();
  }
}
