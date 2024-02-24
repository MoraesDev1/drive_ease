import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:driveease_v1/Widgets/Cards/card_goal.dart';
import 'package:flutter/material.dart';

class GoalsSection extends StatelessWidget {
  const GoalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                'Metas:',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: UtilsColors.corTextoEmDestaqueNosWidgets,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Column(
          children: [
            CardGoal(
              titulo: 'Hoje',
              saldo: 90.50, //valores devem ser variaveis de acordo com o banco
              meta: 200, //valores devem ser variaveis de acordo com o banco
              corDoIndicadorDeProgresso: Colors.blue,
            ),
            const SizedBox(
              height: 10,
            ),
            CardGoal(
              titulo: 'Esta Semana',
              saldo: 435.80, //valores devem ser variaveis de acordo com o banco
              meta: 1000, //valores devem ser variaveis de acordo com o banco
              corDoIndicadorDeProgresso: Colors.purple,
            ),
            const SizedBox(
              height: 10,
            ),
            CardGoal(
              titulo: 'Este Mês',
              saldo:
                  2879.25, //valores devem ser variaveis de acordo com o banco
              meta: 5000, //valores devem ser variaveis de acordo com o banco
              corDoIndicadorDeProgresso: Colors.teal,
            ),
            const SizedBox(
              height: 110,
            ),
          ],
        ),
      ],
    );
  }
}
