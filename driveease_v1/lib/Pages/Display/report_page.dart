import 'package:driveease_v1/Database/Dao/Impl/corrida_dao_db.dart';
import 'package:driveease_v1/Database/Dao/Impl/servico_dao_db.dart';
import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Model/corrida.dart';
import 'package:driveease_v1/Model/servico.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:driveease_v1/Widgets/Graphics/main_graphic_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late CorridaDaoDb _corridaDaoDb;
  late ServicoDaoDb _servicoDaoDb;
  Mediator mediator = Mediator();

  Future<void> _gerarRelatorioGrafico() async {
    double totalGanhos = mediator.listaDeCorridas
        .fold(0, (total, corrida) => total + (corrida.ganhos ?? 0));
    double totalDespesas = mediator.listaDeServicos
        .fold(0, (total, servico) => total + servico.valor.abs());
    print('Total Ganhos: $totalGanhos');
    print('Total Despesas: $totalDespesas');
    List lista = filtrarSemana(DateTime.now());
    print(lista);
  }

  List<dynamic> filtrarSemana(DateTime selectedDate) {
    String dataFormatada =
        DateFormat('dd/MM/yyyy HH:mm:ss').format(selectedDate);
    DateTime dataConvertida = DateTime.parse(dataFormatada);
    final firstDayOfWeek =
        dataConvertida.subtract(Duration(days: dataConvertida.weekday - 1));
    final lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));
    print(dataConvertida);

    return mediator.listaDeCorridas.where((corrida) {
      print(corrida.dataHoraStart);
      DateTime itemDate = DateTime.parse(corrida.dataHoraStart);
      return itemDate.isAfter(firstDayOfWeek) &&
          itemDate.isBefore(lastDayOfWeek);
    }).toList();
  }

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
          centerTitle: true,
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
        body: TabBarView(
          children: [
            FutureBuilder(
                future: _gerarRelatorioGrafico(),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      GraphicMain(),
                      Center(child: Text('Diario')),
                    ],
                  );
                }),
            Column(children: [
              GraphicMain(),
              Center(child: Text('Semanal')),
            ]),
            Column(children: [
              GraphicMain(),
              Center(child: Text('Mensal')),
            ]),
          ],
        ),
      ),
    );
  }
}
