import 'package:driveease_v1/Database/Dao/Impl/servico_dao_db.dart';
import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Model/servico.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  Mediator mediator = Mediator();
  ServicoDaoDb servicoDaoDb = ServicoDaoDb();
  String? tipoSelecionado;
  final _formKeyServico = GlobalKey<FormState>();
  final TextEditingController _controllerTipoDeServico =
      TextEditingController();
  final TextEditingController _controllerQuilometragem =
      TextEditingController();
  final TextEditingController _controllerDescricao = TextEditingController();
  final TextEditingController _controllerCusto = TextEditingController();

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
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  _esconderTeclado() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  _clickSalvar() {
    if (_formKeyServico.currentState!.validate()) {
      _formKeyServico.currentState!.save();
      _criarServico(_controllerCusto.text, _controllerQuilometragem.text,
          _controllerDescricao.text, tipoSelecionado!);
      setState(() {
        _controllerDescricao.clear();
        _controllerCusto.clear();
        _controllerQuilometragem.clear();
        _controllerTipoDeServico.clear();
      });
      Navigator.of(context).pop();
    }
  }

  _criarServico(String custo, String quilometragem, String descricao,
      String tipoDoServico) {
    double? quilometragemDouble = double.parse(quilometragem);
    double? custoDouble = double.parse(custo);
    DateTime dataAtual = DateTime.now();
    String dataFormatada = DateFormat('dd/MM/yyyy HH:mm:ss').format(dataAtual);
    Servico servicoCriado = Servico(
      tipoDoServico: tipoDoServico,
      data: dataFormatada,
      km: quilometragemDouble,
      descricao: descricao,
      valor: custoDouble,
    );
    _insereServicoNoBanco(servicoCriado);
  }

  _insereServicoNoBanco(Servico servico) async {
    servicoDaoDb.inserir(servico);
  }

  _getInfoServico() {
    return Center(
      child: GestureDetector(
        onTap: _esconderTeclado,
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
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            hintText: 'Nenhum',
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                          ),
                          validator: _validaTipo,
                          onChanged: (value) {
                            setState(() {
                              tipoSelecionado = value;
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
                          controller: _controllerCusto,
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
                                  backgroundColor: Utils.verdePrimario,
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
              backgroundColor: Utils.verdePrimario,
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
