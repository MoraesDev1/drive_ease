import 'package:driveease_v1/Database/Dao/Impl/corrida_dao_db.dart';
import 'package:driveease_v1/Database/Dao/Impl/servico_dao_db.dart';
import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Model/corrida.dart';
import 'package:driveease_v1/Model/servico.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
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
  List<Corrida> listCorridaDia = [];
  List<Servico> listServicoDia = [];
  List<Corrida> listCorridaSemana = [];
  List<Servico> listServicoSemana = [];
  List<Corrida> listCorridaMes = [];
  List<Servico> listServicoMes = [];
  int dia = 1;
  int mes = 1;
  int ano = 2010;

  @override
  initState() {
    super.initState();
    String dataAtual = DateTime.now().toString();
    int diaAtual = int.parse(dataAtual.substring(8, 9));
    int mesAtual = int.parse(dataAtual.substring(6, 7));
    int anoAtual = int.parse(dataAtual.substring(0, 4));
    mes = mesAtual;
    ano = anoAtual;
    dia = diaAtual;
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
      return itemDate.month == selectedDate.month &&
          itemDate.year == selectedDate.year;
    }).toList();
  }

  List<Corrida> _filtrarCorridaSemana(DateTime selectedDate) {
    final firstDayOfWeek =
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 7));
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

      return itemDate.isAfter(firstDayOfWeek) &&
          itemDate.isBefore(lastDayOfWeek);
    }).toList();
  }

  List<Servico> _filtrarServicoSemana(DateTime selectedDate) {
    final firstDayOfWeek =
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final lastDayOfWeek = firstDayOfWeek.add(Duration(days: 7));

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
