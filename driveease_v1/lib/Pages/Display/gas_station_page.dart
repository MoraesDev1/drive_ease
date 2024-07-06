import 'package:driveease_v1/Controller/gas_station_controller.dart';
import 'package:driveease_v1/Widgets/Scaffold/main_custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GasStationPage extends StatelessWidget {
  const GasStationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainCustomScaffold(
        body: ChangeNotifierProvider<GasStationController>(
          create: (context) => GasStationController(),
          child: Builder(
            builder: (context) {
              final local = context.watch<GasStationController>();

              String message = local.erro == ""
                  ? "Latitude: ${local.lat} | Longitude: ${local.long}"
                  : local.erro;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(message),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        textAppBar: "Postos");
  }
}
