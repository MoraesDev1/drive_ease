import 'package:driveease_v1/Model/corrida.dart';
import 'package:driveease_v1/Model/servico.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartSemana extends StatelessWidget {
  BarChartSemana(
      {required this.listCorridaSemana, required this.listServicoSemana});
  List<Corrida> listCorridaSemana = [];
  List<Servico> listServicoSemana = [];
  final List<double> ganhos = [100.0, 150.0, 200.0, 120.0, 180.0, 25, 45];

  List<double> calculaGanhosSemana() {
    List<double> seg = [];
    List<double> ter = [];
    List<double> qua = [];
    List<double> qui = [];
    List<double> sex = [];
    List<double> sab = [];
    List<double> dom = [];
    List<double> totaisPorDia = [];

    for (var i in listCorridaSemana) {}

    return totaisPorDia;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
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
                            showTitles: true, getTitlesWidget: diasDaSemana))),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                alignment: BarChartAlignment.spaceAround,
                maxY: 400,
                barGroups: calculaGanhosSemana()
                    .asMap()
                    .entries
                    .map((entry) => BarChartGroupData(
                          x: entry.key,
                          barRods: [
                            BarChartRodData(
                                width: 45,
                                toY: entry.value,
                                color: Colors.green[600],
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
    );
  }
}

Widget diasDaSemana(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 10,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        'Seg',
        style: style,
      );
      break;
    case 1:
      text = const Text(
        'Ter',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'Qua',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'Qui',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'Sex',
        style: style,
      );
      break;
    case 5:
      text = const Text(
        'Sab',
        style: style,
      );
      break;
    case 6:
      text = const Text(
        'Dom',
        style: style,
      );
      break;
    default:
      text = const Text('');
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
