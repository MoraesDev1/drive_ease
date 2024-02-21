import 'package:driveease_v1/Database/Dao/Impl/corrida_dao_db.dart';
import 'package:driveease_v1/Database/Dao/Impl/servico_dao_db.dart';
import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Model/corrida.dart';
import 'package:driveease_v1/Model/servico.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:driveease_v1/Widgets/Cards/card_corrida.dart';
import 'package:driveease_v1/Widgets/Cards/card_servico.dart';
import 'package:driveease_v1/Widgets/Graphics/report_graphic_widget.dart';
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
  List<Corrida> listCorridaDia = [];
  List<Servico> listServicoDia = [];
  List<Corrida> listCorridaSemana = [];
  List<Servico> listServicoSemana = [];
  List<Corrida> listCorridaMes = [];
  List<Servico> listServicoMes = [];

  @override
  initState() {
    super.initState();
    _corridaDaoDb = CorridaDaoDb();
    _servicoDaoDb = ServicoDaoDb();
    _carregaListas();
    listCorridaDia = _filtrarCorridaDia(DateTime(2024, 02, 14, 19, 04, 54, 45));
    // listServicoDia = _filtrarServicoDia(DateTime(2024, 01, 10, 19, 04, 54, 45));
    listCorridaSemana = _filtrarCorridaSemana(DateTime.now());
    // listServicoSemana =
    //     _filtrarServicoSemana(DateTime(2024, 01, 10, 19, 04, 54, 45));
    listCorridaMes = _filtrarCorridaMes(DateTime(2024, 01, 10, 19, 04, 54, 45));
    // listServicoMes = _filtrarServicoMes(DateTime(2024, 01, 10, 19, 04, 54, 45));
    _gerarRelatorioGrafico();
  }

  _carregaListas() async {
    mediator.listaDeCorridas = await _corridaDaoDb.listar();
    mediator.listaDeServicos = await _servicoDaoDb.listar();
    setState(() {});
  }

  _gerarRelatorioGrafico() {
    double totalGanhos = mediator.listaDeCorridas
        .fold(0, (total, corrida) => total + (corrida.ganhos ?? 0));
    double totalDespesas = mediator.listaDeServicos
        .fold(0, (total, servico) => total + servico.valor.abs());
    print('Total Ganhos: $totalGanhos');
    print('Total Despesas: $totalDespesas');
    List lista = _filtrarCorridaSemana(DateTime.now());
    print(lista);
  }

  List<Corrida> _filtrarCorridaMes(DateTime selectedDate) {
    return mediator.listaDeCorridas.where((corrida) {
      DateTime converterStringParaDateTime(String stringDataHora) {
        List<String> partes = stringDataHora.split(' ');
        List<String> partesData = partes[0].split('/');
        List<String> partesHora = partes[1].split(':');
        DateTime dataHoraObjeto = DateTime(
          int.parse(partesData[2]), // ano
          int.parse(partesData[1]), // mês
          int.parse(partesData[0]), // dia
          int.parse(partesHora[0]), // hora
          int.parse(partesHora[1]), // minuto
          int.parse(partesHora[2]), // segundo
        );
        return dataHoraObjeto;
      }

      DateTime itemDate = converterStringParaDateTime(corrida.dataHoraStart);
      print(itemDate);
      return itemDate.month == selectedDate.month &&
          itemDate.year == selectedDate.year;
    }).toList();
  }

  List<Servico> _filtrarServicoMes(DateTime selectedDate) {
    return mediator.listaDeServicos.where((servico) {
      DateTime converterStringParaDateTime(String stringDataHora) {
        List<String> partes = stringDataHora.split(' ');
        List<String> partesData = partes[0].split('/');
        List<String> partesHora = partes[1].split(':');
        DateTime dataHoraObjeto = DateTime(
          int.parse(partesData[2]), // ano
          int.parse(partesData[1]), // mês
          int.parse(partesData[0]), // dia
          int.parse(partesHora[0]), // hora
          int.parse(partesHora[1]), // minuto
          int.parse(partesHora[2]), // segundo
        );
        return dataHoraObjeto;
      }

      DateTime itemDate = converterStringParaDateTime(servico.data);
      print(itemDate);
      return itemDate.month == selectedDate.month &&
          itemDate.year == selectedDate.year;
    }).toList();
  }

  List<Corrida> _filtrarCorridaSemana(DateTime selectedDate) {
    final firstDayOfWeek =
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final lastDayOfWeek = firstDayOfWeek.add(Duration(days: 7));
    print(selectedDate);
    return mediator.listaDeCorridas.where((corrida) {
      DateTime converterStringParaDateTime(String stringDataHora) {
        List<String> partes = stringDataHora.split(' ');
        List<String> partesData = partes[0].split('/');
        List<String> partesHora = partes[1].split(':');
        DateTime dataHoraObjeto = DateTime(
          int.parse(partesData[2]), // ano
          int.parse(partesData[1]), // mês
          int.parse(partesData[0]), // dia
          int.parse(partesHora[0]), // hora
          int.parse(partesHora[1]), // minuto
          int.parse(partesHora[2]), // segundo
        );
        return dataHoraObjeto;
      }

      DateTime itemDate = converterStringParaDateTime(corrida.dataHoraStart);
      print(itemDate);
      return itemDate.isAfter(firstDayOfWeek) &&
          itemDate.isBefore(lastDayOfWeek);
    }).toList();
  }

  List<Servico> _filtrarServicoSemana(DateTime selectedDate) {
    final firstDayOfWeek =
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final lastDayOfWeek = firstDayOfWeek.add(Duration(days: 7));
    print(selectedDate);
    return mediator.listaDeServicos.where((servico) {
      DateTime converterStringParaDateTime(String stringDataHora) {
        List<String> partes = stringDataHora.split(' ');
        List<String> partesData = partes[0].split('/');
        List<String> partesHora = partes[1].split(':');
        DateTime dataHoraObjeto = DateTime(
          int.parse(partesData[2]), // ano
          int.parse(partesData[1]), // mês
          int.parse(partesData[0]), // dia
          int.parse(partesHora[0]), // hora
          int.parse(partesHora[1]), // minuto
          int.parse(partesHora[2]), // segundo
        );
        return dataHoraObjeto;
      }

      DateTime itemDate = converterStringParaDateTime(servico.data);
      print(itemDate);
      return itemDate.isAfter(firstDayOfWeek) &&
          itemDate.isBefore(lastDayOfWeek);
    }).toList();
  }

  List<Corrida> _filtrarCorridaDia(DateTime selectedDate) {
    return mediator.listaDeCorridas.where((corrida) {
      DateTime converterStringParaDateTime(String stringDataHora) {
        List<String> partes = stringDataHora.split(' ');
        List<String> partesData = partes[0].split('/');
        List<String> partesHora = partes[1].split(':');
        DateTime dataHoraObjeto = DateTime(
          int.parse(partesData[2]), // ano
          int.parse(partesData[1]), // mês
          int.parse(partesData[0]), // dia
          int.parse(partesHora[0]), // hora
          int.parse(partesHora[1]), // minuto
          int.parse(partesHora[2]), // segundo
        );
        return dataHoraObjeto;
      }

      DateTime itemDate = converterStringParaDateTime(corrida.dataHoraStart);
      print(itemDate);
      return itemDate.day == selectedDate.day;
    }).toList();
  }

  List<Servico> _filtrarServicoDia(DateTime selectedDate) {
    return mediator.listaDeServicos.where((servico) {
      DateTime converterStringParaDateTime(String stringDataHora) {
        List<String> partes = stringDataHora.split(' ');
        List<String> partesData = partes[0].split('/');
        List<String> partesHora = partes[1].split(':');
        DateTime dataHoraObjeto = DateTime(
          int.parse(partesData[2]), // ano
          int.parse(partesData[1]), // mês
          int.parse(partesData[0]), // dia
          int.parse(partesHora[0]), // hora
          int.parse(partesHora[1]), // minuto
          int.parse(partesHora[2]), // segundo
        );
        return dataHoraObjeto;
      }

      DateTime itemDate = converterStringParaDateTime(servico.data);
      print(itemDate);
      return itemDate.day == selectedDate.day;
    }).toList();
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
            ListView.builder(
              padding: const EdgeInsets.only(top: 10.0),
              itemCount: listCorridaDia.length,
              itemBuilder: (context, index) {
                Corrida corrida = listCorridaDia[index];
                return CardCorrida(
                  corrida: corrida,
                  onMenuClick: (MyItemCorrida item) {
                    switch (item) {
                      case MyItemCorrida.itemTap:
                      case MyItemCorrida.itemEdit:
                        break;
                      case MyItemCorrida.itemLongPress:
                      case MyItemCorrida.itemDelete:
                        break;
                    }
                  },
                );
              },
            ),
            BarChartSemana(
              listCorridaSemana: listCorridaSemana,
              listServicoSemana: listServicoSemana,
            ),
            ListView.builder(
              padding: const EdgeInsets.only(top: 10.0),
              itemCount: listCorridaMes.length,
              itemBuilder: (context, index) {
                Corrida corrida = listCorridaMes[index];
                return CardCorrida(
                  corrida: corrida,
                  onMenuClick: (MyItemCorrida item) {
                    switch (item) {
                      case MyItemCorrida.itemTap:
                      case MyItemCorrida.itemEdit:
                        break;
                      case MyItemCorrida.itemLongPress:
                      case MyItemCorrida.itemDelete:
                        break;
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
