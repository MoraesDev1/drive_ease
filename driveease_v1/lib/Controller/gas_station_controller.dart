import 'package:driveease_v1/Pages/Display/gas_station_details.dart';
import 'package:driveease_v1/Pages/Display/gas_station_page.dart';
import 'package:driveease_v1/Repository/gas_station_repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GasStationController extends ChangeNotifier {
  double lat = 0.0;
  double long = 0.0;
  String erro = '';
  Set<Marker> markers = <Marker>{};
  late GoogleMapController _mapsController;

  get mapsController => _mapsController;

  onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    getPosition();
    loadGasStations();
  }

  loadGasStations() {
    final gasStations = GasStationRepository().gasStation;
    gasStations.forEach(
      (gasStation) async {
        markers.add(
          Marker(
            markerId: MarkerId(gasStation.name),
            position: LatLng(gasStation.latitude, gasStation.longitude),
            icon: AssetMapBitmap(
              "Assets/gas-station.png",
              imagePixelRatio: 12,
            ),
            onTap: () {
              showModalBottomSheet(
                context: appKey.currentState!.context,
                builder: (context) => GasStationDetails(gasStation: gasStation),
              );
            },
          ),
        );
      },
    );

    notifyListeners();
  }

  getPosition() async {
    try {
      Position position = await _currentPosition();
      lat = position.latitude;
      long = position.longitude;
      _mapsController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
    } catch (e) {
      erro = e.toString();
    }
    notifyListeners();
  }

  Future<Position> _currentPosition() async {
    LocationPermission permission;

    bool activated = await Geolocator.isLocationServiceEnabled();
    if (!activated) {
      return Future.error("Por favor, habilite a localização no seu celular");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Você precisa autorizar o acesso a localização");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Você precisa autorizar o acesso a localização");
    }

    return await Geolocator.getCurrentPosition();
  }
}
