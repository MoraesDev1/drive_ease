import 'package:driveease_v1/Widgets/Cards/card_goal.dart';
import 'package:flutter/material.dart';

class GoalsSection extends StatelessWidget {
  const GoalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Card(
          elevation: 0,
          color: Color.fromARGB(75, 0, 0, 0),
          child: Padding(
            padding: EdgeInsets.all(4),
            child: Text(
              'Metas',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 400,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CardGoal(
                  titulo: 'Hoje',
                  saldo: 80,
                  meta: 200,
                  corDoIndicadorDeProgresso: Colors.blue,
                ),
                SizedBox(
                  height: 10,
                ),
                CardGoal(
                  titulo: 'Esta Semana',
                  saldo: 435.80,
                  meta: 1000,
                  corDoIndicadorDeProgresso: Colors.purple,
                ),
                SizedBox(
                  height: 10,
                ),
                CardGoal(
                  titulo: 'Este Mês',
                  saldo: 2879.25,
                  meta: 5000,
                  corDoIndicadorDeProgresso: Colors.teal,
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
