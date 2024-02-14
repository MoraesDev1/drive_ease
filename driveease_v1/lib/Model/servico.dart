class Servico {
  int? id;
  late String tipoDoServico;
  late String data;
  late double km;
  late String descricao;
  late double valor;

  Servico({
    this.id,
    required this.tipoDoServico,
    required this.data,
    required this.km,
    required this.descricao,
    required this.valor,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipo': tipoDoServico,
      'data': data,
      'km': km,
      'descricao': descricao,
      'valor': valor,
    };
  }

  static Servico fromMap(Map<String, dynamic> map) {
    return Servico(
      id: map['id'],
      tipoDoServico: map['tipo'],
      data: map['data'],
      km: map['km'],
      descricao: map['descricao'],
      valor: map['valor'],
    );
  }
}
