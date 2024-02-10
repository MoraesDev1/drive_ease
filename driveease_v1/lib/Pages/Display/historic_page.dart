import 'package:driveease_v1/Database/Dao/Impl/corrida_dao_db.dart';
import 'package:driveease_v1/Database/Dao/Impl/servico_dao_db.dart';
import 'package:driveease_v1/Model/corrida.dart';
import 'package:driveease_v1/Model/servico.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:driveease_v1/Widgets/Cards/card_corrida.dart';
import 'package:driveease_v1/Widgets/Cards/card_servico.dart';
import 'package:flutter/material.dart';

class HistoricPage extends StatefulWidget {
  const HistoricPage({super.key});

  @override
  State<HistoricPage> createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  late CorridaDaoDb _corridaDaoDb;
  // ignore: unused_field
  late ServicoDaoDb _servicoDaoDb;
  List<Corrida> _listDeCorridas = [];
  List<Servico> _listDeServicos = [];

  _carregaListas() async {
    _listDeCorridas = await _corridaDaoDb.listar();
    // _listDeServicos = await _servicoDaoDb.listar();
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    _corridaDaoDb = CorridaDaoDb();
    _servicoDaoDb = ServicoDaoDb();
    _carregaListas();
  }

  _clickEditCorrida(Corrida corrida) {}
  _clickRemoverCorrida(Corrida corrida) {}
  _clickEditServico(Servico servico) {}
  _clickRemoverServico(Servico servico) {}

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
                          _clickEditCorrida(corrida);
                          break;
                        case MyItem.itemLongPress:
                        case MyItem.itemDelete:
                          _clickRemoverCorrida(corrida);
                          break;
                      }
                    },
                  );
                },
              ),
            ),
            Center(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10.0),
                itemCount: _listDeServicos.length,
                itemBuilder: (context, index) {
                  Servico servico = _listDeServicos[index];
                  return CardServico(
                    servico: servico,
                    onMenuClick: (MyItemServico item) {
                      switch (item) {
                        case MyItemServico.itemTap:
                        case MyItemServico.itemEdit:
                          _clickEditServico(servico);
                          break;
                        case MyItemServico.itemLongPress:
                        case MyItemServico.itemDelete:
                          _clickRemoverServico(servico);
                          break;
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
