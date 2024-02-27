import 'package:driveease_v1/Model/corrida.dart';
import 'package:driveease_v1/Model/metas.dart';
import 'package:driveease_v1/Model/servico.dart';
import 'package:sqflite/sqflite.dart';

class Mediator {
  Mediator._privateConstructor();
  late Database db;
  List<Corrida> listaCorridaStart = [];
  List<Corrida> listaDeCorridas = [];
  List<Servico> listaDeServicos = [];
  List<Meta> listaDeMetas = [];

  static final Mediator _instance = Mediator._privateConstructor();

  factory Mediator() {
    return _instance;
  }

  buscarCorridaStart() async {
    final List<Map<String, dynamic>> result = await db.query('start');
    listaCorridaStart = result.map((e) => Corrida.fromMapStart(e)).toList();
  }

  limparStart() async {
    await db.delete('start');
    listaCorridaStart.clear();
  }

  ordenaLista() {
    listaDeCorridas.sort(
      (a, b) {
        DateTime primeiraData = DateTime.parse(a.dataHoraStart);
        DateTime segundaData = DateTime.parse(b.dataHoraStart);
        return segundaData.compareTo(primeiraData);
      },
    );

    listaDeServicos.sort(
      (a, b) {
        DateTime primeiraData = DateTime.parse(a.data);
        DateTime segundaData = DateTime.parse(b.data);
        return segundaData.compareTo(primeiraData);
      },
    );
  }

  double calculaRecebimentosHoje() {
    double recebimentoHoje = 0;
    listaDeCorridas.forEach(
      (corrida) {
        DateTime dataCorrida = DateTime.parse(corrida.dataHoraStart);
        DateTime dataAtual = DateTime.now();
        if (dataCorrida.year == dataAtual.year &&
            dataCorrida.month == dataAtual.month &&
            dataCorrida.day == dataAtual.day) {
          recebimentoHoje += corrida.ganhos!;
        }
      },
    );
    return recebimentoHoje;
  }

  double calculaCustoHoje() {
    double custoHoje = 0;
    listaDeServicos.forEach(
      (servico) {
        DateTime dataServico = DateTime.parse(servico.data);
        DateTime dataAtual = DateTime.now();
        if (dataServico.year == dataAtual.year &&
            dataServico.month == dataAtual.month &&
            dataServico.day == dataAtual.day) {
          custoHoje += servico.valor;
        }
      },
    );
    return custoHoje;
  }

  double calculaRecebimentosDestaSemana() {
    DateTime dataAtual = DateTime.now();
    double recebimentosSemana = 0;
    final firstDayOfWeek =
        dataAtual.subtract(Duration(days: dataAtual.weekday - 1));
    final lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 7));
    listaDeCorridas.forEach(
      (corrida) {
        DateTime dataServico = DateTime.parse(corrida.dataHoraStart);
        if (dataServico.isAfter(firstDayOfWeek) &&
            dataServico.isBefore(lastDayOfWeek)) {
          recebimentosSemana += corrida.ganhos!;
        }
      },
    );
    return recebimentosSemana;
  }

  double calculaCustoDestaSemana() {
    DateTime dataAtual = DateTime.now();
    double custoSemana = 0;
    final firstDayOfWeek =
        dataAtual.subtract(Duration(days: dataAtual.weekday - 1));
    final lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 7));
    listaDeServicos.forEach(
      (servico) {
        DateTime dataServico = DateTime.parse(servico.data);
        if (dataServico.isAfter(firstDayOfWeek) &&
            dataServico.isBefore(lastDayOfWeek)) {
          custoSemana += servico.valor;
        }
      },
    );
    return custoSemana;
  }

  double calculaRecebimentosDesteMes() {
    DateTime dataAtual = DateTime.now();
    double recebimentosMes = 0;
    listaDeCorridas.forEach(
      (corrida) {
        DateTime dataServico = DateTime.parse(corrida.dataHoraStart);
        if (dataServico.month == dataAtual.month &&
            dataServico.year == dataAtual.year) {
          recebimentosMes += corrida.ganhos!;
        }
      },
    );
    return recebimentosMes;
  }

  double calculaCustoDesteMes() {
    DateTime dataAtual = DateTime.now();
    double custoMes = 0;
    listaDeServicos.forEach(
      (servico) {
        DateTime dataServico = DateTime.parse(servico.data);
        if (dataServico.month == dataAtual.month &&
            dataServico.year == dataAtual.year) {
          custoMes += servico.valor;
        }
      },
    );
    return custoMes;
  }
}
