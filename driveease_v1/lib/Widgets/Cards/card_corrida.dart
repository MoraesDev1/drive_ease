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
    _formataData();
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: UtilsColors.corCardServicoECorrida,
      ),
      child: ListTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset(
                    'Assets/chequered-flag.png',
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data: $data',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Percorrido: ${(corrida.stopKm! - corrida.startKm).toStringAsFixed(1)}Km',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Recebido: ${corrida.ganhos!.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                _getPopupMenuItem(),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
        onTap: () {
          onMenuClick(MyItemCorrida.itemTap);
        },
        onLongPress: () {
          onMenuClick(MyItemCorrida.itemLongPress);
        },
      ),
    );
  }
}
