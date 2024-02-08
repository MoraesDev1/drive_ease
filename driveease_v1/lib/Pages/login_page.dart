import 'package:driveease_v1/Pages/layout_page.dart';
import 'package:driveease_v1/Pages/signup_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.corFundo,
      appBar: AppBar(
        backgroundColor: Utils.corPrimaria,
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20.0),
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
              SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Senha', prefixIcon: Icon(Icons.lock)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a senha';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
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
                              builder: (context) => LayoutPage(),
                            ),
                          );
                        } else {
                          // Login failed
                        }
                      }
                    },
                    child: Text('Entrar'),
                    color: Colors.blue,
                    textColor: Utils.corFundo,
                  ),
                  MaterialButton(
                    color: Utils.corPrimaria,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CadastroPage(),
                        ),
                      );
                    },
                    child: Text('Criar cadastro'),
                    textColor: Utils.corFundo,
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
                    child: Text('Políticas de Privacidade'),
                    textColor: Colors.blue,
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
