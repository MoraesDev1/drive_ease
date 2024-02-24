import 'package:driveease_v1/Pages/Pillar/layout_page.dart';
import 'package:driveease_v1/Pages/Display/sobre_page.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:driveease_v1/Widgets/Cards/card_account.dart';
import 'package:driveease_v1/Widgets/Cards/card_nav_to_page.dart';
import 'package:flutter/material.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({super.key});
  final double paddingDaTela = 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilsColors.corFundoTela,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
        title: const Text('Opções'),
        centerTitle: true,
        backgroundColor: UtilsColors.corAppBar,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: paddingDaTela, left: paddingDaTela, right: paddingDaTela),
          child: Column(
            children: [
              CardAccount(),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    CardNavToPage(
                      nomeDaPage: 'Veículos',
                      page: LayoutPage(),
                    ),
                    SizedBox(width: 10),
                    CardNavToPage(
                      nomeDaPage: 'Agendamentos',
                      page: LayoutPage(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    CardNavToPage(
                      nomeDaPage: 'CNH Digital',
                      page: LayoutPage(),
                    ),
                    SizedBox(width: 10),
                    CardNavToPage(
                      nomeDaPage: 'Licenciamento',
                      page: LayoutPage(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    CardNavToPage(
                      nomeDaPage: 'Débitos/Multas',
                      page: LayoutPage(),
                    ),
                    SizedBox(width: 10),
                    CardNavToPage(
                      nomeDaPage: 'Postos',
                      page: LayoutPage(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    CardNavToPage(
                      nomeDaPage: 'Oficinas',
                      page: LayoutPage(),
                    ),
                    SizedBox(width: 10),
                    CardNavToPage(
                      nomeDaPage: 'Tabela FIPE',
                      page: LayoutPage(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    CardNavToPage(
                      nomeDaPage: 'Sobre Nós',
                      page: SobrePage(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
