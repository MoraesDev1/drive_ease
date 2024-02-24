import 'package:driveease_v1/Widgets/Cards/card_devs.dart';
import 'package:flutter/material.dart';

class SobrePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Informações do Aplicativo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              child: ListTile(
                title: Text('Versão: 1.0.0'),
                subtitle: Text('Desenvolvido por: Equipe XYZ'),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Desenvolvedores',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            CardDevs(
              name: 'Carlos Matheus',
              description: 'Desenvolvedor Flutter',
              assetPath: 'assets/developer1.jpg',
            ),
            CardDevs(
              name: 'Carlos Matheus',
              description: 'Desenvolvedor Flutter',
              assetPath: 'assets/developer1.jpg',
            ),
            CardDevs(
              name: 'Carlos Matheus',
              description: 'Desenvolvedor Flutter',
              assetPath: 'assets/developer1.jpg',
            ),
            CardDevs(
              name: 'Carlos Matheus',
              description: 'Desenvolvedor Flutter',
              assetPath: 'assets/developer1.jpg',
            ),
          ],
        ),
      ),
    );
  }
}
