import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:driveease_v1/Widgets/Button/star_stop_button_widget.dart';
import 'package:driveease_v1/Widgets/Graphics/main_graphic_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        backgroundColor: Utils.corPrimaria,
      ),
      body: Container(
        color: Utils.corFundo,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Resumo Geral',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            GraphicMain(),
            Spacer(),
            StartStopButton(),
          ],
        ),
      ),
    );
  }
}
