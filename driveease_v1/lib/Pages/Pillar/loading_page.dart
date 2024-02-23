import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Database/LocalDatabase/database.dart';
import 'package:driveease_v1/Pages/Pillar/layout_page.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    LocalDatabase.initDatabase('driveease_v1.db').then((value) async {
      Mediator().db = value;
      Mediator().buscarCorridaStart();
      await Future.delayed(const Duration(seconds: 2));
      if (!context.mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LayoutPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilsColors.corFundo,
      body: Center(
        child: SizedBox(
          width: 500,
          height: 500,
          child: Image.asset('Assets/car4.gif'),
        ),
      ),
    );
  }
}
