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
  late String iconPath;

  _formataData() {
    DateTime dataEmDateTime = DateTime.parse(servico.data);
    String formattedDate = DateFormat('dd/MM/yyyy').format(dataEmDateTime);
    String formattedHour = DateFormat('HH:mm:ss').format(dataEmDateTime);
    data = formattedDate;
    hora = formattedHour;
  }

  _defineIcone() {
    switch (servico.tipoDoServico) {
      case 'Troca de Óleo':
        iconPath = 'Assets/oil-change.png';
        break;
      case 'Abastecimento':
        iconPath = 'Assets/gas-station.png';
        break;
      case 'Troca de Pneus':
        iconPath = 'Assets/tires-change.png';
        break;
      case 'Manutenção de Rotina':
        iconPath = 'Assets/car-repair.png';
        break;
      case 'Lavagem/Limpeza':
        iconPath = 'Assets/car-wash.png';
        break;
    }
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

  @override
  Widget build(BuildContext context) {
    _formataData();
    _defineIcone();
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
              SizedBox(
                height: 50,
                width: 50,
                child: Image.asset(
                  iconPath,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Data: $data',
                      style: const TextStyle(color: Colors.white)),
                  Text('Hora: $hora',
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
              Column(
                children: [
                  Text('Km: ${servico.km}',
                      style: const TextStyle(color: Colors.white)),
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
