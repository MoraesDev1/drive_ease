import 'package:driveease_v1/Pages/Display/gas_station_page.dart';
import 'package:driveease_v1/Pages/Display/historic_page.dart';
import 'package:driveease_v1/Pages/Display/home_page.dart';
import 'package:driveease_v1/Pages/Display/report_page.dart';
import 'package:driveease_v1/Pages/Display/sobre_page.dart';
import 'package:driveease_v1/Pages/Login/welcome_page.dart';
import 'package:driveease_v1/Pages/Pillar/options_page.dart';
import 'package:driveease_v1/Service/prefs_service.dart';
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
          ListTile(
            leading: const Icon(Icons.directions_car),
            title: const Text('Veículos'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month_rounded),
            title: const Text('Agendamentos'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.contact_emergency_rounded),
            title: const Text('CNH Digital'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.feed),
            title: const Text('Licenciamento'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.money_off),
            title: const Text('Débitos/Multas'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.local_gas_station),
            title: const Text('Postos'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const GasStationPage(),
                  ),
                  (_) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Oficinas'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.table_view),
            title: const Text('Tabela FIPE'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Sobre Nós'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SobrePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            onTap: () {
              PrefsService.logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const WelcomePage(),
                ),
                (_) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
