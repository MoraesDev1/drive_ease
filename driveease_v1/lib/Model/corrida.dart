class Corrida {
  int? id;
  // late int idCarro;
  late String dataHoraStart;
  late double startKm;
  late String dataHoraStop;
  late double stopKm;
  late double ganhos;

  Corrida.start({
    required this.dataHoraStart,
    required this.startKm,
  });

  Corrida.stop({
    this.id,
    // required this.idCarro,
    required this.dataHoraStart,
    required this.startKm,
    required this.dataHoraStop,
    required this.stopKm,
    required this.ganhos,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      // 'id_carro': idCarro,
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

  static Corrida fromMap(Map<String, dynamic> map) {
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
