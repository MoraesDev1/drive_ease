import 'package:driveease_v1/Widgets/Cards/card_summary.dart';
import 'package:flutter/material.dart';

class SummarySection extends StatelessWidget {
  const SummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 0,
              color: Color.fromARGB(75, 0, 0, 0),
              child: Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  'Resumos',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CardSummary(titulo: 'Hoje'),
              SizedBox(
                width: 10,
              ),
              CardSummary(titulo: 'Esta Semana'),
              SizedBox(
                width: 10,
              ),
              CardSummary(titulo: 'Este Mês'),
            ],
          ),
        ),
      ],
    );
  }
}
