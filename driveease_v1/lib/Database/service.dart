class Service {
  int? id;
  String data;
  double km;
  String servico;
  double valor;

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
}
