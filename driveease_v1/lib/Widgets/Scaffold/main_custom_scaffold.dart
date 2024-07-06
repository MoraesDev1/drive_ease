import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:driveease_v1/Widgets/Drawer/custom_drawer.dart';
import 'package:flutter/material.dart';

class MainCustomScaffold extends StatefulWidget {
  final Widget body;
  final String textAppBar;
  final Widget? floatingActionButton;
  final List<Widget>? actions;

  const MainCustomScaffold(
      {super.key,
      required this.body,
      required this.textAppBar,
      this.floatingActionButton,
      this.actions});

  @override
  State<MainCustomScaffold> createState() => _MainCustomScaffoldState();
}

class _MainCustomScaffoldState extends State<MainCustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: widget.actions,
          title: Text(widget.textAppBar),
          centerTitle: true,
          backgroundColor: UtilsColors.corAppBar,
        ),
        backgroundColor: UtilsColors.corFundoTela,
        drawer: const CustomDrawer(),
        body: widget.body,
        floatingActionButton: widget.floatingActionButton,
      ),
    );
  }
}
