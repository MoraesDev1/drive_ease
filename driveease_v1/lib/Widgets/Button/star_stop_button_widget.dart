import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class StartStopButton extends StatefulWidget {
  const StartStopButton({super.key});

  @override
  State<StartStopButton> createState() => _StartStopButtonState();
}

class _StartStopButtonState extends State<StartStopButton> {
  bool start = true;
  double sizeButton = 90;
  final TextEditingController _controllerQuilometragemStart =
      TextEditingController();
  final _formKeyStart = GlobalKey<FormState>();
  final _formKeyStop = GlobalKey<FormState>();
  final TextEditingController _controllerQuilometragem =
      TextEditingController();
  final TextEditingController _controllerGanhos = TextEditingController();

  String completarZeros(String numero, int comprimento) {
    int zerosNecessarios = comprimento - numero.length;

    if (zerosNecessarios <= 0) {
      return '';
    } else {
      return '0' * zerosNecessarios + numero;
    }
  }

  String? _validaQuilometragem(String? value) {
    if (value != null && value.isEmpty) {
      return 'Campo inválido';
    }
  }

  _criaCorrida(String quilometragem) {
    quilometragem.trim().replaceAll(',', '.').replaceAll('-', '');
  }

  var maskFormatter = MaskTextInputFormatter(
    mask: '######.#',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

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
                  onChanged: (value) {
                    String stringAlterada = completarZeros(value, 7);
                    if (stringAlterada != '') {
                      setState(() {
                        _controllerQuilometragemStart.text = stringAlterada;
                      });
                    }
                  },
                  textDirection: TextDirection.rtl,
                  validator: _validaQuilometragem,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  controller: _controllerQuilometragemStart,
                  inputFormatters: [maskFormatter],
                  decoration: const InputDecoration(
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
                          backgroundColor: Utils.corPrimaria,
                        ),
                        child: const Text('Iniciar'),
                        onPressed: () {
                          if (_formKeyStart.currentState!.validate()) {
                            _formKeyStart.currentState!.save();
                            _criaCorrida(_controllerQuilometragemStart.text);
                            Navigator.of(context).pop();
                            setState(() {
                              start = !start;
                            });
                          }
                        },
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
                child: Text('Inicie sua corrida'),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  inputFormatters: [maskFormatter],
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  controller: _controllerQuilometragem,
                  decoration: const InputDecoration(
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
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  controller: _controllerGanhos,
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
                          backgroundColor: Utils.corPrimaria,
                        ),
                        child: const Text('Encerrar'),
                        onPressed: () {
                          if (_formKeyStop.currentState!.validate()) {
                            _formKeyStop.currentState!.save();
                            Navigator.of(context).pop();
                            setState(() {
                              start = !start;
                            });
                          }
                        },
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
