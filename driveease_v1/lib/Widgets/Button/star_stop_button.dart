import 'package:flutter/material.dart';

class StartStopButton extends StatefulWidget {
  const StartStopButton({super.key});

  @override
  State<StartStopButton> createState() => _StartStopButtonState();
}

class _StartStopButtonState extends State<StartStopButton> {
  bool start = true;
  double sizeButton = 90;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: start ? Colors.green.shade500 : Colors.red.shade500,
        fixedSize: Size(sizeButton, sizeButton),
        shape: const CircleBorder(),
      ),
      onPressed: () {
        setState(() {
          start = !start;
        });
      },
      child: Text(start ? 'Start' : 'Stop'),
    );
  }
}
