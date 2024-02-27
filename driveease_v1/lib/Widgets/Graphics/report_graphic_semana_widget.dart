import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Model/corrida.dart';
import 'package:driveease_v1/Model/servico.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class BarChartSemana extends StatelessWidget {
  BarChartSemana(
      {super.key,
      required this.listCorridaSemana,
      required this.listServicoSemana});

  Mediator mediator = Mediator();
  List<Corrida> listCorridaSemana;
  List<Servico> listServicoSemana;

  double lucro = 0;
  double recebimento = 0;
  double despesa = 0;
  Map<String, double> mapCorridaFiltrada = {};
  Map<String, double> mapServicoFiltrada = {};
  static Map<int, String> mapDiasDaSemanaLucro = {};
  static Map<int, String> mapDiasDaSemanaCorrida = {};
  static Map<int, String> mapDiasDaSemanaServico = {};

  List<double> calculaLucroSemana() {
    List<double> totaisPorDia = [];
    Map<String, double> somasDiarias = {};

    mapCorridaFiltrada.forEach((data, valor1) {
      if (mapServicoFiltrada.containsKey(data)) {
        double valor2 = mapServicoFiltrada[data]!;
        double resultado = valor1 - valor2;
        somasDiarias[data] = resultado;
      } else {
        somasDiarias[data] = valor1;
      }
    });

    if (mapCorridaFiltrada.isEmpty) {
      mapServicoFiltrada.forEach((key, value) {
        double resultado = value * (-1);
        somasDiarias[key] = resultado;
      });
    } else {
      mapCorridaFiltrada.forEach((data, valor1) {
        if (mapServicoFiltrada.containsKey(data)) {
          double valor2 = mapServicoFiltrada[data]!;
          double resultado = valor1 - valor2;
          somasDiarias[data] = resultado;
        } else {
          somasDiarias[data] = valor1;
        }
      });
    }
    int key = 0;
    somasDiarias.forEach((dia, soma) {
      mapDiasDaSemanaLucro[key] = dia;
      totaisPorDia.add(soma);
      key++;
    });
    lucro = totaisPorDia.fold(lucro, (valorAtual, proximoValor) {
      return valorAtual > proximoValor ? valorAtual : proximoValor;
    });
    return totaisPorDia;
  }

  List<double> calculaGanhosSemana() {
    List<double> totaisPorDia = [];
    Map<String, double?> somasDiarias = {};

    listCorridaSemana.sort((a, b) => DateTime.parse(a.dataHoraStart)
        .compareTo(DateTime.parse(b.dataHoraStart)));

    for (Corrida objeto in listCorridaSemana) {
      DateTime dataObjeto = DateTime.parse(objeto.dataHoraStart);
      String diaFormatado = DateFormat('dd/MM/yyyy').format(dataObjeto);
      somasDiarias[diaFormatado] =
          (somasDiarias[diaFormatado] ?? 0) + objeto.ganhos!;
    }
    int key = 0;
    somasDiarias.forEach((dia, soma) {
      mapCorridaFiltrada[dia] = soma!;
      mapDiasDaSemanaCorrida[key] = dia;
      key++;
      totaisPorDia.add(soma);
    });
    recebimento = totaisPorDia.fold(recebimento, (valorAtual, proximoValor) {
      return valorAtual > proximoValor ? valorAtual : proximoValor;
    });
    return totaisPorDia;
  }

  List<double> calculaDespesasSemana() {
    List<double> totaisPorDia = [];
    Map<String, double?> somasDiarias = {};

    listCorridaSemana.sort((a, b) => DateTime.parse(a.dataHoraStart)
        .compareTo(DateTime.parse(b.dataHoraStart)));

    for (Servico objeto in listServicoSemana) {
      DateTime dataObjeto = DateTime.parse(objeto.data);
      String diaFormatado = DateFormat('dd/MM/yyyy').format(dataObjeto);
      somasDiarias[diaFormatado] =
          (somasDiarias[diaFormatado] ?? 0) + objeto.valor;
    }
    int key = 0;
    somasDiarias.forEach((dia, soma) {
      mapServicoFiltrada[dia] = soma!;
      mapDiasDaSemanaServico[key] = dia;
      key++;
      totaisPorDia.add(soma);
    });

    despesa = totaisPorDia.fold(despesa, (valorAtual, proximoValor) {
      return valorAtual > proximoValor ? valorAtual : proximoValor;
    });
    return totaisPorDia;
  }

  @override
  Widget build(BuildContext context) {
    var ganhosSemana = calculaGanhosSemana();
    var despesasSemana = calculaDespesasSemana();
    var lucroSemana = calculaLucroSemana();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: UtilsColors.corFundoPadraoWidgets,
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const Text(
                  'Lucro',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
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
                              getTitlesWidget: diasDaSemanaLucro),
                        ),
                      ),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      alignment: BarChartAlignment.spaceAround,
                      maxY: lucro,
                      barGroups: lucroSemana
                          .asMap()
                          .entries
                          .map((entry) => BarChartGroupData(
                                x: entry.key,
                                barRods: [
                                  BarChartRodData(
                                      width: 45,
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
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              color: UtilsColors.corFundoPadraoWidgets,
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  'Recebimentos',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 8,
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
                      maxY: recebimento,
                      barGroups: ganhosSemana
                          .asMap()
                          .entries
                          .map((entry) => BarChartGroupData(
                                x: entry.key,
                                barRods: [
                                  BarChartRodData(
                                      width: 45,
                                      toY: entry.value,
                                      color: Colors.blue[600],
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
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
              color: UtilsColors.corFundoPadraoWidgets,
              border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  textAlign: TextAlign.start,
                  'Despesas',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 8,
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
                      maxY: despesa,
                      barGroups: despesasSemana
                          .asMap()
                          .entries
                          .map((entry) => BarChartGroupData(
                                x: entry.key,
                                barRods: [
                                  BarChartRodData(
                                      width: 45,
                                      toY: entry.value,
                                      color: Colors.red[600],
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
  Map<int, String> mapFodac = BarChartSemana.mapDiasDaSemanaLucro;
  Widget text;
  switch (value.toInt()) {
    case 0:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[0]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 1:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[1]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 2:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[2]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 3:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[3]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 4:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[4]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 5:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[5]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 6:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[6]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
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
  Map<int, String> mapFodac = BarChartSemana.mapDiasDaSemanaCorrida;
  Widget text;
  switch (value.toInt()) {
    case 0:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[0]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 1:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[1]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 2:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[2]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 3:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[3]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 4:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[4]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 5:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[5]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 6:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[6]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
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
  Map<int, String> mapFodac = BarChartSemana.mapDiasDaSemanaServico;
  Widget text;
  switch (value.toInt()) {
    case 0:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[0]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 1:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[1]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 2:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[2]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 3:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[3]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 4:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[4]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 5:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[5]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 6:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[6]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    default:
      text = const Text('');
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
