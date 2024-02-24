import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:driveease_v1/Widgets/Cards/card_summary.dart';
import 'package:flutter/material.dart';

class SummarySection extends StatelessWidget {
  const SummarySection({super.key});

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
                'Resumos:',
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
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CardSummary(
                titulo: 'Hoje',
                despesas:
                    20, //valores devem ser variaveis de acordo com o banco
                recebimentos:
                    110.50, //valores devem ser variaveis de acordo com o banco
              ),
              SizedBox(
                width: 10,
              ),
              CardSummary(
                titulo: 'Esta Semana',
                despesas:
                    110.25, //valores devem ser variaveis de acordo com o banco
                recebimentos:
                    546.05, //valores devem ser variaveis de acordo com o banco
              ),
              SizedBox(
                width: 10,
              ),
              CardSummary(
                titulo: 'Este Mês',
                despesas:
                    635.15, //valores devem ser variaveis de acordo com o banco
                recebimentos:
                    3514.40, //valores devem ser variaveis de acordo com o banco
              ),
            ],
          ),
        ),
      ],
    );
  }
}
