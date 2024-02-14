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
      iconColor: Colors.white,
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
          color: Colors.green.shade500,
        ),
        child: ListTile(
          title: Row(
            children: [
              Column(
                children: [
                  Text('Data: ${servico.data}',
                      style: const TextStyle(color: Colors.white)),
                  Text('Descrição: ${servico.descricao}',
                      style: const TextStyle(color: Colors.white))
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Text('Km: ${servico.km}',
                      style: const TextStyle(color: Colors.white)),
                  Text('Valor: ${servico.valor}',
                      style: const TextStyle(color: Colors.white))
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
