import 'package:flutter/material.dart';

class CardGoal extends StatelessWidget {
  const CardGoal({
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

  final TextStyle subtitleStyle = const TextStyle(
    color: Color.fromARGB(255, 158, 158, 158),
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color.fromARGB(90, 0, 0, 0)),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 110,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              color: Colors.black,
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
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 23,
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
