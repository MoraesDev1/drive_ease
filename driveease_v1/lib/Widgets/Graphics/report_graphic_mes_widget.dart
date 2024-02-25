// import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
// import 'package:driveease_v1/Model/corrida.dart';
// import 'package:driveease_v1/Model/servico.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:intl/intl.dart';

// // ignore: must_be_immutable
// class BarChartMes extends StatelessWidget {
//   BarChartMes(
//       {super.key, required this.listCorridaMes, required this.listServicoMes});

//   Mediator mediator = Mediator();
//   List<Corrida> listCorridaMes;
//   List<Servico> listServicoMes;
//   double ganhoMaximoSemana = 0;
//   static Map<int, String> mapDiasDaSemana = {};

//   List<String> getLista() {
//     List<String> listaDias = [];

//     for (Corrida objeto in listCorridaMes) {
//       DateTime dataObjeto =
//           DateFormat('dd/MM/yyyy HH:mm:ss').parse(objeto.dataHoraStart);
//       String diaFormatado = DateFormat('dd/MM').format(dataObjeto);
//       listaDias.add(diaFormatado);
//     }
//     return listaDias;
//   }

//   List<double> calculaGanhosSemana() {
//     List<double> totaisPorDia = [];

//     Map<String, double?> somasDiarias = {};

//     listCorridaMes.sort((a, b) => DateTime.parse(a.dataHoraStart)
//         .compareTo(DateTime.parse(b.dataHoraStart)));

//     for (Corrida objeto in listCorridaMes) {
//       DateTime dataObjeto = DateTime.parse(objeto.dataHoraStart);
//       String diaFormatado = DateFormat('dd/MM/yyyy').format(dataObjeto);
//       somasDiarias[diaFormatado] =
//           (somasDiarias[diaFormatado] ?? 0) + objeto.ganhos!;
//     }
//     int key = 0;
//     somasDiarias.forEach((dia, soma) {
//       mapDiasDaSemana[key] = dia;
//       key++;
//       totaisPorDia.add(soma!);
//     });
//     ganhoMaximoSemana =
//         totaisPorDia.fold(ganhoMaximoSemana, (valorAtual, proximoValor) {
//       return valorAtual > proximoValor ? valorAtual : proximoValor;
//     });
//     print('HEY $ganhoMaximoSemana');
//     return totaisPorDia;
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(mapDiasDaSemana);
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: 200,
//             child: BarChart(
//               BarChartData(
//                 titlesData: const FlTitlesData(
//                     show: true,
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                     rightTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                     topTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                     bottomTitles: AxisTitles(
//                         sideTitles: SideTitles(
//                             showTitles: true, getTitlesWidget: diasDaSemana))),
//                 gridData: const FlGridData(show: false),
//                 borderData: FlBorderData(show: false),
//                 alignment: BarChartAlignment.spaceAround,
//                 maxY: ganhoMaximoSemana,
//                 barGroups: calculaGanhosSemana()
//                     .asMap()
//                     .entries
//                     .map((entry) => BarChartGroupData(
//                           x: entry.key,
//                           barRods: [
//                             BarChartRodData(
//                                 width: 45,
//                                 toY: entry.value,
//                                 color: Colors.green[600],
//                                 borderRadius: const BorderRadius.only(
//                                     topRight: Radius.circular(2),
//                                     topLeft: Radius.circular(2))),
//                           ],
//                         ))
//                     .toList(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget diasDaSemana(double value, TitleMeta meta) {
//   const style = TextStyle(
//     color: Colors.black,
//     fontWeight: FontWeight.bold,
//     fontSize: 10,
//   );
//   Map<int, String> mapFodac = BarChartMes.mapDiasDaSemana;

//   Widget text;
//   switch (value.toInt()) {
//     case 0:
//       text = Text(
//         '${mapFodac[0]}',
//         style: style,
//       );
//       break;
//     case 1:
//       text = Text(
//         '${mapFodac[1]}',
//         style: style,
//       );
//       break;
//     case 2:
//       text = Text(
//         '${mapFodac[2]}',
//         style: style,
//       );
//       break;
//     case 3:
//       text = Text(
//         '${mapFodac[3]}',
//         style: style,
//       );
//       break;
//     case 4:
//       text = Text(
//         '${mapFodac[4]}',
//         style: style,
//       );
//       break;
//     case 5:
//       text = Text(
//         '${mapFodac[5]}',
//         style: style,
//       );
//       break;
//     case 6:
//       text = Text(
//         '${mapFodac[6]}',
//         style: style,
//       );
//       break;
//     default:
//       text = const Text('');
//       break;
//   }
//   return SideTitleWidget(axisSide: meta.axisSide, child: text);
// }
