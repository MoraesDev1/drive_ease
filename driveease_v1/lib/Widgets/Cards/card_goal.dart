import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';

class CardGoal extends StatelessWidget {
  CardGoal({
    super.key,
    required this.titulo,
    required this.meta,
    required this.saldo,
    required this.corDoIndicadorDeProgresso,
  });

  final String titulo;
  final double meta;
  final double saldo;
  final Color corDoIndicadorDeProgresso;

  final TextStyle subtitleStyle = TextStyle(
    color: UtilsColors.corTextoSecundarioNosWidgets,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: UtilsColors.corFundoPadraoWidgets,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: corDoIndicadorDeProgresso,
        ),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 110,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Saldo Atual',
                style: subtitleStyle,
              ),
              Text(
                '/',
                style: subtitleStyle,
              ),
              Text(
                'Meta',
                style: subtitleStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'R\$',
                style: subtitleStyle,
              ),
              Text(
                saldo.toStringAsFixed(2),
                style: TextStyle(
                  color: UtilsColors.corTextoEmDestaqueNosWidgets,
                  fontSize: 25,
                ),
              ),
              Text(
                '/ R\$${meta.toStringAsFixed(2)}',
                style: subtitleStyle,
              ),
            ],
          ),
          LinearProgressIndicator(
            color: corDoIndicadorDeProgresso,
            backgroundColor: const Color.fromARGB(75, 158, 158, 158),
            value: saldo / meta,
          ),
        ],
      ),
    );
  }
}
