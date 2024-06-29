import 'package:driveease_v1/Database/LocalDatabase/mediator.dart';
import 'package:driveease_v1/Database/LocalDatabase/database.dart';
import 'package:driveease_v1/Pages/Login/welcome_page.dart';
import 'package:driveease_v1/Pages/Pillar/layout_page.dart';
import 'package:driveease_v1/Service/prefs_service.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.wait([
      PrefsService.isAuth(),
      LocalDatabase.initDatabase('driveease_v1.db').then((v) async {
        Mediator().db = v;
        Mediator().buscarCorridaStart();
        await Future.delayed(const Duration(seconds: 4));
        if (!context.mounted) return;
      })
    ]).then(
      (value) {
        value[0]!
            ? Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => LayoutPage(),
                ),
                (_) => false)
            : Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => WelcomePage(),
                ),
                (_) => false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilsColors.corFundoTela,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.25),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.5,
            child: Image.asset(
              'Assets/car4.gif',
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.14),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.4,
            height: MediaQuery.sizeOf(context).height * 0.08,
            child: Image.asset(
              'Assets/splashscreen.png',
              color: UtilsColors.corTabBar,
            ),
          ),
        ],
      ),
    );
  }
}
