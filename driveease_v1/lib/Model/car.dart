class Car {
  int? idCarro;
  late String descricao;

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

  static Car fromMap(Map<String, dynamic> map) {
    return Car(
      idCarro: map['id_carro'],
      descricao: map['descricao'],
    );
  }
}
