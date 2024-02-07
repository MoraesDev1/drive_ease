import 'package:driveease_v1/Pages/layout_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home:
          const LayoutPage(), //temporariamente manter em LayoutPage até que o Login esteja funcional
      theme: ThemeData(
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
