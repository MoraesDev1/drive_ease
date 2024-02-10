import 'package:flutter/material.dart';

class HistoricoCorrida extends StatelessWidget {
  const HistoricoCorrida({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de corridas'),
      ),
      // Botão para adicionar uma corrida manual
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.add),),
    );
  }
}
