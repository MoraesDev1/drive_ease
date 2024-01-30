class Day {
  int? id;
  int idCarro;
  String dataHoraStart;
  double startKm;
  String dataHoraStop;
  double stopKm;
  double ganhos;

  Day({
    this.id,
    required this.idCarro,
    required this.dataHoraStart,
    required this.startKm,
    required this.dataHoraStop,
    required this.stopKm,
    required this.ganhos,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': dataHoraStart,
      'start_km': startKm,
      'stop_km': stopKm,
      'ganhos': ganhos,
    };
  }
}
