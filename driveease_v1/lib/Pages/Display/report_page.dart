import 'package:driveease_v1/Database/Dao/Impl/corrida_dao_db.dart';
import 'package:driveease_v1/Database/Dao/Impl/servico_dao_db.dart';
import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Model/corrida.dart';
import 'package:driveease_v1/Model/servico.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late CorridaDaoDb _corridaDaoDb;
  late ServicoDaoDb _servicoDaoDb;
  Mediator mediator = Mediator();

  _filtraMes() async {
    List<double?> ganhos = [15, 25, 37, 95];
    List<double?> despesas = [11, 24, 22, 55, 10];
    double resultado = 0;
    List<Corrida> listaCorridaMes = await _corridaDaoDb.listarMes(DateTime
        .now()); //DateTime.now() inserido só pro código rodar, não faz parte da logica
    List<Servico> listaServicoMes = await _servicoDaoDb.listarMes(DateTime
        .now()); //DateTime.now() inserido só pro código rodar, não faz parte da logica
    for (Corrida corrida in listaCorridaMes) {
      ganhos.add(corrida.ganhos);
    }
    for (Servico servico in listaServicoMes) {
      despesas.add(servico.valor);
    }
    for (double? i in ganhos) {
      resultado += i!;
    }
    for (double? i in despesas) {
      resultado -= i!;
    }
    return resultado;
  }

  _carregarSemana() async {}

  _carregarDia() async {}

  _carregaListas() async {
    mediator.listaDeCorridas = await _corridaDaoDb.listar();
    mediator.listaDeServicos = await _servicoDaoDb.listar();
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    _corridaDaoDb = CorridaDaoDb();
    _servicoDaoDb = ServicoDaoDb();
    _carregaListas();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        backgroundColor: Utils.corFundo,
        appBar: AppBar(
          title: const Text('Relatórios'),
          backgroundColor: Utils.verdePrimario,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              color: Colors.green.shade500,
              child: TabBar(
                indicatorColor: Utils.corSecundaria,
                labelColor: Utils.corSecundaria,
                unselectedLabelColor: Colors.white,
                tabs: const <Widget>[
                  Tab(
                    child: Text('Diario'),
                  ),
                  Tab(
                    child: Text('Semanal'),
                  ),
                  Tab(
                    child: Text('Mensal'),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(child: Text('Diario')),
            Center(child: Text('Semanal')),
            Center(child: Text('Mensal')),
          ],
        ),
      ),
    );
  }
}
