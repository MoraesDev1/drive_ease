import 'package:driveease_v1/Database/Dao/Impl/servico_dao_db.dart';
import 'package:driveease_v1/Model/servico.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditServicoPage extends StatefulWidget {
  const EditServicoPage({super.key, required this.servico});
  final Servico servico;

  @override
  State<EditServicoPage> createState() => _EditServicoPageState();
}

const List<String> tipoDeServico = <String>[
  'Troca de Óleo',
  'Manutenção',
  'Abastecimento',
  'Troca de Pneus',
  'Manutenção de Rotina',
  'Lavagem/Limpeza',
];

class _EditServicoPageState extends State<EditServicoPage> {
  ServicoDaoDb servicoDaoDb = ServicoDaoDb();
  String? tipoSelecionado;
  late DateTime dataSelecionada;
  final _controllerDataDoServico = TextEditingController();
  final _controllerQuilometragem = TextEditingController();
  final _controllerDescricao = TextEditingController();
  final _controllerCusto = TextEditingController();
  final _formKeyServico = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controllerDataDoServico.text = widget.servico.data;
    tipoSelecionado = widget.servico.tipoDoServico;
    _controllerQuilometragem.text = widget.servico.km.toString();
    _controllerDescricao.text = widget.servico.descricao;
    _controllerCusto.text = widget.servico.valor.toString();
    _formataData();
  }

  String? _validaCusto(String? value) {
    String? entrada = value!.replaceAll(',', '.');
    RegExp regex = RegExp(r'^\d*\.?\d*$');

    if (value.isEmpty) {
      return 'Campo obrigatório';
    } else if (!regex.hasMatch(entrada)) {
      return 'Preenchimento incorreto!\nA forma correta é 0000,00';
    }
    return null;
  }

  String? _validaQuilometragem(String? value) {
    RegExp regex = RegExp(r'^[0-9]{0,6}\.?[0-9]*$');

    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    } else if (!regex.hasMatch(value)) {
      return 'Preenchimento incorreto!\nA forma correta é 000000.0';
    }
    return null;
  }

  _substiuiServico() {
    String custoFormatado = _controllerCusto.text.replaceAll(',', '.');
    double? custoDouble = double.parse(custoFormatado);
    double? quilometragemDouble = double.parse(_controllerQuilometragem.text);
    Servico servicoAlterado = Servico(
      id: widget.servico.id,
      tipoDoServico: tipoSelecionado!,
      data: dataSelecionada.toString(),
      km: quilometragemDouble,
      descricao: _controllerDescricao.text,
      valor: custoDouble,
    );

    _atualizaNoBanco(servicoAlterado);
  }

  _formataData() {
    DateTime dataEmDateTime = DateTime.parse(widget.servico.data);
    String formattedDate =
        DateFormat('dd/MM/yyyy HH:mm:ss').format(dataEmDateTime);
    _controllerDataDoServico.text = formattedDate;
  }

  _atualizaNoBanco(Servico servicoAlterado) {
    servicoDaoDb.editar(servicoAlterado).then(
          (value) => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Serviço atualizado!'),
              backgroundColor: Colors.grey,
              duration: Duration(seconds: 3),
            ),
          ),
        );
  }

  _clickSalvar() {
    if (_formKeyServico.currentState!.validate()) {
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
                  _substiuiServico();
                },
                child: const Text('Salvar')),
          ],
        ),
      );
    }
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

  _selecionarDatadoServico() async {
    showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
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
                dataSelecionada = selectedDateTime;
                String dataFormatada =
                    DateFormat('dd/MM/yyyy HH:mm:ss').format(selectedDateTime);
                setState(() {
                  _controllerDataDoServico.text = dataFormatada;
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
        title: const Text('Editar serviço'),
        backgroundColor: UtilsColors.corAppBar,
      ),
      backgroundColor: UtilsColors.corFundoTela,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKeyServico,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: DropdownButtonFormField<String>(
                      value: tipoSelecionado,
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
                      onTapOutside: (event) => _esconderTeclado(),
                      readOnly: true,
                      onTap: () => _selecionarDatadoServico(),
                      onFieldSubmitted: (value) => _clickSalvar(),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      controller: _controllerDataDoServico,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.calendar_month,
                          color: Colors.black,
                        ),
                        label: Text(
                          'Data',
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
                      onTapOutside: (event) => _esconderTeclado(),
                      validator: _validaQuilometragem,
                      onFieldSubmitted: (value) => _clickSalvar(),
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
                      onTapOutside: (event) => _esconderTeclado(),
                      onFieldSubmitted: (value) => _clickSalvar(),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      controller: _controllerDescricao,
                      decoration: const InputDecoration(
                        label: Text(
                          'Descrição',
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
                      onTapOutside: (event) => _esconderTeclado(),
                      controller: _controllerCusto,
                      validator: _validaCusto,
                      onFieldSubmitted: (value) => _clickSalvar(),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
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
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  UtilsColors.corFloatingActionButton,
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
