import 'package:driveease_v1/Pages/Pillar/layout_page.dart';
import 'package:driveease_v1/Pages/Login/signup_page.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final String _defaultUsername = 'admin';
  final String _defaultPassword = 'admin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilsColors.corFundoTela,
      appBar: AppBar(
        backgroundColor: UtilsColors.corFloatingActionButton,
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                    labelText: 'Usuário', prefixIcon: Icon(Icons.person)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o usuário';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: 'Senha', prefixIcon: Icon(Icons.lock)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a senha';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_usernameController.text == _defaultUsername &&
                            _passwordController.text == _defaultPassword) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LayoutPage(),
                            ),
                          );
                        } else {
                          // Login failed
                        }
                      }
                    },
                    color: Colors.blue,
                    textColor: UtilsColors.corFundoTela,
                    child: const Text('Entrar'),
                  ),
                  MaterialButton(
                    color: UtilsColors.corFloatingActionButton,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CadastroPage(),
                        ),
                      );
                    },
                    textColor: UtilsColors.corFundoTela,
                    child: const Text('Criar cadastro'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => PrivacyPolicyPage(),
                      //   ),
                      // );
                    },
                    textColor: Colors.blue,
                    child: const Text('Políticas de Privacidade'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
