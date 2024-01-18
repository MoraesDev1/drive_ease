import 'package:driveease_v1/Pages/historic_page.dart';
import 'package:driveease_v1/Pages/home_page.dart';
import 'package:driveease_v1/Pages/report_page.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  const BottomNavigationBarCustom({super.key});

  @override
  State<BottomNavigationBarCustom> createState() =>
      _BottomNavigationBarCustomState();
}

int selectedIcon = 0;

_vaiParaHome(BuildContext context) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => const HomePage(),
    ),
  );
}

_vaiParaRelatorio(BuildContext context) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => const ReportPage(),
    ),
  );
}

_vaiParaHistorico(BuildContext context) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => const HistoricPage(),
    ),
  );
}

_vaiParaMais(BuildContext context) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => const HomePage(),
    ),
  );
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.green[900],
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.orange,
      currentIndex: selectedIcon,
      onTap: (value) {
        switch (value) {
          case 0:
            setState(() {
              selectedIcon = value;
              _vaiParaHome(context);
            });

            break;
          case 1:
            setState(() {
              selectedIcon = value;
              _vaiParaRelatorio(context);
            });

            break;
          case 2:
            setState(() {
              selectedIcon = value;
              _vaiParaHistorico(context);
            });

            break;
          case 3:
            setState(() {
              selectedIcon = value;
              _vaiParaMais(context);
            });

            break;
          default:
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.text_snippet),
          label: 'Relatórios',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'Histórico',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_outlined),
          label: 'Mais',
        ),
      ],
    );
  }
}
