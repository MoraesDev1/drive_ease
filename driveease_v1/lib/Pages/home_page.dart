import 'package:driveease_v1/Database/dao1.dart';
import 'package:driveease_v1/Model/day.dart';
import 'package:driveease_v1/Model/service.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Day> _listDay = [];

  late BancoDeDados _dao;

  List<Service> _listService = [];

  bool _carregando = true;

  @override
  initState() {
    _dao.initializeDatabase().then((_) async {
      _listDay = await _dao.getDays();
      _listService = await _dao.getServices();
    }).catchError((e) {
      print(e);
    });
  }

  _insertDay(Day day) {
    setState(() {
      _carregando = true;
    });
    _dao.insertDay(day).then((daySalvo) {
      _listDay.add(daySalvo);
    }).catchError((e) {
      print(e);
    });
  }

  _insertService(Service service) {
    setState(() {
      _carregando = true;
    });
    _dao.insertService(service).then((Service) {
      _listService.add(service);
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        backgroundColor: Utils.corPrimaria,
      ),
      body: Container(
        color: Colors.green[100],
        child: const Center(
          child: Text(
            'Home',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
