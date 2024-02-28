import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Model/corrida.dart';
import 'package:driveease_v1/Model/servico.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// ignore: must_be_immutable
class BarChartMes extends StatelessWidget {
  BarChartMes(
      {super.key, required this.listCorridaMes, required this.listServicoMes});

  static Map<int, String> mapMesLucro = {};
  static Map<int, String> mapMesCorrida = {};
  static Map<int, String> mapMesServico = {};
  List<Corrida> listCorridaMes = [];
  List<Servico> listServicoMes = [];
  Mediator mediator = Mediator();
  double _lucro = 0;
  double _recebimento = 0;
  double _despesa = 0;
  Map<String, double> mapCorridaFiltrada = {};
  Map<String, double> mapServicoFiltrada = {};

  List<double> calculaLucroMes() {
    List<double> totaisRecebido = calculaRecebidosMes();
    List<double> totaisDespesas = calculaDespesasMes();
    List<double> totaisPorDia = [];
    double indice = 0;
    print('''recebidos $totaisRecebido
    despesas $totaisDespesas              ''');
    for (var i = 0; i < totaisRecebido.length; i++) {
      totaisPorDia.add(totaisRecebido[i] - totaisDespesas[i]);
    }
    _lucro = totaisPorDia.fold(_lucro, (valorAtual, proximoValor) {
      return valorAtual > proximoValor ? valorAtual : proximoValor;
    });
    return totaisPorDia;
  }

  List<double> calculaRecebidosMes() {
    double semU = 0;
    double semD = 0;
    double semT = 0;
    double semQ = 0;
    double semC = 0;
    List<double> totaisPorDia = [];
    Map<String, double?> somasDiarias = {};
    listCorridaMes.sort((a, b) => DateTime.parse(a.dataHoraStart)
        .compareTo(DateTime.parse(b.dataHoraStart)));
    for (Corrida objeto in listCorridaMes) {
      somasDiarias[objeto.dataHoraStart] =
          (somasDiarias[objeto.dataHoraStart] ?? 0) + objeto.ganhos!;
    }
    somasDiarias.forEach((dia, soma) {
      if (soma != null) {
        DateTime data = DateTime.parse(dia);
        int key = data.day;
        if (key >= 1 && key <= 7) {
          semU += soma;
        } else if (key >= 8 && key <= 14) {
          semD += soma;
        } else if (key >= 15 && key <= 21) {
          semT += soma;
        } else if (key >= 22 && key <= 28) {
          semQ += soma;
        } else if (key >= 29) {
          semC += soma;
        }
      }
    });
    totaisPorDia.add(semU);
    totaisPorDia.add(semD);
    totaisPorDia.add(semT);
    totaisPorDia.add(semQ);
    totaisPorDia.add(semC);

    _recebimento = totaisPorDia.fold(_recebimento, (valorAtual, proximoValor) {
      return valorAtual > proximoValor ? valorAtual : proximoValor;
    });
    return totaisPorDia;
  }

  List<double> calculaDespesasMes() {
    double semU = 0;
    double semD = 0;
    double semT = 0;
    double semQ = 0;
    double semC = 0;
    List<double> totaisPorDia = [];
    Map<String, double?> somasDiarias = {};
    listServicoMes.sort(
        (a, b) => DateTime.parse(a.data).compareTo(DateTime.parse(b.data)));

    for (Servico objeto in listServicoMes) {
      somasDiarias[objeto.data] =
          (somasDiarias[objeto.data] ?? 0) + objeto.valor;
    }
    print("somasDespesas $somasDiarias");
    somasDiarias.forEach((dia, soma) {
      if (soma != null) {
        DateTime data = DateTime.parse(dia);
        int key = data.day;
        if (key >= 1 && key <= 7) {
          semU += soma;
        } else if (key >= 8 && key <= 14) {
          semD += soma;
        } else if (key >= 15 && key <= 21) {
          semT += soma;
        } else if (key >= 22 && key <= 28) {
          semQ += soma;
        } else if (key >= 29) {
          semC += soma;
        }
      }
    });
    totaisPorDia.add(semU);
    totaisPorDia.add(semD);
    totaisPorDia.add(semT);
    totaisPorDia.add(semQ);
    totaisPorDia.add(semC);
    _despesa = totaisPorDia.fold(_despesa, (valorAtual, proximoValor) {
      return valorAtual > proximoValor ? valorAtual : proximoValor;
    });

    return totaisPorDia;
  }

  @override
  Widget build(BuildContext context) {
    var ganhosMes = calculaRecebidosMes();
    var despesasMes = calculaDespesasMes();
    var lucroMes = calculaLucroMes();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              const Text(
                'Lucro semanal',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 120,
                child: BarChart(
                  BarChartData(
                    titlesData: const FlTitlesData(
                        show: true,
                        leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: diasDaSemanaLucro))),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    alignment: BarChartAlignment.spaceAround,
                    maxY: _lucro,
                    barGroups: lucroMes
                        .asMap()
                        .entries
                        .map((entry) => BarChartGroupData(
                              x: entry.key,
                              barRods: [
                                BarChartRodData(
                                    width: 20,
                                    toY: entry.value,
                                    color: entry.value < 0
                                        ? Colors.orange[300]
                                        : Colors.green[400],
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(2),
                                        topLeft: Radius.circular(2))),
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Column(
            children: [
              const Text(
                'Recebimento semanal',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 120,
                child: BarChart(
                  BarChartData(
                    titlesData: const FlTitlesData(
                        show: true,
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: diasDaSemanaCorrida))),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    alignment: BarChartAlignment.spaceAround,
                    maxY: _recebimento,
                    barGroups: ganhosMes
                        .asMap()
                        .entries
                        .map((entry) => BarChartGroupData(
                              x: entry.key,
                              barRods: [
                                BarChartRodData(
                                    width: 20,
                                    toY: entry.value,
                                    color: Colors.blue[400],
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(2),
                                        topLeft: Radius.circular(2))),
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Column(
            children: [
              const Text(
                textAlign: TextAlign.start,
                'Despesa semanal',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 120,
                child: BarChart(
                  BarChartData(
                    titlesData: const FlTitlesData(
                        show: true,
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: diasDaSemanaServico))),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    alignment: BarChartAlignment.spaceAround,
                    maxY: _despesa,
                    barGroups: despesasMes
                        .asMap()
                        .entries
                        .map((entry) => BarChartGroupData(
                              x: entry.key,
                              barRods: [
                                BarChartRodData(
                                    width: 20,
                                    toY: entry.value,
                                    color: Colors.red[400],
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(2),
                                        topLeft: Radius.circular(2))),
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget diasDaSemanaLucro(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 10,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        'SEM 1',
        style: style,
      );
      break;
    case 1:
      text = const Text(
        'SEM 2',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'SEM 3',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'SEM 4',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'SEM 5',
        style: style,
      );
      break;
    default:
      text = const Text('');
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}

Widget diasDaSemanaCorrida(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 10,
  );
  Widget text;

  switch (value.toInt()) {
    case 0:
      text = const Text(
        'SEM 1',
        style: style,
      );
      break;
    case 1:
      text = const Text(
        'SEM 2',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'SEM 3',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'SEM 4',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'SEM 5',
        style: style,
      );
      break;
    default:
      text = const Text('');
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}

Widget diasDaSemanaServico(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 10,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        'SEM 1',
        style: style,
      );
      break;
    case 1:
      text = const Text(
        'SEM 2',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'SEM 3',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'SEM 4',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'SEM 5',
        style: style,
      );
      break;
    default:
      text = const Text('');
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
