import 'package:driveease_v1/Widgets/bottomNavigationBarCustom.dart';
import 'package:flutter/material.dart';

class HistoricPage extends StatelessWidget {
  const HistoricPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
        backgroundColor: Colors.green[900],
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
      bottomNavigationBar: const BottomNavigationBarCustom(),
    );
  }
}
