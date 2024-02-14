import 'package:driveease_v1/Database/Dao/Impl/corrida_dao_db.dart';
import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Model/corrida.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StartStopButton extends StatefulWidget {
  const StartStopButton({super.key});

  @override
  State<StartStopButton> createState() => _StartStopButtonState();
}

class _StartStopButtonState extends State<StartStopButton> {
  CorridaDaoDb corridaDaoDb = CorridaDaoDb();
  Mediator mediator = Mediator();
  bool start = true;
  double sizeButton = 90;
  final _formKeyStart = GlobalKey<FormState>();
  final _formKeyStop = GlobalKey<FormState>();
  final _controllerQuilometragemStart = TextEditingController();
  final _controllerQuilometragemStop = TextEditingController();
  final _controllerGanhos = TextEditingController();

  @override
  initState() {
    super.initState();
    _alteraEstadoBotao();
  }

  _alteraEstadoBotao() {
    setState(() {
      if (mediator.listaCorridaStart.isEmpty) {
        start = true;
      } else {
        start = false;
      }
    });
  }

  String? _validaQuilometragemStart(String? value) {
    RegExp regex = RegExp(r'^[0-9]{0,6}\.[0-9]$');

    if (value != null && value.isEmpty) {
      return 'Campo obrigatório';
    } else if (!regex.hasMatch(value!)) {
      return 'Preenchimento incorreto!\nA forma correta é 000000.0';
    }
    return null;
  }

  String? _validaQuilometragemStop(String? value) {
    RegExp regex = RegExp(r'^[0-9]{0,6}\.[0-9]$');
    double? stopKmDouble = double.parse(_controllerQuilometragemStop.text);

    if (value != null && value.isEmpty) {
      return 'Campo obrigatório';
    } else if (!regex.hasMatch(value!)) {
      return 'Preenchimento incorreto!\nA forma correta é 000000.0';
    } else if (mediator.listaCorridaStart[0].startKm > stopKmDouble) {
      return 'A quilometragem final deve ser \nmaior que a inicial.';
    }
    return null;
  }

  String? _validaGanhos(String? value) {
    String? entrada = value!.replaceAll(',', '.');
    RegExp regex = RegExp(r'^\d*\.\d{2}$');

    if (value.isEmpty) {
      return 'Campo obrigatório';
    } else if (!regex.hasMatch(entrada)) {
      return 'Preenchimento incorreto!\nA forma correta é 0000,00';
    }
    return null;
  }

  _criaCorridaStart(String quilometragem) {
    double? quilometragemDouble = double.parse(quilometragem);
    DateTime dataAtual = DateTime.now();
    String dataFormatada = DateFormat('dd/MM/yyyy HH:mm:ss').format(dataAtual);
    Corrida corridaStart = Corrida.start(
      dataHoraStart: dataFormatada,
      startKm: quilometragemDouble,
    );
    corridaDaoDb
        .inserirStart(corridaStart)
        .then((value) => mediator.listaCorridaStart.add(value));
  }

  _criaCorridaStop(String stopKm, String ganhos) {
    String ganhosFormatada = ganhos.replaceAll(',', '.');
    double? ganhosDouble = double.parse(ganhosFormatada);
    double? stopKmDouble = double.parse(stopKm);
    DateTime dataAtual = DateTime.now();
    String dataFormatada = DateFormat('dd/MM/yyyy HH:mm:ss').format(dataAtual);
    Corrida corridaStop = Corrida.stop(
      dataHoraStart: mediator.listaCorridaStart[0].dataHoraStart,
      startKm: mediator.listaCorridaStart[0].startKm,
      dataHoraStop: dataFormatada,
      stopKm: stopKmDouble,
      ganhos: ganhosDouble,
    );
    insereCorridaNoBanco(corridaStop);
  }

  insereCorridaNoBanco(Corrida corrida) async {
    Corrida corridaInserida = await corridaDaoDb.inserirStop(corrida);

    if (corridaInserida.id! > 0) {
      mediator.limparStart();
      //mediator._listaDeCorridas.add(corridaInserida); validar se não é feito automaticamente no listar
    }
  }

  _clickIniciar() {
    if (_formKeyStart.currentState!.validate()) {
      _formKeyStart.currentState!.save();

      _criaCorridaStart(_controllerQuilometragemStart.text);

      mediator.buscarCorridaStart();

      setState(() {
        start = !start;
        _controllerQuilometragemStart.clear();
      });
      Navigator.of(context).pop();
    }
  }

  _clickEncerrar() {
    if (_formKeyStop.currentState!.validate()) {
      _formKeyStop.currentState!.save();

      mediator.buscarCorridaStart();

      _criaCorridaStop(
          _controllerQuilometragemStop.text, _controllerGanhos.text);
      setState(() {
        start = !start;
        _controllerQuilometragemStop.clear();
        _controllerGanhos.clear();
      });
      Navigator.of(context).pop();
    }
  }

  _getInfoStart() {
    return AlertDialog(
      content: SizedBox(
        child: Form(
          key: _formKeyStart,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text('Inicie sua corrida'),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  onFieldSubmitted: (value) => _clickIniciar(),
                  maxLength: 8,
                  validator: _validaQuilometragemStart,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  controller: _controllerQuilometragemStart,
                  decoration: const InputDecoration(
                    counterText: '',
                    hintText: 'Ex: 000000.0',
                    label: Text(
                      'Quilometragem atual',
                      style: TextStyle(color: Colors.black),
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    suffixText: 'Km',
                    suffixStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Utils.verdePrimario,
                        ),
                        child: const Text('Iniciar'),
                        onPressed: () => _clickIniciar(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getInfoStop() {
    return AlertDialog(
      content: SizedBox(
        child: Form(
          key: _formKeyStop,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8),
                child: Text('Encerre sua corrida'),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  maxLength: 8,
                  validator: _validaQuilometragemStop,
                  onFieldSubmitted: (value) => _clickEncerrar(),
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  controller: _controllerQuilometragemStop,
                  decoration: const InputDecoration(
                    counterText: '',
                    label: Text(
                      'Quilometragem atual',
                      style: TextStyle(color: Colors.black),
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    suffixText: 'Km',
                    suffixStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _controllerGanhos,
                  validator: _validaGanhos,
                  onFieldSubmitted: (value) => _clickEncerrar(),
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text(
                      'Ganhos',
                      style: TextStyle(color: Colors.black),
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    prefixText: 'R\$',
                    prefixStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Utils.verdePrimario,
                        ),
                        child: const Text('Encerrar'),
                        onPressed: () => _clickEncerrar(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: start ? Colors.green.shade500 : Colors.red.shade500,
          fixedSize: Size(sizeButton, sizeButton),
          shape: const CircleBorder(),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => start ? _getInfoStart() : _getInfoStop(),
          );
        },
        child: Text(start ? 'Start' : 'Stop'),
      ),
    );
  }
}
