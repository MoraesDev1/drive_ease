import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';

class NewServicoButton extends StatefulWidget {
  const NewServicoButton({super.key});

  @override
  State<NewServicoButton> createState() => _NewServicoButtonState();
}

const List<String> tipoDeServico = <String>[
  'Troca de Óleo',
  'Manutenção',
  'Abastecimento',
  'Troca de Pneus',
  'Manutenção de Rotina',
  'Lavagem/Limpeza',
];

class _NewServicoButtonState extends State<NewServicoButton> {
  final _formKeyServico = GlobalKey<FormState>();
  final TextEditingController _controllerTipoDeServico =
      TextEditingController(text: 'Nenhum');
  final TextEditingController _controllerQuilometragem =
      TextEditingController();
  final TextEditingController _controllerGanhos = TextEditingController();
  final TextEditingController _controllerDescricao = TextEditingController();
  bool validado = false;

  String? _validaQuilometragem(String? value) {
    RegExp regex = RegExp(r'^[0-9]{0,6}\.[0-9]$');

    if (value != null && value.isEmpty) {
      return 'Campo obrigatório';
    } else if (!regex.hasMatch(value!)) {
      return 'Preenchimento incorreto!\nA forma correta é 000000.0';
    }
    return null;
  }

  String? _validaCusto(String? value) {
    String? entrada = value!.replaceAll(',', '.');
    RegExp regex = RegExp(r'^\d*\.\d{2}$');

    if (value.isEmpty) {
      return 'Campo obrigatório';
    } else if (!regex.hasMatch(entrada)) {
      return 'Preenchimento incorreto!\nA forma correta é 0000,00';
    }
    return null;
  }

  String? _validaTipo(String? value) {
    if (value!.isEmpty || value == 'Nenhum') {
      return 'Campo obrigatório';
    }
    return null;
  }

  _clickSalvar() {
    if (_formKeyServico.currentState!.validate()) {
      _formKeyServico.currentState!.save();
      String? retornoValidacao = _validaTipo(_controllerTipoDeServico.text);
      if (retornoValidacao == null) {
        _controllerTipoDeServico.text = 'Nenhum';
        validado = false;
        setState(() {
          _controllerDescricao.clear();
          _controllerGanhos.clear();
          _controllerQuilometragem.clear();
        });
        Navigator.of(context).pop();
      } else {
        validado = true;
      }
    }
  }

  _getInfoServico() {
    return Center(
      child: SingleChildScrollView(
        child: StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: SizedBox(
              child: Form(
                key: _formKeyServico,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Novo Serviço'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: DropdownMenu<String>(
                        controller: _controllerTipoDeServico,
                        errorText: validado
                            ? _validaTipo(_controllerTipoDeServico.text)
                            : null,
                        onSelected: (value) {
                          setState(() {
                            validado = !validado;
                          });
                        },
                        dropdownMenuEntries: tipoDeServico
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                            value: value,
                            label: value,
                          );
                        }).toList(),
                      ),
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
                      child: TextFormField(
                        maxLength: 10,
                        controller: _controllerGanhos,
                        validator: _validaCusto,
                        onFieldSubmitted: (value) => _clickSalvar(),
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          counterText: '',
                          label: Text(
                            'Custo',
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
                      child: Expanded(
                        child: TextFormField(
                          maxLines: null,
                          onFieldSubmitted: (value) => _clickSalvar(),
                          cursorColor: Colors.black,
                          controller: _controllerDescricao,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            hintText: 'Descreva o servico realizado',
                            label: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Descrição',
                                style: TextStyle(color: Colors.black),
                              ),
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
                              child: const Text('Criar Serviço'),
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
        }),
      ),
    );
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
