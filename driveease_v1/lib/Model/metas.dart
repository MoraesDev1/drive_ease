class Meta {
  int? id;
  String inicio;
  String fim;
  double valor;
  String descricao;

  Meta(
      {this.id,
      required this.inicio,
      required this.fim,
      required this.valor,
      this.descricao = ''});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'inicio': inicio,
      'fim': fim,
      'valor': valor,
      'descricao': descricao,
    };
  }

  static Meta fromMap(Map<String, dynamic> map) {
    return Meta(
      id: map['id'],
      inicio: map['inicio'],
      fim: map['fim'],
      valor: map['valor'],
      descricao: map['descricao'],
    );
  }
}
