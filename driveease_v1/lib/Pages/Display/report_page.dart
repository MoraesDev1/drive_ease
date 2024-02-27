import 'package:driveease_v1/Database/Dao/Impl/corrida_dao_db.dart';
import 'package:driveease_v1/Database/Dao/Impl/servico_dao_db.dart';
import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Model/corrida.dart';
import 'package:driveease_v1/Model/servico.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:driveease_v1/Utils/date_utils.dart';
import 'package:driveease_v1/Widgets/Graphics/report_graphic_mes_widget.dart';
import 'package:driveease_v1/Widgets/Graphics/report_graphic_semana_widget.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<Corrida> listCorridaDia = [];
  List<Servico> listServicoDia = [];
  List<Corrida> listCorridaSemana = [];
  List<Servico> listServicoSemana = [];
  List<Corrida> listCorridaMes = [];
  List<Servico> listServicoMes = [];
  Mediator mediator = Mediator();
  int dia = 1;
  int mes = 1;
  int ano = 2010;
  final CorridaDaoDb _corridaDaoDb = CorridaDaoDb();
  final ServicoDaoDb _servicoDaoDb = ServicoDaoDb();

  @override
  initState() {
    super.initState();
    String dataAtual = DateTime.now().toString();
    int diaAtual = int.parse(dataAtual.substring(8, 10));
    int mesAtual = int.parse(dataAtual.substring(6, 7));
    int anoAtual = int.parse(dataAtual.substring(0, 4));
    mes = mesAtual;
    ano = anoAtual;
    dia = diaAtual;
    carregaListas();
  }

  carregaListas() async {
    mediator.listaDeCorridas = await _corridaDaoDb.listar();
    mediator.listaDeServicos = await _servicoDaoDb.listar();
    listCorridaSemana = filtrarCorridaSemana();
    listServicoSemana = filtrarServicoSemana();
    listCorridaMes = filtrarCorridaMes();
    listServicoMes = filtrarServicoMes();
    setState(() {});
  }

  List<Corrida> filtrarCorridaMes() {
    DateTime selectedDate = DateTime(ano, mes);
    return mediator.listaDeCorridas.where((corrida) {
      DateTime itemDate = DateTime.parse(corrida.dataHoraStart);
      return itemDate.month == selectedDate.month &&
          itemDate.year == selectedDate.year;
    }).toList();
  }

  List<Servico> filtrarServicoMes() {
    DateTime selectedDate = DateTime(ano, mes);
    return mediator.listaDeServicos.where((servico) {
      DateTime itemDate = DateTime.parse(servico.data);
      return itemDate.month == selectedDate.month &&
          itemDate.year == selectedDate.year;
    }).toList();
  }

  List<Corrida> filtrarCorridaSemana() {
    DateTime selectedDate = DateTime(ano, mes, dia);
    final firstDayOfWeek =
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 7));
    var res = mediator.listaDeCorridas.where((corrida) {
      DateTime itemDate = DateTime.parse(corrida.dataHoraStart);
      return itemDate.isAfter(firstDayOfWeek) &&
          itemDate.isBefore(lastDayOfWeek);
    }).toList();
    print(res);
    return res;
  }

  List<Servico> filtrarServicoSemana() {
    DateTime selectedDate = DateTime(ano, mes, dia);
    final firstDayOfWeek =
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 7));

    return mediator.listaDeServicos.where((servico) {
      DateTime itemDate = DateTime.parse(servico.data);
      return itemDate.isAfter(firstDayOfWeek) &&
          itemDate.isBefore(lastDayOfWeek);
    }).toList();
  }

  List<Corrida> filtrarCorridaDia(DateTime selectedDate) {
    return mediator.listaDeCorridas.where((corrida) {
      DateTime itemDate = DateTime.parse(corrida.dataHoraStart);
      return itemDate.day == selectedDate.day;
    }).toList();
  }

  List<Servico> filtrarServicoDia(DateTime selectedDate) {
    return mediator.listaDeServicos.where((servico) {
      DateTime itemDate = DateTime.parse(servico.data);
      return itemDate.day == selectedDate.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: UtilsColors.corFundoTela,
        appBar: AppBar(
          title: const Text('Relatórios'),
          centerTitle: true,
          backgroundColor: UtilsColors.corAppBar,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              color: UtilsColors.corTabBar,
              child: TabBar(
                indicatorColor: UtilsColors.corDestaqueOn,
                labelColor: UtilsColors.corDestaqueOn,
                unselectedLabelColor: UtilsColors.corNaoSelecionado,
                tabs: const <Widget>[
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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    color: UtilsColors.corFundoPadraoWidgets,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            if (dia > 1 && dia <= 31) {
                              dia = --dia;
                            } else if (mes > 1 && mes <= 12) {
                              dia = 31;
                              mes = --mes;
                            } else if (ano > 2010 && ano < 2040) {
                              mes = 12;
                              ano = --ano;
                            }
                            carregaListas();
                          },
                        ),
                        DropdownButton<int>(
                          underline: const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                          icon: const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                          value: dia,
                          items: UtilsDates.diasDoMes.map((dia) {
                            return DropdownMenuItem<int>(
                              value: dia,
                              child: Text(dia.toString()),
                            );
                          }).toList(),
                          onChanged: (int? novoDia) {
                            if (novoDia != null) {
                              dia = novoDia;
                              carregaListas();
                            }
                          },
                        ),
                        DropdownButton<String>(
                          underline: const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                          icon: const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                          value: UtilsDates.mesesDoAno[mes],
                          items: UtilsDates.mesesDoAno.entries.map((entry) {
                            return DropdownMenuItem<String>(
                              value: entry.value,
                              child: Text(entry.value),
                            );
                          }).toList(),
                          onChanged: (String? novoMes) {
                            if (novoMes != null) {
                              setState(() {
                                mes = UtilsDates.mesesDoAno.entries
                                    .firstWhere(
                                        (entry) => entry.value == novoMes)
                                    .key;
                              });
                            }
                          },
                        ),
                        DropdownButton<int>(
                          underline: const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                          icon: const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                          value: ano,
                          items: UtilsDates.listaDeAnos.map((ano) {
                            return DropdownMenuItem<int>(
                              value: ano,
                              child: Text(ano.toString()),
                            );
                          }).toList(),
                          onChanged: (int? novoAno) {
                            if (novoAno != null) {
                              ano = novoAno;
                              carregaListas();
                            }
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            if (dia > 0 && dia < 31) {
                              dia = ++dia;
                            } else if (mes > 0 && mes < 12) {
                              dia = 1;
                              mes = ++mes;
                            } else if (ano > 2009 && ano < 2040) {
                              mes = 1;
                              ano = ++ano;
                            }
                            carregaListas();
                          },
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                  ),
                ),
                BarChartSemana(
                  listCorridaSemana: listCorridaSemana,
                  listServicoSemana: listServicoSemana,
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    color: UtilsColors.corFundoPadraoWidgets,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            if (mes > 1 && mes <= 12) {
                              mes = --mes;
                            } else if (ano > 2010 && ano < 2040) {
                              mes = 12;
                              ano = --ano;
                            }
                            carregaListas();
                          },
                        ),
                        DropdownButton<String>(
                          underline: const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                          icon: const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                          value: UtilsDates.mesesDoAno[mes],
                          items: UtilsDates.mesesDoAno.entries.map((entry) {
                            return DropdownMenuItem<String>(
                              value: entry.value,
                              child: Text(entry.value),
                            );
                          }).toList(),
                          onChanged: (String? novoMes) {
                            if (novoMes != null) {
                              mes = UtilsDates.mesesDoAno.entries
                                  .firstWhere((entry) => entry.value == novoMes)
                                  .key;
                              carregaListas();
                            }
                          },
                        ),
                        DropdownButton<int>(
                          underline: const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                          icon: const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                          value: ano,
                          items: UtilsDates.listaDeAnos.map((ano) {
                            return DropdownMenuItem<int>(
                              value: ano,
                              child: Text(ano.toString()),
                            );
                          }).toList(),
                          onChanged: (int? novoAno) {
                            if (novoAno != null) {
                              ano = novoAno;
                              carregaListas();
                            }
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            if (mes > 0 && mes < 12) {
                              mes = ++mes;
                            } else if (ano > 2009 && ano < 2040) {
                              mes = 1;
                              ano = ++ano;
                            }
                            carregaListas();
                          },
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                  ),
                ),
                // BarChartMes(
                //   listCorridaMes: listCorridaMes,
                //   listServicoMes: listServicoMes,
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
