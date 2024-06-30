import 'package:driveease_v1/Pages/Display/historic_page.dart';
import 'package:driveease_v1/Pages/Display/home_page.dart';
import 'package:driveease_v1/Pages/Display/report_page.dart';
import 'package:driveease_v1/Pages/Pillar/options_page.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: UtilsColors.corFloatingActionButton,
            ),
            child: const Text(
              'Drawer titulo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Homepage'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                  (_) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.sticky_note_2_outlined),
            title: const Text('Relatórios'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const ReportPage(),
                  ),
                  (_) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Histórico'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const HistoricPage(),
                  ),
                  (_) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Opções'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const OptionsPage(),
                  ),
                  (_) => false);
            },
          ),
        ],
      ),
    );
  }
}
