import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatórios'),
        backgroundColor: Utils.corPrimaria,
      ),
      body: Container(
        color: Colors.green[100],
        child: Center(
          child: Column(
            children: [
              const Text(
                'Relatórios',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
