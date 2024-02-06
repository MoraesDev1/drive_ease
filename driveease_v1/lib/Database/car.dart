class Car {
  int? idCarro;
  String descricao;

  Car({
    this.idCarro,
    required this.descricao,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_carro': idCarro,
      'descricao': descricao,
    };
  }
}
