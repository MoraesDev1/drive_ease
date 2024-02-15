import 'package:flutter/material.dart';
import 'package:sqflite/utils/utils.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Color.fromARGB(255, 1, 92, 63)])),
        child: Center(
          child: Image.asset(
            'Assets/splashscreen.png',
            color: Color(0xffad9c00),
          ),
        ),
      ),
    );
  }
}
