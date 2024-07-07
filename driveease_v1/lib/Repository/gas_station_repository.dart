import 'package:driveease_v1/Model/gas_station.dart';
import 'package:flutter/material.dart';

class GasStationRepository extends ChangeNotifier {
  final List<GasStation> gasStation = [
    GasStation(
      name: "Posto Shell",
      adress: "Av. Lisboa, 122 - Itoupava Norte, Blumenau - SC",
      cep: "89052-600",
      photo:
          "https://lh5.googleusercontent.com/p/AF1QipPT5Mw_lgVfeTOFADGbZxGWcgmBs0CEGEw_OXyV=w408-h306-k-no",
      latitude: -26.8848132393048,
      longitude: -49.08224505026461,
    ),
    GasStation(
      name: "Posto Bela Jóia - 2",
      adress: "R. São Paulo, 2423 - Itoupava Seca, Blumenau - SC",
      cep: "89030-000",
      photo:
          "https://lh5.googleusercontent.com/p/AF1QipMrZvVy7Xl2klN98FGtUuilyvBKrS-FJ570Sko=w408-h306-k-no",
      latitude: -26.895070994238825,
      longitude: -49.07967012954099,
    ),
    GasStation(
      name: "Posto R1",
      adress: "R. Bahia, 5215 - Salto Weissbach, Blumenau - SC",
      cep: "89032-000",
      photo:
          "https://lh5.googleusercontent.com/p/AF1QipObLqQoh15Fez5LhtGC-pj8Vg-eThQ8wHZabgfR=w408-h408-k-no",
      latitude: -26.889651267793266,
      longitude: -49.12657948352109,
    ),
  ];
}
