import 'package:driveease_v1/Controller/gas_station_controller.dart';
import 'package:driveease_v1/Widgets/Scaffold/main_custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

final appKey = GlobalKey();

class GasStationPage extends StatelessWidget {
  const GasStationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainCustomScaffold(
        key: appKey,
        body: ChangeNotifierProvider<GasStationController>(
          create: (context) => GasStationController(),
          child: Builder(
            builder: (context) {
              final local = context.watch<GasStationController>();

              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(local.lat, local.long),
                  zoom: 18,
                ),
                zoomControlsEnabled: true,
                mapType: MapType.normal,
                myLocationEnabled: true,
                onMapCreated: local.onMapCreated,
                markers: local.markers,
              );
            },
          ),
        ),
        textAppBar: "Postos");
  }
}
