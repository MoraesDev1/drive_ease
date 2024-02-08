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
  final List<Corrida> _listDeCorridas = [
    Corrida.stop(
        dataHoraStart: '15/05/2024',
        startKm: 15,
        dataHoraStop: '15/05/2024',
        stopKm: 28,
        ganhos: 500),
    Corrida.stop(
        dataHoraStart: '15/05/2024',
        startKm: 15,
        dataHoraStop: '15/05/2024',
        stopKm: 28,
        ganhos: 500),
    Corrida.stop(
        dataHoraStart: '15/05/2024',
        startKm: 15,
        dataHoraStop: '15/05/2024',
        stopKm: 28,
        ganhos: 500),
    Corrida.stop(
        dataHoraStart: '15/05/2024',
        startKm: 15,
        dataHoraStop: '15/05/2024',
        stopKm: 28,
        ganhos: 500),
    Corrida.stop(
        dataHoraStart: '15/05/2024',
        startKm: 15,
        dataHoraStop: '15/05/2024',
        stopKm: 28,
        ganhos: 500),
    Corrida.stop(
        dataHoraStart: '15/05/2024',
        startKm: 15,
        dataHoraStop: '15/05/2024',
        stopKm: 28,
        ganhos: 500),
    Corrida.stop(
        dataHoraStart: '15/05/2024',
        startKm: 15,
        dataHoraStop: '15/05/2024',
        stopKm: 28,
        ganhos: 500),
    Corrida.stop(
        dataHoraStart: '15/05/2024',
        startKm: 15,
        dataHoraStop: '15/05/2024',
        stopKm: 28,
        ganhos: 500),
    Corrida.stop(
        dataHoraStart: '15/05/2024',
        startKm: 15,
        dataHoraStop: '15/05/2024',
        stopKm: 28,
        ganhos: 500),
    Corrida.stop(
        dataHoraStart: '15/05/2024',
        startKm: 15,
        dataHoraStop: '15/05/2024',
        stopKm: 28,
        ganhos: 500),
    Corrida.stop(
        dataHoraStart: '15/05/2024',
        startKm: 15,
        dataHoraStop: '15/05/2024',
        stopKm: 28,
        ganhos: 500),
    Corrida.stop(
        dataHoraStart: '15/05/2024',
        startKm: 15,
        dataHoraStop: '15/05/2024',
        stopKm: 28,
        ganhos: 500),
    Corrida.stop(
        dataHoraStart: '15/05/2024',
        startKm: 15,
        dataHoraStop: '15/05/2024',
        stopKm: 28,
        ganhos: 500),
    Corrida.stop(
        dataHoraStart: '15/05/2024',
        startKm: 15,
        dataHoraStop: '15/05/2024',
        stopKm: 28,
        ganhos: 500),
  ];
  final List<Servico> _listDeServices = [];

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
