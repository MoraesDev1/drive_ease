class Corrida {
  int? id;
  String dataHoraStart;
  double startKm;
  String? dataHoraStop;
  double? stopKm;
  double? ganhos;

  Corrida.start({
    required this.dataHoraStart,
    required this.startKm,
  });

  Corrida.stop({
    this.id,
    required this.dataHoraStart,
    required this.startKm,
    required this.dataHoraStop,
    required this.stopKm,
    required this.ganhos,
  });

  Map<String, dynamic> toMapStart() {
    return {
      'datahora_start': dataHoraStart,
      'start_km': startKm,
    };
  }

  Map<String, dynamic> toMapStop() {
    return {
      'id': id,
      'datahora_start': dataHoraStart,
      'start_km': startKm,
      'datahora_stop': dataHoraStop,
      'stop_km': stopKm,
      'ganhos': ganhos,
    };
  }

  static Corrida fromMapStart(Map<String, dynamic> map) {
    return Corrida.start(
      dataHoraStart: map['datahora_start'],
      startKm: map['start_km'],
    );
  }

  static Corrida fromMapStop(Map<String, dynamic> map) {
    return Corrida.stop(
      id: map['id'],
      dataHoraStart: map['datahora_start'],
      startKm: map['start_km'],
      dataHoraStop: map['datahora_start'],
      stopKm: map['stop_km'],
      ganhos: map['ganhos'],
    );
  }
}
