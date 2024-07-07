import 'package:driveease_v1/Pages/Login/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(
    MaterialApp(
      home: const SplashPage(),
      theme: ThemeData(
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
