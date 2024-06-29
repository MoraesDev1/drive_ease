import 'package:driveease_v1/Pages/Login/login_page.dart';
import 'package:driveease_v1/Pages/Login/signup_page.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late GifController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GifController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilsColors.corFloatingActionButton,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bem-vindo",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 40,
                  color: UtilsColors.corFundoTela,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Nosso app vai te acompanhar na\n sua jornada rumo ao sucesso!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  color: UtilsColors.corFundoTela,
                ),
              )
            ],
          ),
          Gif(
            image: const AssetImage("Assets/motorista.gif"),
            controller: _controller,
            repeat: ImageRepeat.noRepeat,
            duration: const Duration(seconds: 1),
            autostart: Autostart.loop,
            placeholder: (context) => const Text('Loading...'),
            onFetchCompleted: () {
              _controller.reset();
              _controller.forward();
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        side: BorderSide(
                            strokeAlign: 2, color: UtilsColors.corFundoTela),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(13),
                        ),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                        UtilsColors.corFloatingActionButton)),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: SizedBox(
                  width: 90,
                  height: 40,
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: UtilsColors.corFundoTela,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        side: BorderSide(color: UtilsColors.corFundoTela),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(13),
                        ),
                      ),
                    ),
                    backgroundColor:
                        WidgetStatePropertyAll(UtilsColors.corFundoTela)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SignupPage(),
                  ));
                },
                child: SizedBox(
                  width: 90,
                  height: 40,
                  child: Center(
                    child: Text(
                      "Cadastrar",
                      style:
                          TextStyle(color: UtilsColors.corFloatingActionButton),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
