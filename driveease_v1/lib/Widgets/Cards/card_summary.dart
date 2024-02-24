import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';

class CardSummary extends StatelessWidget {
  const CardSummary({
    super.key,
    required this.titulo,
    required this.recebimentos,
    required this.despesas,
  });

  final String titulo;
  final double recebimentos;
  final double despesas;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color.fromARGB(90, 0, 0, 0)),
      ),
      padding: const EdgeInsets.all(8),
      height: 130,
      child: Card(
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              titulo,
              style: TextStyle(
                color: UtilsColors.corTextoEmDestaqueNosWidgets,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Recebimentos',
                  style: TextStyle(
                    color: UtilsColors.corTextoSecundarioNosWidgets,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '__________________',
                  style: TextStyle(
                      color: UtilsColors.corTextoSecundarioNosWidgets,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'R\$${recebimentos.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: UtilsColors.corTextoSecundarioNosWidgets,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Despesas',
                  style: TextStyle(
                    color: UtilsColors.corTextoSecundarioNosWidgets,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '______________________',
                  style: TextStyle(
                      color: UtilsColors.corTextoSecundarioNosWidgets,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  ' R\$${despesas.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: UtilsColors.corTextoSecundarioNosWidgets,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Saldo parcial',
                  style: TextStyle(
                    color: UtilsColors.corTextoEmDestaqueNosWidgets,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '___________________',
                  style: TextStyle(
                    color: UtilsColors.corTextoEmDestaqueNosWidgets,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'R\$${(recebimentos - despesas).toStringAsFixed(2)}',
                  style: TextStyle(
                    color: UtilsColors.corTextoEmDestaqueNosWidgets,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
