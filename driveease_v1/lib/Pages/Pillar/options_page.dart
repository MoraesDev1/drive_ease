import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opções'),
        backgroundColor: Utils.corPrimaria,
      ),
      body: Container(
        color: Colors.green[100],
        child: const Center(
          child: Text(
            'Opções',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
