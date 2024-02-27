import 'package:driveease_v1/Model/servico.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum MyItemServico { itemEdit, itemDelete, itemTap, itemLongPress }

// ignore: must_be_immutable
class CardServico extends StatelessWidget {
  CardServico({super.key, required this.servico, required this.onMenuClick});

  final Function(MyItemServico item) onMenuClick;
  final Servico servico;
  late String data;

  late String iconPath;

  _formataData() {
    DateTime dataEmDateTime = DateTime.parse(servico.data);
    String formattedDate = DateFormat('dd/MM/yyyy').format(dataEmDateTime);
    data = formattedDate;
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
      case 'Revisão':
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
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: UtilsColors.corCardServicoECorrida,
      ),
      child: ListTile(
        title: Column(
          children: [
            Row(
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          servico.tipoDoServico,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text('Data: $data',
                            style: const TextStyle(color: Colors.white)),
                        Text('Valor: R\$${servico.valor.toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(height: 8),
                      ],
                    )
                  ],
                ),
                _getPopupMenuItem(),
              ],
            ),
          ],
        ),
        onTap: () {
          onMenuClick(MyItemServico.itemTap);
        },
        onLongPress: () {
          onMenuClick(MyItemServico.itemLongPress);
        },
      ),
    );
  }
}
