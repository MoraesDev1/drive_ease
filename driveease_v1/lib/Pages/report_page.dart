import 'package:driveease_v1/Widgets/bottomNavigationBarCustom.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatórios'),
        backgroundColor: Colors.green[900],
      ),
      body: Container(
        color: Colors.green[100],
        child: const Center(
          child: Text(
            'Relatórios',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCustom(),
    );
  }
}
