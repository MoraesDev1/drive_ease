import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  bool showPassword = false;
  bool showPassword2 = false;

  // void _showCadastroConfirmadoDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Cadastro Confirmado'),
  //         content: const Text('Seu cadastro foi realizado com sucesso!'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UtilsColors.corFloatingActionButton,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: UtilsColors.corFloatingActionButton,
        title: const Text('Cadastro'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              TextFormField(
                controller: _nameController,
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
                  labelText: 'Nome Completo',
                  labelStyle: TextStyle(color: UtilsColors.corFundoTela),
                  prefixIcon: Icon(
                    Icons.person,
                    color: UtilsColors.corFundoTela,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome completo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _emailController,
                style: TextStyle(color: UtilsColors.corFundoTela),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                cursorColor: UtilsColors.corFundoTela,
                keyboardType: TextInputType.emailAddress,
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
                    Icons.email,
                    color: UtilsColors.corFundoTela,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um email válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _passwordController,
                style: TextStyle(color: UtilsColors.corFundoTela),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                cursorColor: UtilsColors.corFundoTela,
                obscureText: !showPassword,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma senha válida';
                  } else if (value !=
                      _passwordConfirmController.value.toString()) {
                    return 'As senhas não coincidem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _passwordConfirmController,
                style: TextStyle(color: UtilsColors.corFundoTela),
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                cursorColor: UtilsColors.corFundoTela,
                obscureText: !showPassword2,
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
                  labelText: 'Confirmação de Senha',
                  suffixIcon: IconButton(
                    color: UtilsColors.corFundoTela,
                    onPressed: () {
                      setState(() {
                        showPassword2 = !showPassword2;
                      });
                    },
                    icon: showPassword2
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  labelStyle: TextStyle(color: UtilsColors.corFundoTela),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: UtilsColors.corFundoTela,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma senha válida';
                  } else if (value != _passwordController.value.toString()) {
                    return 'As senhas não coincidem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 50),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //ação a ser tomada quando validações estiverem ok
                  }
                },
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Cadastrar",
                      style: TextStyle(
                        color: UtilsColors.corFloatingActionButton,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
