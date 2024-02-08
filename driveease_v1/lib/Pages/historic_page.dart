import 'package:driveease_v1/Pages/get_info_page.dart';

import 'package:driveease_v1/Pages/historico_corrida.dart';
import 'package:driveease_v1/Utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoricPage extends StatefulWidget {
  HistoricPage({super.key});

  @override
  State<HistoricPage> createState() => _HistoricPageState();
}

class _HistoricPageState extends State<HistoricPage> {
  int selectedIcon = 0;
  PageController pageController = PageController();

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  Future<void> _coletaInfo(DateTime selectedDay) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(selectedDay.toString()),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // ListView.builder(
                //     padding: const EdgeInsets.all(8),
                //     itemCount: entries.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return Container(
                //         height: 50,
                //         color: Colors.amber[colorCodes[index]],
                //         child: Center(child: Text('Entry ${entries[index]}')),
                //       );
                //     })
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Histórico'),
      //   backgroundColor: Utils.corPrimaria,
      // ),
      body: Column(
        children: [
          Container(
            height: 40,
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2,
                  child: TextButton(
                    child: Text('Corridas'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoricoCorrida(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextButton(
                    child: Text('Serviços'),
                    onPressed: () {},
                    style: TextButton.styleFrom(),
                  ),
                ),
              ],
            ),
          ),
          TableCalendar(
            onDaySelected: (selectedDay, focusedDay) =>
                _coletaInfo(selectedDay),
            firstDay: DateTime.utc(2010),
            lastDay: DateTime.utc(2030),
            focusedDay: DateTime.now(),
          ),
        ],
      ),
    );
  }
}
