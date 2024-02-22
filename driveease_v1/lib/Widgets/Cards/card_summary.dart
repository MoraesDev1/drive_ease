import 'package:flutter/material.dart';

class CardSummary extends StatelessWidget {
  const CardSummary({super.key, required this.titulo});

  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(8),
      height: 130,
      child: Card(
        elevation: 0,
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
            const Row(
              children: [
                Text(
                  'Recebimentos',
                  style: TextStyle(
                    color: Color.fromARGB(255, 158, 158, 158),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '__________________',
                  style: TextStyle(
                      color: Color.fromARGB(131, 158, 158, 158),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'R\$XXXX,XX',
                  style: TextStyle(
                    color: Color.fromARGB(255, 158, 158, 158),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  'Despesas',
                  style: TextStyle(
                    color: Color.fromARGB(255, 158, 158, 158),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '______________________',
                  style: TextStyle(
                      color: Color.fromARGB(131, 158, 158, 158),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  ' R\$XXXX,XX',
                  style: TextStyle(
                    color: Color.fromARGB(255, 158, 158, 158),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Text(
                  'Saldo parcial',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '___________________',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'R\$XXXX,XX',
                  style: TextStyle(
                    color: Colors.black,
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
