import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:driveease_v1/Widgets/Button/star_stop_button_widget.dart';
import 'package:driveease_v1/Widgets/Graphics/main_graphic_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Day> _listDay = [];
  // List<Service> _listService = [];
  // late BancoDeDados _dao;

  // bool _carregando = true;

  // @override
  // initState() {
  //   _dao.initializeDatabase().then((_) async {
  //     _listDay = await _dao.getDays();
  //     _listService = await _dao.getServices();
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  // _insertDay(Day day) {
  //   setState(() {
  //     _carregando = true;
  //   });
  //   _dao.insertDay(day).then((daySalvo) {
  //     _listDay.add(daySalvo);
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  // _insertService(Service service) {
  //   setState(() {
  //     _carregando = true;
  //   });
  //   _dao.insertService(service).then((Service) {
  //     _listService.add(service);
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        backgroundColor: Utils.corPrimaria,
      ),
      body: Container(
        color: Utils.corFundo,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Resumo Geral',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            GraphicMain(),
            Spacer(),
            StartStopButton(),
          ],
        ),
      ),
    );
  }
}
