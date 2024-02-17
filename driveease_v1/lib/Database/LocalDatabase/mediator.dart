import 'package:driveease_v1/Model/corrida.dart';
import 'package:driveease_v1/Model/metas.dart';
import 'package:driveease_v1/Model/servico.dart';
import 'package:sqflite/sqflite.dart';

class Mediator {
  Mediator._privateConstructor();
  late Database db;
  List<Corrida> listaCorridaStart = [];
  List<Corrida> listaDeCorridas = [];
  List<Servico> listaDeServicos = [];
  List<Meta> listaDeMetas = [];

  static final Mediator _instance = Mediator._privateConstructor();

  factory Mediator() {
    return _instance;
  }

  buscarCorridaStart() async {
    final List<Map<String, dynamic>> result = await db.query('start');
    listaCorridaStart = result.map((e) => Corrida.fromMapStart(e)).toList();
  }

  limparStart() async {
    await db.delete('start');
    listaCorridaStart.clear();
  }
}
