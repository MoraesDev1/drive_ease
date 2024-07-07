import 'package:driveease_v1/Model/gas_station.dart';
import 'package:flutter/material.dart';

class GasStationDetails extends StatelessWidget {
  final GasStation gasStation;
  const GasStationDetails({super.key, required this.gasStation});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          gasStation.photo,
          height: 250,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 24),
          child: Text(
            gasStation.name,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 60, left: 24),
          child: Text(
            gasStation.adress,
          ),
        ),
      ],
    );
  }
}
