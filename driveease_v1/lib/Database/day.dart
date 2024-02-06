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
      'id_carro': idCarro,
      'datahora_start': dataHoraStart,
      'start_km': startKm,
      'datahora_stop': dataHoraStop,
      'stop_km': stopKm,
      'ganhos': ganhos,

    };
  }
}
