class Day {
  int? id;
  String data;
  double startKm;
  double stopKm;
  double ganhos;

  Day({
    this.id,
    required this.data,
    required this.startKm,
    required this.stopKm,
    required this.ganhos,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': data,
      'start_km': startKm,
      'stop_km': stopKm,
      'ganhos': ganhos,
    };
  }
}
