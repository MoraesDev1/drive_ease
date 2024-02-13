import 'package:driveease_v1/Model/corrida.dart';
import 'package:flutter/material.dart';

enum MyItem { itemEdit, itemDelete, itemTap, itemLongPress }

// ignore: must_be_immutable
class CardCorrida extends StatelessWidget {
  CardCorrida({super.key, required this.corrida, required this.onMenuClick});

  late Function(MyItem item) onMenuClick;
  late Corrida corrida;

  _getPopupMenuItem() {
    return PopupMenuButton<MyItem>(
      iconColor: Colors.white,
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
          color: Colors.green.shade500,
        ),
        child: ListTile(
          title: Row(
            children: [
              Column(
                children: [
                  Text(
                    'Start: ${corrida.dataHoraStart}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Km Inicio: ${corrida.startKm.toString()}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Stop: ${corrida.dataHoraStop}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Km Fim: ${corrida.stopKm.toString()}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const Spacer(),
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
