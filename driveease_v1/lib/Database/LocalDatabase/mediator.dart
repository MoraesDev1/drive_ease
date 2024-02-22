import 'package:driveease_v1/Database/Dao/Impl/corrida_dao_db.dart';
import 'package:driveease_v1/Database/Dao/Impl/servico_dao_db.dart';
import 'package:driveease_v1/Model/corrida.dart';
import 'package:driveease_v1/Model/metas.dart';
import 'package:driveease_v1/Model/servico.dart';
import 'package:sqflite/sqflite.dart';

class Mediator {
  Mediator._privateConstructor();
  late Database db;
  // final CorridaDaoDb _corridaDaoDb = CorridaDaoDb();
  // final ServicoDaoDb _servicoDaoDb = ServicoDaoDb();
  List<Corrida> listaCorridaStart = [];
  List<Corrida> listaDeCorridas = [];
  List<Servico> listaDeServicos = [];
  List<Meta> listaDeMetas = [];

  List<Corrida> listCorridaDia = [];
  List<Servico> listServicoDia = [];
  List<Corrida> listCorridaSemana = [];
  List<Servico> listServicoSemana = [];
  List<Corrida> listCorridaMes = [];
  List<Servico> listServicoMes = [];

  static final Mediator _instance = Mediator._privateConstructor();

  factory Mediator() {
    return _instance;
  }

  carregaListas() async {
    // listaDeCorridas = await _corridaDaoDb.listar();
    // listaDeServicos = await _servicoDaoDb.listar();
  }

  buscarCorridaStart() async {
    final List<Map<String, dynamic>> result = await db.query('start');
    listaCorridaStart = result.map((e) => Corrida.fromMapStart(e)).toList();
  }

  limparStart() async {
    await db.delete('start');
    listaCorridaStart.clear();
  }

  // List<dynamic> filtrarSemana(DateTime selectedDate) {
  //   String dataFormatada =
  //       DateFormat('dd/MM/yyyy HH:mm:ss').format(selectedDate);
  //   DateTime dataConvertida = DateTime.parse(dataFormatada);
  //   final firstDayOfWeek =
  //       dataConvertida.subtract(Duration(days: dataConvertida.weekday - 1));
  //   final lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));

  //   return mediator.listaDeCorridas.where((corrida) {
  //     DateTime itemDate = DateTime.parse(corrida.dataHoraStart);
  //     return itemDate.isAfter(firstDayOfWeek) &&
  //         itemDate.isBefore(lastDayOfWeek);
  //   }).toList();
  // }

  // List<Corrida> _filtrarCorridaMes(DateTime selectedDate) {
  //   return mediator.listaDeCorridas.where((corrida) {
  //     DateTime converterStringParaDateTime(String stringDataHora) {
  //       List<String> partes = stringDataHora.split(' ');
  //       List<String> partesData = partes[0].split('/');
  //       List<String> partesHora = partes[1].split(':');
  //       DateTime dataHoraObjeto = DateTime(
  //         int.parse(partesData[2]), // ano
  //         int.parse(partesData[1]), // mês
  //         int.parse(partesData[0]), // dia
  //         int.parse(partesHora[0]), // hora
  //         int.parse(partesHora[1]), // minuto
  //         int.parse(partesHora[2]), // segundo
  //       );
  //       return dataHoraObjeto;
  //     }

  //     DateTime itemDate = converterStringParaDateTime(corrida.dataHoraStart);
  //     return itemDate.month == selectedDate.month &&
  //         itemDate.year == selectedDate.year;
  //   }).toList();
  // }

  // List<Servico> _filtrarServicoMes(DateTime selectedDate) {
  //   return mediator.listaDeServicos.where((servico) {
  //     DateTime converterStringParaDateTime(String stringDataHora) {
  //       List<String> partes = stringDataHora.split(' ');
  //       List<String> partesData = partes[0].split('/');
  //       List<String> partesHora = partes[1].split(':');
  //       DateTime dataHoraObjeto = DateTime(
  //         int.parse(partesData[2]), // ano
  //         int.parse(partesData[1]), // mês
  //         int.parse(partesData[0]), // dia
  //         int.parse(partesHora[0]), // hora
  //         int.parse(partesHora[1]), // minuto
  //         int.parse(partesHora[2]), // segundo
  //       );
  //       return dataHoraObjeto;
  //     }

