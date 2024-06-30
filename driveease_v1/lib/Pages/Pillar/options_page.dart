import 'package:driveease_v1/Pages/Display/home_page.dart';
import 'package:driveease_v1/Pages/Login/welcome_page.dart';
import 'package:driveease_v1/Pages/Display/sobre_page.dart';
import 'package:driveease_v1/Service/prefs_service.dart';
import 'package:driveease_v1/Widgets/Cards/card_account.dart';
import 'package:driveease_v1/Widgets/Cards/card_nav_to_page.dart';
import 'package:driveease_v1/Widgets/Scaffold/main_custom_scaffold.dart';
import 'package:flutter/material.dart';

class OptionsPage extends StatelessWidget {
  const OptionsPage({super.key});
  final double paddingDaTela = 16;

  @override
  Widget build(BuildContext context) {
    return MainCustomScaffold(
      textAppBar: 'Opções',
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        IconButton(
          onPressed: () {
            PrefsService.logout();
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const WelcomePage(),
              ),
              (_) => false,
            );
          },
          icon: const Icon(Icons.exit_to_app),
        ),
      ],
      body: Padding(
        padding: EdgeInsets.only(
            top: paddingDaTela, left: paddingDaTela, right: paddingDaTela),
        child: const Column(
          children: [
            CardAccount(),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  CardNavToPage(
                    nomeDaPage: 'Veículos',
                    page: HomePage(),
                  ),
                  SizedBox(width: 10),
                  CardNavToPage(
                    nomeDaPage: 'Agendamentos',
                    page: HomePage(),
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
                    page: HomePage(),
                  ),
                  SizedBox(width: 10),
                  CardNavToPage(
                    nomeDaPage: 'Licenciamento',
                    page: HomePage(),
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
                    page: HomePage(),
                  ),
                  SizedBox(width: 10),
                  CardNavToPage(
                    nomeDaPage: 'Postos',
                    page: HomePage(),
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
                    page: HomePage(),
                  ),
                  SizedBox(width: 10),
                  CardNavToPage(
                    nomeDaPage: 'Tabela FIPE',
                    page: HomePage(),
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
    );
  }
}
