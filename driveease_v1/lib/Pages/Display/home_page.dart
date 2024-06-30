import 'package:driveease_v1/Database/Dao/Impl/corrida_dao_db.dart';
import 'package:driveease_v1/Database/Dao/Impl/servico_dao_db.dart';
import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Widgets/Button/new_action_button_widget.dart';
import 'package:driveease_v1/Widgets/Scaffold/main_custom_scaffold.dart';
import 'package:driveease_v1/Widgets/Section/goals_section.dart';
import 'package:driveease_v1/Widgets/Section/summary_section.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Mediator mediator = Mediator();
  CorridaDaoDb corridaDaoDb = CorridaDaoDb();
  ServicoDaoDb servicoDaoDb = ServicoDaoDb();

  _carregaListas() async {
    mediator.listaDeCorridas = await corridaDaoDb.listar();
    mediator.listaDeServicos = await servicoDaoDb.listar();
  }

  atualizaHomePage() {
    _carregaListas().then((e) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainCustomScaffold(
      textAppBar: "Homepage",
      floatingActionButton: MenuNovaAcao(atualizaHome: atualizaHomePage),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SummarySection(),
              SizedBox(height: 10),
              GoalsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
