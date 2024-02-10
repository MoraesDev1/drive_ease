import 'package:driveease_v1/Model/corrida.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';

enum MyItem { itemEdit, itemDelete, itemTap, itemLongPress }

// ignore: must_be_immutable
class CardCorrida extends StatelessWidget {
  CardCorrida({super.key, required this.corrida, required this.onMenuClick});

  late Function(MyItem item) onMenuClick;
  late Corrida corrida;

  _getPopupMenuItem() {
    return PopupMenuButton<MyItem>(
      onSelected: (MyItem value) {
        onMenuClick(value);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MyItem>>[
        const PopupMenuItem<MyItem>(
          value: MyItem.itemEdit,
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Editar'),
          ),
        ),
        const PopupMenuItem<MyItem>(
          value: MyItem.itemDelete,
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
                  Text('Start: ${corrida.dataHoraStart}'),
                  Text('Stop: ${corrida.dataHoraStop}')
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Text('Km Inicio: ${corrida.startKm.toString()}'),
                  Text('Km Fim: ${corrida.stopKm.toString()}')
                ],
              ),
              _getPopupMenuItem(),
            ],
          ),
          onTap: () {
            onMenuClick(MyItem.itemTap);
          },
          onLongPress: () {
            onMenuClick(MyItem.itemLongPress);
          },
        ),
      ),
    );
  }
}
