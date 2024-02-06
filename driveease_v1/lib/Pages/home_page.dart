import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:driveease_v1/Widgets/Graphics/graphic_main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        backgroundColor: Utils.corPrimaria,
      ),
      body: Container(
        color: Utils.corFundo,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Resumo Geral',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            GraphicMain(),
          ],
        ),
      ),
    );
  }
}
