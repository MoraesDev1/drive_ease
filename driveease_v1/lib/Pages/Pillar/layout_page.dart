import 'package:driveease_v1/Pages/Display/historic_page.dart';
import 'package:driveease_v1/Pages/Display/home_page.dart';
import 'package:driveease_v1/Pages/Pillar/options_page.dart';
import 'package:driveease_v1/Pages/Display/report_page.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int selectedIcon = 0;
  PageController pageController = PageController();

  final List<Widget> pages = [
    HomePage(),
    const ReportPage(),
    HistoricPage(),
    const OptionsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: pages,
        onPageChanged: (index) {
          setState(() {
            selectedIcon = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Utils.corPrimaria,
        unselectedItemColor: Colors.white,
        selectedItemColor: Utils.corSecundaria,
        currentIndex: selectedIcon,
        onTap: (value) {
          pageController.animateToPage(
            value,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
          selectedIcon = value;
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
      ),
    );
  }
}
