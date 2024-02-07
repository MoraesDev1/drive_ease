class Service {
  int? id;
  late String data;
  late double km;
  late String servico;
  late double valor;

  Service({
    this.id,
    required this.data,
    required this.km,
    required this.servico,
    required this.valor,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'data': data,
      'km': km,
      'servico': servico,
      'valor': valor,
    };
  }

  static Service fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id'],
      data: map['data'],
      km: map['km'],
      servico: map['servico'],
      valor: map['valor'],
    );
  }
}
