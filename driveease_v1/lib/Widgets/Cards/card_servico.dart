import 'package:driveease_v1/Model/servico.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum MyItemServico { itemEdit, itemDelete, itemTap, itemLongPress }

// ignore: must_be_immutable
class CardServico extends StatelessWidget {
  CardServico({super.key, required this.servico, required this.onMenuClick});

  final Function(MyItemServico item) onMenuClick;
  final Servico servico;
  late String data;
  late String hora;

  _formataData() {
    DateTime dataEmDateTime = DateTime.parse(servico.data);
    String formattedDate = DateFormat('dd/MM/yyyy').format(dataEmDateTime);
    String formattedHour = DateFormat('HH:mm:ss').format(dataEmDateTime);
    data = formattedDate;
    hora = formattedHour;
  }

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

  Map<int, AssetImage> icones = {
    0: const AssetImage('Assets/oil-change.png'),
    1: const AssetImage('Assets/car-repair.png'),
    2: const AssetImage('Assets/gas-station.png'),
    3: const AssetImage('Assets/tires-change.png'),
    4: const AssetImage('Assets/car-wash.png'),
  };

  @override
  Widget build(BuildContext context) {
    _formataData();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey,
        ),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Icon(),
              Column(
                children: [
                  Text('Data: $data \nHora: $hora',
                      style: const TextStyle(color: Colors.white)),
                  Text('Km: ${servico.km}',
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
              Column(
                children: [
                  Text('Valor: ${servico.valor}',
                      style: const TextStyle(color: Colors.white)),
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
