import 'package:driveease_v1/Database/Dao/Impl/meta_dao_db.dart';
import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Model/metas.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewMetaButton extends StatefulWidget {
  const NewMetaButton({super.key});

  @override
  State<NewMetaButton> createState() => _NewMetaButtonState();
}

class _NewMetaButtonState extends State<NewMetaButton> {
  Mediator mediator = Mediator();
  MetaDaoDb metaDaoDb = MetaDaoDb();
  final _formKeyMeta = GlobalKey<FormState>();
  final _controllerInicio = TextEditingController();
  final _controllerFim = TextEditingController();
  final _controllerValor = TextEditingController();
  final _controllerDescricao = TextEditingController();

  String? _validaValor(String? value) {
    // String? entrada = value!.replaceAll(',', '.');
    // RegExp regex = RegExp(r'^\d*\.?\d*$');

    if (value!.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  _esconderTeclado() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  _clickSalvar() {
    if (_formKeyMeta.currentState!.validate()) {
      _criarMeta(_controllerValor.text);
      setState(() {
        _controllerDescricao.clear();
        _controllerInicio.clear();
        _controllerFim.clear();
        _controllerDescricao.clear();
      });
      Navigator.of(context).pop();
    }
  }

  _criarMeta(String valor) {
    double? valorDouble = double.parse(valor);

    Meta metaCriada = Meta(
      inicio: _controllerInicio.text,
      fim: _controllerFim.text,
      valor: valorDouble,
      descricao: _controllerDescricao.text,
    );

    _insereMetaNoBanco(metaCriada);
  }

  _insereMetaNoBanco(Meta meta) {
    metaDaoDb.inserir(meta);
  }

  _selecionarData(TextEditingController controllerSelecionado) async {
    showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ).then(
      (selectedDate) {
        if (selectedDate != null) {
          String dataFormatada =
              DateFormat('dd/MM/yyyy HH:mm:ss').format(selectedDate);
          setState(() {
            controllerSelecionado.text = dataFormatada.substring(0, 11);
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: SingleChildScrollView(
        child: AlertDialog(
          content: SizedBox(
            child: Form(
              key: _formKeyMeta,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Nova Meta'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      onTapOutside: (event) => _esconderTeclado(),
                      readOnly: true,
                      onTap: () => _selecionarData(_controllerInicio),
                      onFieldSubmitted: (value) => _clickSalvar(),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      controller: _controllerInicio,
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
                      onTapOutside: (event) => _esconderTeclado(),
                      readOnly: true,
                      onTap: () => _selecionarData(_controllerFim),
                      onFieldSubmitted: (value) => _clickSalvar(),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      controller: _controllerFim,
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
                      maxLength: 10,
                      controller: _controllerValor,
                      validator: _validaValor,
                      onFieldSubmitted: (value) => _clickSalvar(),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        counterText: '',
                        label: Text(
                          'Valor',
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
                    child: TextFormField(
                      onTapOutside: (event) => _esconderTeclado,
                      maxLines: null,
                      onFieldSubmitted: (value) => _clickSalvar(),
                      cursorColor: Colors.black,
                      controller: _controllerDescricao,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        hintText: 'Descreva a meta',
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
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Utils.verdePrimario,
                            ),
                            child: const Text('Criar Meta'),
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
