import 'package:driveease_v1/Model/servico.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';

enum MyItemServico { itemEdit, itemDelete, itemTap, itemLongPress }

// ignore: must_be_immutable
class CardServico extends StatelessWidget {
  CardServico({super.key, required this.servico, required this.onMenuClick});

  late Function(MyItemServico item) onMenuClick;
  late Servico servico;

  _getPopupMenuItem() {
    return PopupMenuButton<MyItemServico>(
      onSelected: (MyItemServico value) {
        onMenuClick(value);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MyItemServico>>[
        const PopupMenuItem<MyItemServico>(
          value: MyItemServico.itemEdit,
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Editar'),
          ),
        ),
        const PopupMenuItem<MyItemServico>(
          value: MyItemServico.itemDelete,
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Remover'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Utils.corFundo,
        ),
        child: ListTile(
          title: Row(
            children: [
              Column(
                children: [
                  Text('Data: ${servico.data}'),
                  Text('Descrição: ${servico.descricao}')
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Text('Km: ${servico.km}'),
                  Text('Valor: ${servico.valor}')
                ],
              ),
              _getPopupMenuItem(),
            ],
          ),
          onTap: () {
            onMenuClick(MyItemServico.itemTap);
          },
          onLongPress: () {
            onMenuClick(MyItemServico.itemLongPress);
          },
        ),
      ),
    );
  }
}
