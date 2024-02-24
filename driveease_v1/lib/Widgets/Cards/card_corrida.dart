import 'package:driveease_v1/Model/corrida.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum MyItemCorrida { itemEdit, itemDelete, itemTap, itemLongPress }

// ignore: must_be_immutable
class CardCorrida extends StatelessWidget {
  CardCorrida({super.key, required this.corrida, required this.onMenuClick});

  late Function(MyItemCorrida item) onMenuClick;
  late Corrida corrida;
  late String data;

  _formataData() {
    DateTime dataEmDateTime = DateTime.parse(corrida.dataHoraStart);
    String formattedDate = DateFormat('dd/MM/yyyy').format(dataEmDateTime);
    data = formattedDate;
  }

  _getPopupMenuItem() {
    return PopupMenuButton<MyItemCorrida>(
      iconColor: Colors.white,
      onSelected: (MyItemCorrida value) {
        onMenuClick(value);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MyItemCorrida>>[
        const PopupMenuItem<MyItemCorrida>(
          value: MyItemCorrida.itemEdit,
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Editar'),
          ),
        ),
        const PopupMenuItem<MyItemCorrida>(
          value: MyItemCorrida.itemDelete,
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
          color: UtilsColors.corCardServicoECorrida,
        ),
        child: ListTile(
          title: Row(
            children: [
              Column(
                children: [
                  Text(
                    'Start: ${corrida.dataHoraStart}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Km Inicio: ${corrida.startKm.toString()}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Stop: ${corrida.dataHoraStop}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Km Fim: ${corrida.stopKm.toString()}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const Spacer(),
              _getPopupMenuItem(),
            ],
          ),
          onTap: () {
            onMenuClick(MyItemCorrida.itemTap);
          },
          onLongPress: () {
            onMenuClick(MyItemCorrida.itemLongPress);
          },
        ),
      ),
    );
  }
}
