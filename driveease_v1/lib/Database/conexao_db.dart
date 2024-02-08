import 'package:sqflite/sqflite.dart';

class ConexaoDb {
  ConexaoDb._privateConstructor();
  late Database db;
  static final ConexaoDb _instance = ConexaoDb._privateConstructor();

  factory ConexaoDb() {
    return _instance;
  }
}
