import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Model/corrida.dart';
import 'package:driveease_v1/Model/servico.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class BarChartMes extends StatelessWidget {
  BarChartMes(
      {super.key, required this.listCorridaMes, required this.listServicoMes});

  static Map<int, String> mapSemanasLucro = {};
  static Map<int, String> mapSemanasCorrida = {};
  static Map<int, String> mapSemanasServico = {};
  List<Corrida> listCorridaMes = [];
  List<Servico> listServicoMes = [];
  Mediator mediator = Mediator();
  double _lucro = 0;
  double _recebimento = 0;
  double _despesa = 0;
  Map<String, double> mapCorridaFiltrada = {};
  Map<String, double> mapServicoFiltrada = {};

  List<double> calculaLucroMes() {
    List<double> totaisPorDia = [];
    Map<String, double> somasDiarias = {};
    mapCorridaFiltrada.forEach(
      (data, valor1) {
        if (mapServicoFiltrada.containsKey(data)) {
          double valor2 = mapServicoFiltrada[data]!;
          double resultado = valor1 - valor2;
          somasDiarias[data] = resultado;
        } else {
          somasDiarias[data] = valor1;
        }
      },
    );
    int key = 0;
    somasDiarias.forEach((dia, soma) {
      BarChartMes.mapSemanasLucro[key] = dia;
      totaisPorDia.add(soma);
      key++;
    });
    print('Resultado: $somasDiarias');

    _lucro = totaisPorDia.fold(_lucro, (valorAtual, proximoValor) {
      return valorAtual > proximoValor ? valorAtual : proximoValor;
    });
    print('lucro $_lucro');
    return totaisPorDia;
  }

  List<double> calculaRecebidosMes() {
    List<double> totaisPorDia = [];
    Map<String, double?> somasDiarias = {};
    listCorridaMes.sort((a, b) => DateTime.parse(a.dataHoraStart)
        .compareTo(DateTime.parse(b.dataHoraStart)));

    for (Corrida objeto in listCorridaMes) {
      DateTime dataObjeto = DateTime.parse(objeto.dataHoraStart);
      String diaFormatado = DateFormat('dd/MM/yyyy').format(dataObjeto);
      somasDiarias[diaFormatado] =
          (somasDiarias[diaFormatado] ?? 0) + objeto.ganhos!;
    }
    int key = 0;
    somasDiarias.forEach((dia, soma) {
      mapCorridaFiltrada[dia] = soma!;
      BarChartMes.mapSemanasCorrida[key] = dia;
      key++;
      totaisPorDia.add(soma);
    });
    print('MAPA $mapCorridaFiltrada');
    _recebimento = totaisPorDia.fold(_recebimento, (valorAtual, proximoValor) {
      return valorAtual > proximoValor ? valorAtual : proximoValor;
    });
    print('HEY $_recebimento');
    return totaisPorDia;
  }

  List<double> calculaDespesasMes() {
    List<double> totaisPorDia = [];
    Map<String, double?> somasDiarias = {};
    listCorridaMes.sort((a, b) => DateTime.parse(a.dataHoraStart)
        .compareTo(DateTime.parse(b.dataHoraStart)));

    for (Servico objeto in listServicoMes) {
      DateTime dataObjeto = DateTime.parse(objeto.data);
      String diaFormatado = DateFormat('dd/MM/yyyy').format(dataObjeto);
      somasDiarias[diaFormatado] =
          (somasDiarias[diaFormatado] ?? 0) + objeto.valor;
    }
    int key = 0;
    somasDiarias.forEach((dia, soma) {
      mapServicoFiltrada[dia] = soma!;
      BarChartMes.mapSemanasServico[key] = dia;
      key++;
      totaisPorDia.add(soma);
    });
    _despesa = totaisPorDia.fold(_despesa, (valorAtual, proximoValor) {
      return valorAtual > proximoValor ? valorAtual : proximoValor;
    });
    print('despesas $_despesa');

    calculaLucroMes();
    return totaisPorDia;
  }

  @override
  Widget build(BuildContext context) {
    print('oi');
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
                    barGroups: calculaLucroMes()
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
                    barGroups: calculaRecebidosMes()
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
                    barGroups: calculaDespesasMes()
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
  print('Teste : ${BarChartMes.mapSemanasCorrida}');
  Map<int, String> mapFodac = BarChartMes.mapSemanasLucro;
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
    case 7:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[7]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 8:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[8]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 9:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[9]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 10:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[10]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 11:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[11]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 12:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[12]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 13:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[13]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 14:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[14]!);
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
  Map<int, String> mapFodac = BarChartMes.mapSemanasCorrida;
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
    case 7:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[7]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 8:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[8]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 9:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[9]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 10:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[10]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 11:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[11]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 12:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[12]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 13:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[13]!);
      String dataFormatada = DateFormat('dd/MM').format(data);
      text = Text(
        dataFormatada,
        style: style,
      );
      break;
    case 14:
      DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[14]!);
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
  Map<int, String> mapFodac = BarChartMes.mapSemanasServico;
  Widget? text;
  for (var i = 0; i == value.toInt(); i++) {
    DateTime data = DateFormat('dd/MM/yyyy').parse(mapFodac[value.toInt()]!);
    String dataFormatada = DateFormat('dd/MM').format(data);
    text = Text(
      dataFormatada,
      style: style,
    );
  }

  return SideTitleWidget(axisSide: meta.axisSide, child: text!);
}
