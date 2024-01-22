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

_vaiParaHome(BuildContext context, int direction) {
  Navigator.of(context).pushReplacement(
    _createRoute(
      direction,
      const HomePage(),
    ),
  );
}

_vaiParaRelatorio(BuildContext context, int direction) {
  Navigator.of(context).pushReplacement(
    _createRoute(
      direction,
      const ReportPage(),
    ),
  );
}

_vaiParaHistorico(BuildContext context, int direction) {
  Navigator.of(context).pushReplacement(
    _createRoute(
      direction,
      const HistoricPage(),
    ),
  );
}

_vaiParaMais(BuildContext context, int direction) {
  Navigator.of(context).pushReplacement(
    _createRoute(
      direction,
      const HomePage(),
    ),
  );
}

Route _createRoute(int direction, StatelessWidget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Offset begin;
      Offset end;

      if (direction > 0) {
        begin = Offset(-1.0, 0.0);
        end = Offset(0.0, 0.0);
      } else if (direction == 0) {
        begin = Offset(0.0, 0.0);
        end = Offset(0.0, 0.0);
      } else {
        begin = Offset(1.0, 0.0);
        end = Offset(0.0, 0.0);
      }
      const curve = Curves.easeOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
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
              int direction = 0;
              if (selectedIcon > value) {
                direction = 1;
              } else if (selectedIcon < value) {
                direction = -1;
              }
              selectedIcon = value;
              _vaiParaHome(context, direction);
            });
            break;
          case 1:
            setState(() {
              int direction = 0;
              if (selectedIcon > value) {
                direction = 1;
              } else if (selectedIcon < value) {
                direction = -1;
              }
              selectedIcon = value;
              _vaiParaRelatorio(context, direction);
            });

            break;
          case 2:
            setState(() {
              int direction = 0;
              if (selectedIcon > value) {
                direction = 1;
              } else if (selectedIcon < value) {
                direction = -1;
              }
              selectedIcon = value;
              _vaiParaHistorico(context, direction);
            });

            break;
          case 3:
            setState(() {
              int direction = 0;
              if (selectedIcon > value) {
                direction = 1;
              } else if (selectedIcon < value) {
                direction = -1;
              }
              selectedIcon = value;
              _vaiParaMais(context, direction);
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
