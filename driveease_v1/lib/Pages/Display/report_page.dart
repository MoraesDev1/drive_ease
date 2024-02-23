import 'package:driveease_v1/Database/Dao/Impl/corrida_dao_db.dart';
import 'package:driveease_v1/Database/Dao/Impl/servico_dao_db.dart';
import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Model/corrida.dart';
import 'package:driveease_v1/Model/servico.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
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
    listCorridaSemana = filtrarCorridaSemana(DateTime.now());
  }

  carregaListas() async {
    mediator.listaDeCorridas = await _corridaDaoDb.listar();
    mediator.listaDeServicos = await _servicoDaoDb.listar();
  }

  List<dynamic> filtrarSemana(DateTime selectedDate) {
    //   String dataFormatada =
    //       DateFormat('dd/MM/yyyy HH:mm:ss').format(selectedDate);
    //   DateTime dataConvertida = DateTime.parse(dataFormatada);
    final firstDayOfWeek =
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));

    return mediator.listaDeCorridas.where((corrida) {
      DateTime itemDate = DateTime.parse(corrida.dataHoraStart);
      return itemDate.isAfter(firstDayOfWeek) &&
          itemDate.isBefore(lastDayOfWeek);
    }).toList();
  }

  List<Corrida> filtrarCorridaMes(DateTime selectedDate) {
    return mediator.listaDeCorridas.where((corrida) {
      DateTime itemDate = DateTime.parse(corrida.dataHoraStart);
      return itemDate.month == selectedDate.month &&
          itemDate.year == selectedDate.year;
    }).toList();
  }

  List<Servico> filtrarServicoMes(DateTime selectedDate) {
    return mediator.listaDeServicos.where((servico) {
      DateTime itemDate = DateTime.parse(servico.data);
      return itemDate.month == selectedDate.month &&
          itemDate.year == selectedDate.year;
    }).toList();
  }

  List<Corrida> filtrarCorridaSemana(DateTime selectedDate) {
    final firstDayOfWeek =
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 7));
    return mediator.listaDeCorridas.where((corrida) {
      DateTime itemDate = DateTime.parse(corrida.dataHoraStart);
      return itemDate.isAfter(firstDayOfWeek) &&
          itemDate.isBefore(lastDayOfWeek);
    }).toList();
  }

  List<Servico> filtrarServicoSemana(DateTime selectedDate) {
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

  Map<int, String> mesesDoAno = {
    1: 'Janeiro',
    2: 'Fevereiro',
    3: 'Março',
    4: 'Abril',
    5: 'Maio',
    6: 'Junho',
    7: 'Julho',
    8: 'Agosto',
    9: 'Setembro',
    10: 'Outubro',
    11: 'Novembro',
    12: 'Dezembro',
  };

  List<int> listaDeAnos = [
    2010,
    2011,
    2012,
    2013,
    2014,
    2015,
    2016,
    2017,
    2018,
    2019,
    2020,
    2021,
    2022,
    2023,
    2024,
    2025,
    2026,
    2027,
    2028,
    2029,
    2030,
    2031,
    2032,
    2033,
    2034,
    2035,
    2036,
    2037,
    2038,
    2039,
    2040
  ];

  List<int> diasDoMes = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        backgroundColor: UtilsColors.corFundo,
        appBar: AppBar(
          title: const Text('Relatórios'),
          centerTitle: true,
          backgroundColor: UtilsColors.verdePrimario,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              color: Colors.green.shade500,
              child: TabBar(
                indicatorColor: UtilsColors.corSecundaria,
                labelColor: UtilsColors.corSecundaria,
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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            setState(() {
                              if (dia > 1 && dia <= 31) {
                                dia = --dia;
                              } else if (mes > 1 && mes <= 12) {
                                dia = 31;
                                mes = --mes;
                              } else if (ano > 2010 && ano < 2040) {
                                mes = 12;
                                ano = --ano;
                              }
                            });
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
                          items: diasDoMes.map((dia) {
                            return DropdownMenuItem<int>(
                              value: dia,
                              child: Text(dia.toString()),
                            );
                          }).toList(),
                          onChanged: (int? novoDia) {
                            if (novoDia != null) {
                              setState(() {
                                dia = novoDia;
                              });
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
                          value: mesesDoAno[mes],
                          items: mesesDoAno.entries.map((entry) {
                            return DropdownMenuItem<String>(
                              value: entry.value,
                              child: Text(entry.value),
                            );
                          }).toList(),
                          onChanged: (String? novoMes) {
                            if (novoMes != null) {
                              setState(() {
                                mes = mesesDoAno.entries
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
                          items: listaDeAnos.map((ano) {
                            return DropdownMenuItem<int>(
                              value: ano,
                              child: Text(ano.toString()),
                            );
                          }).toList(),
                          onChanged: (int? novoAno) {
                            if (novoAno != null) {
                              setState(() {
                                ano = novoAno;
                              });
                            }
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (dia > 0 && dia < 31) {
                                dia = ++dia;
                              } else if (mes > 0 && mes < 12) {
                                dia = 1;
                                mes = ++mes;
                              } else if (ano > 2009 && ano < 2040) {
                                mes = 1;
                                ano = ++ano;
                              }
                            });
                          },
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            setState(() {
                              if (mes > 1 && mes <= 12) {
                                mes = --mes;
                              } else if (ano > 2010 && ano < 2040) {
                                mes = 12;
                                ano = --ano;
                              }
                            });
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
                          value: mesesDoAno[mes],
                          items: mesesDoAno.entries.map((entry) {
                            return DropdownMenuItem<String>(
                              value: entry.value,
                              child: Text(entry.value),
                            );
                          }).toList(),
                          onChanged: (String? novoMes) {
                            if (novoMes != null) {
                              setState(() {
                                mes = mesesDoAno.entries
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
                          items: listaDeAnos.map((ano) {
                            return DropdownMenuItem<int>(
                              value: ano,
                              child: Text(ano.toString()),
                            );
                          }).toList(),
                          onChanged: (int? novoAno) {
                            if (novoAno != null) {
                              setState(() {
                                ano = novoAno;
                              });
                            }
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (mes > 0 && mes < 12) {
                                mes = ++mes;
                              } else if (ano > 2009 && ano < 2040) {
                                mes = 1;
                                ano = ++ano;
                              }
                            });
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
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            setState(() {
                              if (mes > 1 && mes <= 12) {
                                mes = --mes;
                              } else if (ano > 2010 && ano < 2040) {
                                mes = 12;
                                ano = --ano;
                              }
                            });
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
                          value: mesesDoAno[mes],
                          items: mesesDoAno.entries.map((entry) {
                            return DropdownMenuItem<String>(
                              value: entry.value,
                              child: Text(entry.value),
                            );
                          }).toList(),
                          onChanged: (String? novoMes) {
                            if (novoMes != null) {
                              setState(() {
                                mes = mesesDoAno.entries
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
                          items: listaDeAnos.map((ano) {
                            return DropdownMenuItem<int>(
                              value: ano,
                              child: Text(ano.toString()),
                            );
                          }).toList(),
                          onChanged: (int? novoAno) {
                            if (novoAno != null) {
                              setState(() {
                                ano = novoAno;
                              });
                            }
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (mes > 0 && mes < 12) {
                                mes = ++mes;
                              } else if (ano > 2009 && ano < 2040) {
                                mes = 1;
                                ano = ++ano;
                              }
                            });
                          },
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
