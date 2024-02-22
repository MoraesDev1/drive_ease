import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:driveease_v1/Widgets/Button/star_stop_button_widget.dart';
import 'package:driveease_v1/Widgets/Section/summary_section.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.corFundo,
      appBar: AppBar(
        title: const Text('Homepage'),
        centerTitle: true,
        backgroundColor: Utils.verdePrimario,
      ),
      body: const Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SummarySection(),
            const Spacer(),
            const StartStopButton(),
          ],
        ),
      ),
    );
  }
}
