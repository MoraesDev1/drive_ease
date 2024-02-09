import 'package:driveease_v1/Database/Dao/Impl/corrida_dao_db.dart';
import 'package:driveease_v1/Database/Dao/Impl/servico_dao_db.dart';
import 'package:driveease_v1/Model/corrida.dart';
import 'package:driveease_v1/Model/servico.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:driveease_v1/Widgets/card_corrida.dart';
import 'package:flutter/material.dart';

class HistoricPage extends StatefulWidget {
  const HistoricPage({super.key});

  @override
  State<HistoricPage> createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  final CorridaDaoDb _corridaDaoDb = CorridaDaoDb();
  final ServicoDaoDb _servicoDaoDb = ServicoDaoDb();
  final List<Corrida> _listDeCorridas = [];
  final List<Servico> _listDeServices = [];

  Future<void> _loadCorridas() async {
    final List<Corrida> corridas = await _corridaDaoDb.listar();
    setState(() {
      _listDeCorridas.clear();
      _listDeCorridas.addAll(corridas);
    });
  }

  Future<void> _loadServicos() async {
    final List<Servico> servicos = await _servicoDaoDb.listar();
    setState(() {
      _listDeServices.clear();
      _listDeServices.addAll(servicos);
    });
  }

  _clickEdit(Corrida corrida) {}
  _clickRemover(Corrida corrida) {}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Histórico'),
          backgroundColor: Utils.corPrimaria,
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
                    child: Text('Corridas'),
                  ),
                  Tab(
                    child: Text('Serviços'),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10.0),
                itemCount: _listDeCorridas.length,
                itemBuilder: (context, index) {
                  Corrida corrida = _listDeCorridas[index];
                  return CardCorrida(
                    corrida: corrida,
                    onMenuClick: (MyItem item) {
                      switch (item) {
                        case MyItem.itemTap:
                        case MyItem.itemEdit:
                          _clickEdit(corrida);
                          break;
                        case MyItem.itemLongPress:
                        case MyItem.itemDelete:
                          _clickRemover(corrida);
                          break;
                      }
                    },
                  );
                },
              ),
            ),
            const Center(
              child: Text("Serviços aqui"),
            ),
          ],
        ),
      ),
    );
  }
}
