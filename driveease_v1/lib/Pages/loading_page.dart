import 'package:driveease_v1/Database/conexao_db.dart';
import 'package:driveease_v1/Database/database.dart';
import 'package:driveease_v1/Pages/MainPages/layout_page.dart';
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
    LocalDatabase.initDatabase('driveease_v1.db').then((value) async {
      ConexaoDb().db = value;
      await Future.delayed(const Duration(seconds: 5));
      if (!context.mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LayoutPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.corFundo,
      body: const Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
