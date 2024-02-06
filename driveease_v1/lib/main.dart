import 'package:driveease_v1/Pages/layout_page.dart';
import 'package:driveease_v1/Pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: const LayoutPage(), // voltar para login page antes de commitar
      theme: ThemeData(
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
