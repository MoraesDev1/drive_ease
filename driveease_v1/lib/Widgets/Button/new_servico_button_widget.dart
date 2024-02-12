import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class NewServicoButton extends StatefulWidget {
  NewServicoButton({super.key});

  @override
  State<NewServicoButton> createState() => _NewServicoButtonState();
}

const List<String> tipoDeServico = <String>[
  'Nenhum',
  'Troca de Óleo',
  'Manutenção',
  'Abastecimento',
  'Troca de Pneus',
  'Manutenção de Rotina',
  'Lavagem/Limpeza',
];

class _NewServicoButtonState extends State<NewServicoButton> {
  String tipoSelecionado = tipoDeServico.first;

  final TextEditingController _controllerQuilometragem =
      TextEditingController();

  final _formKeyStart = GlobalKey<FormState>();

  String? _validaQuilometragem(String? value) {}

  _clickSalvar() {}

  _getInfoServico() {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        content: SizedBox(
          child: Form(
            key: _formKeyStart,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Novo Serviço'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 2, bottom: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          underline: const Divider(
                            height: 0,
                            color: Colors.white,
                          ),
                          menuMaxHeight: 200,
                          value: tipoSelecionado,
                          icon: const Icon(Icons.arrow_drop_down),
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? value) {
                            setState(() {
                              tipoSelecionado = value!;
                            });
                          },
                          items: tipoDeServico
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    onFieldSubmitted: (value) => _clickSalvar(),
                    maxLength: 8,
                    validator: _validaQuilometragem,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    controller: _controllerQuilometragem,
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
                            backgroundColor: Utils.corPrimaria,
                          ),
                          child: const Text('Iniciar'),
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
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Utils.corPrimaria,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => _getInfoServico(),
              );
            },
            child: const Text('Novo Serviço'),
          ),
        ),
      ],
    );
  }
}
