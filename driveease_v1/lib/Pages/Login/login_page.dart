import 'package:driveease_v1/Pages/Display/home_page.dart';
import 'package:driveease_v1/Service/prefs_service.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final String _defaultUsername = 'admin';
  final String _defaultPassword = 'admin';
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: UtilsColors.corFloatingActionButton,
        appBar: AppBar(
          backgroundColor: UtilsColors.corFloatingActionButton,
          title: const Text('Login'),
          centerTitle: true,
          shadowColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 130),
                  TextFormField(
                    controller: _usernameController,
                    style: TextStyle(color: UtilsColors.corFundoTela),
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    cursorColor: UtilsColors.corFundoTela,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        borderSide: BorderSide(
                          color: UtilsColors.corFundoTela,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        borderSide: BorderSide(
                          color: UtilsColors.corFundoTela,
                          width: 3,
                        ),
                      ),
                      border: const OutlineInputBorder(),
                      labelText: 'E-mail',
                      labelStyle: TextStyle(color: UtilsColors.corFundoTela),
                      prefixIcon: Icon(
                        Icons.person,
                        color: UtilsColors.corFundoTela,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o usuário';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _passwordController,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    cursorColor: UtilsColors.corFundoTela,
                    obscureText: !showPassword,
                    style: TextStyle(color: UtilsColors.corFundoTela),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        borderSide: BorderSide(
                          color: UtilsColors.corFundoTela,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        borderSide: BorderSide(
                          color: UtilsColors.corFundoTela,
                          width: 3,
                        ),
                      ),
                      border: const OutlineInputBorder(),
                      labelText: 'Senha',
                      suffixIcon: IconButton(
                        color: UtilsColors.corFundoTela,
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: showPassword
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                      labelStyle: TextStyle(color: UtilsColors.corFundoTela),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: UtilsColors.corFundoTela,
                      ),
                    ),
                    obscuringCharacter: "•",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe a senha';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Esqueceu sua senha?",
                            style: TextStyle(color: UtilsColors.corFundoTela),
                          ))
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                side: BorderSide(
                                    strokeAlign: 2,
                                    color: UtilsColors.corFloatingActionButton),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(13),
                                ),
                              ),
                            ),
                            backgroundColor: WidgetStatePropertyAll(
                                UtilsColors.corFundoTela)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_usernameController.text == _defaultUsername &&
                                _passwordController.text == _defaultPassword) {
                              PrefsService.save(_usernameController.text);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                                (route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      const Text('Usuário ou senha inválidos!'),
                                  duration: const Duration(seconds: 2),
                                  action: SnackBarAction(
                                    label: 'Fechar',
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    },
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        child: SizedBox(
                          width: 90,
                          height: 40,
                          child: Center(
                            child: Text(
                              "Entrar",
                              style: TextStyle(
                                  color: UtilsColors.corFloatingActionButton,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          height: 5,
                          color: UtilsColors.corFundoTela,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "ou",
                        style: TextStyle(color: UtilsColors.corFundoTela),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          height: 5,
                          color: UtilsColors.corFundoTela,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          side: BorderSide(
                            strokeAlign: 2,
                            color: UtilsColors.corFloatingActionButton,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        UtilsColors.corFundoTela,
                      ),
                    ),
                    onPressed: () {},
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child: Center(
                        child: Text(
                          "Login com o Google",
                          style: TextStyle(
                              color: UtilsColors.corFloatingActionButton,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          side: BorderSide(
                            strokeAlign: 2,
                            color: UtilsColors.corFloatingActionButton,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        UtilsColors.corFundoTela,
                      ),
                    ),
                    onPressed: () {},
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child: Center(
                        child: Text(
                          "Login com o Facebook",
                          style: TextStyle(
                              color: UtilsColors.corFloatingActionButton,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