  //     DateTime itemDate = converterStringParaDateTime(servico.data);
  //     return itemDate.month == selectedDate.month &&
  //         itemDate.year == selectedDate.year;
  //   }).toList();
  // }

  // List<Corrida> _filtrarCorridaSemana(DateTime selectedDate) {
  //   final firstDayOfWeek =
  //       selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
  //   final lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 7));
  //   return mediator.listaDeCorridas.where((corrida) {
  //     DateTime converterStringParaDateTime(String stringDataHora) {
  //       List<String> partes = stringDataHora.split(' ');
  //       List<String> partesData = partes[0].split('/');
  //       List<String> partesHora = partes[1].split(':');
  //       DateTime dataHoraObjeto = DateTime(
  //         int.parse(partesData[2]), // ano
  //         int.parse(partesData[1]), // mês
  //         int.parse(partesData[0]), // dia
  //         int.parse(partesHora[0]), // hora
  //         int.parse(partesHora[1]), // minuto
  //         int.parse(partesHora[2]), // segundo
  //       );
  //       return dataHoraObjeto;
  //     }

  //     DateTime itemDate = converterStringParaDateTime(corrida.dataHoraStart);

  //     return itemDate.isAfter(firstDayOfWeek) &&
  //         itemDate.isBefore(lastDayOfWeek);
  //   }).toList();
  // }

  // List<Servico> _filtrarServicoSemana(DateTime selectedDate) {
  //   final firstDayOfWeek =
  //       selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
  //   final lastDayOfWeek = firstDayOfWeek.add(Duration(days: 7));

  //   return mediator.listaDeServicos.where((servico) {
  //     DateTime converterStringParaDateTime(String stringDataHora) {
  //       List<String> partes = stringDataHora.split(' ');
  //       List<String> partesData = partes[0].split('/');
  //       List<String> partesHora = partes[1].split(':');
  //       DateTime dataHoraObjeto = DateTime(
  //         int.parse(partesData[2]), // ano
  //         int.parse(partesData[1]), // mês
  //         int.parse(partesData[0]), // dia
  //         int.parse(partesHora[0]), // hora
  //         int.parse(partesHora[1]), // minuto
  //         int.parse(partesHora[2]), // segundo
  //       );
  //       return dataHoraObjeto;
  //     }

  //     DateTime itemDate = converterStringParaDateTime(servico.data);

  //     return itemDate.isAfter(firstDayOfWeek) &&
  //         itemDate.isBefore(lastDayOfWeek);
  //   }).toList();
  // }

  // List<Corrida> _filtrarCorridaDia(DateTime selectedDate) {
  //   return mediator.listaDeCorridas.where((corrida) {
  //     DateTime converterStringParaDateTime(String stringDataHora) {
  //       List<String> partes = stringDataHora.split(' ');
  //       List<String> partesData = partes[0].split('/');
  //       List<String> partesHora = partes[1].split(':');
  //       DateTime dataHoraObjeto = DateTime(
  //         int.parse(partesData[2]), // ano
  //         int.parse(partesData[1]), // mês
  //         int.parse(partesData[0]), // dia
  //         int.parse(partesHora[0]), // hora
  //         int.parse(partesHora[1]), // minuto
  //         int.parse(partesHora[2]), // segundo
  //       );
  //       return dataHoraObjeto;
  //     }

  //     DateTime itemDate = converterStringParaDateTime(corrida.dataHoraStart);

  //     return itemDate.day == selectedDate.day;
  //   }).toList();
  // }

  // List<Servico> _filtrarServicoDia(DateTime selectedDate) {
  //   return mediator.listaDeServicos.where((servico) {
  //     DateTime converterStringParaDateTime(String stringDataHora) {
  //       List<String> partes = stringDataHora.split(' ');
  //       List<String> partesData = partes[0].split('/');
  //       List<String> partesHora = partes[1].split(':');
  //       DateTime dataHoraObjeto = DateTime(
  //         int.parse(partesData[2]), // ano
  //         int.parse(partesData[1]), // mês
  //         int.parse(partesData[0]), // dia
  //         int.parse(partesHora[0]), // hora
  //         int.parse(partesHora[1]), // minuto
  //         int.parse(partesHora[2]), // segundo
  //       );
  //       return dataHoraObjeto;
  //     }

  //     DateTime itemDate = converterStringParaDateTime(servico.data);

  //     return itemDate.day == selectedDate.day;
  //   }).toList();
  // }
}
