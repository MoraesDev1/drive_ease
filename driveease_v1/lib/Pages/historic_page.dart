import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';

Utils utils = Utils();

class HistoricPage extends StatelessWidget {
  const HistoricPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
        backgroundColor: Utils.corPrimaria,
      ),
      body: Container(
        color: Colors.green[100],
        child: const Center(
          child: Text(
            'Histórico',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
