import 'package:driveease_v1/Database/Dao/Impl/corrida_dao_db.dart';
import 'package:driveease_v1/Model/corrida.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditCorridaPage extends StatefulWidget {
  const EditCorridaPage({super.key, required this.corrida});
  final Corrida corrida;

  @override
  State<EditCorridaPage> createState() => _EditCorridaPageState();
}

class _EditCorridaPageState extends State<EditCorridaPage> {
  CorridaDaoDb corridaDaoDb = CorridaDaoDb();
  final _controllerDataInicial = TextEditingController();
  final _controllerQuilometrageminicial = TextEditingController();
  final _controllerDataFinal = TextEditingController();
  final _controllerQuilometragemFinal = TextEditingController();
  final _controllerGanhos = TextEditingController();
  final _formKeyCorrida = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controllerDataInicial.text = widget.corrida.dataHoraStart;
    _controllerQuilometrageminicial.text = widget.corrida.startKm.toString();
    _controllerDataFinal.text = widget.corrida.dataHoraStop!;
    _controllerQuilometragemFinal.text = widget.corrida.stopKm.toString();
    _controllerGanhos.text = widget.corrida.ganhos.toString();
  }

  String? _validaGanhos(String? value) {
    String? entrada = value!.replaceAll(',', '.');
    RegExp regex = RegExp(r'^\d*\.?\d*$');

    if (value.isEmpty) {
      return 'Campo obrigatório';
    } else if (!regex.hasMatch(entrada)) {
      return 'Preenchimento incorreto!\nA forma correta é 0000,00';
    }
    return null;
  }

  String? _validaQuilometragemInicio(String? value) {
    RegExp regex = RegExp(r'^[0-9]{0,6}\.?[0-9]*$');

    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    } else if (!regex.hasMatch(value)) {
      return 'Preenchimento incorreto!\nA forma correta é 000000.0';
    }
    return null;
  }

  String? _validaQuilometragemFinal(String? value) {
    RegExp regex = RegExp(r'^[0-9]{0,6}\.[0-9]$');
    double startKm = double.parse(_controllerQuilometrageminicial.text);
    double stopKm = double.parse(_controllerQuilometragemFinal.text);

    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    } else if (!regex.hasMatch(value)) {
      return 'Preenchimento incorreto!\nA forma correta é 000000.0';
    } else if (startKm > stopKm) {
      return 'A quilometragem final deve ser \nmaior que a inicial.';
    }
    return null;
  }

  _substiuiCorrida() {
    String ganhosFormatada = _controllerGanhos.text.replaceAll(',', '.');
    double? ganhosDouble = double.parse(ganhosFormatada);

    double? startKmDouble = double.parse(_controllerQuilometrageminicial.text);
    double? stopKmDouble = double.parse(_controllerQuilometragemFinal.text);

    Corrida corridaAlterada = Corrida.stop(
      id: widget.corrida.id,
      dataHoraStart: _controllerDataInicial.text,
      startKm: startKmDouble,
      dataHoraStop: _controllerDataFinal.text,
      stopKm: stopKmDouble,
      ganhos: ganhosDouble,
    );
    _atualizaNoBanco(corridaAlterada);
  }

  _atualizaNoBanco(Corrida corridaAlterada) {
    corridaDaoDb.editar(corridaAlterada).then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Corrida atualizada!'),
              backgroundColor: Colors.grey,
              duration: Duration(seconds: 3),
            ),
          ),
        );
  }

  _clickSalvar() {
    if (_formKeyCorrida.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Salvar as alterações?'),
          content:
              const Text('Tem certeza que deseja salvar todas as alterações?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancelar')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  _substiuiCorrida();
                },
                child: const Text('Salvar')),
          ],
        ),
      );
    }
  }

  _esconderTeclado() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  _selecionarDatainicial() async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2050),
    ).then(
      (selectedDate) {
        if (selectedDate != null) {
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          ).then(
            (selectedTime) {
              if (selectedTime != null) {
                DateTime selectedDateTime = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );
                String dataFormatada =
                    DateFormat('dd/MM/yyyy HH:mm:ss').format(selectedDateTime);
                setState(() {
                  _controllerDataInicial.text = dataFormatada;
                });
              }
            },
          );
        }
      },
    );
  }

  _selecionarDataFinal() async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ).then(
      (selectedDate) {
        if (selectedDate != null) {
          showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          ).then(
            (selectedTime) {
              if (selectedTime != null) {
                DateTime selectedDateTime = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );
                String dataFormatada =
                    DateFormat('dd/MM/yyyy HH:mm:ss').format(selectedDateTime);
                setState(() {
                  _controllerDataFinal.text = dataFormatada;
                });
              }
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar corrida'),
        backgroundColor: Utils.verdePrimario,
      ),
      backgroundColor: Utils.corFundo,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKeyCorrida,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      readOnly: true,
                      onTap: () => _selecionarDatainicial(),
                      onFieldSubmitted: (value) => _clickSalvar(),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      controller: _controllerDataInicial,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.calendar_month,
                          color: Colors.black,
                        ),
                        label: Text(
                          'Data Inicial',
                          style: TextStyle(color: Colors.black),
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      onTapOutside: (event) => _esconderTeclado,
                      maxLength: 8,
                      validator: _validaQuilometragemInicio,
                      onFieldSubmitted: (value) => _clickSalvar(),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      controller: _controllerQuilometrageminicial,
                      decoration: const InputDecoration(
                        counterText: '',
                        label: Text(
                          'Quilometragem Inicial',
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
                      readOnly: true,
                      onTap: () => _selecionarDataFinal(),
                      onFieldSubmitted: (value) => _clickSalvar(),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      controller: _controllerDataFinal,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.calendar_month,
                          color: Colors.black,
                        ),
                        label: Text(
                          'Data Final',
                          style: TextStyle(color: Colors.black),
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      onTapOutside: (event) => _esconderTeclado,
                      maxLength: 8,
                      validator: _validaQuilometragemFinal,
                      onFieldSubmitted: (value) => _clickSalvar(),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      controller: _controllerQuilometragemFinal,
                      decoration: const InputDecoration(
                        counterText: '',
                        label: Text(
                          'Quilometragem Final',
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
                      onTapOutside: (event) => _esconderTeclado,
                      controller: _controllerGanhos,
                      validator: _validaGanhos,
                      onFieldSubmitted: (value) => _clickSalvar(),
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
                            child: const Text('Salvar Alterações'),
                            onPressed: () => _clickSalvar(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
