import 'package:driveease_v1/Widgets/bottomNavigationBarCustom.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        backgroundColor: Colors.green[900],
      ),
      body: Container(
        color: Colors.green[100],
        child: const Center(
          child: Text(
            'Home',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarCustom(),
    );
  }
}
