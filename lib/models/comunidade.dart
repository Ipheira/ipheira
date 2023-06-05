class Comunidade {
  String id;
  String nome_comunidade;
  String endereco_comunidade;
  bool ativo;
  bool excluir;
  int numero_de_lojas;

  Comunidade(
      {required this.id,
      required this.nome_comunidade,
      required this.endereco_comunidade,
      required this.ativo,
      required this.excluir,
      required this.numero_de_lojas});

  Comunidade.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        nome_comunidade = map["nome_comunidade"],
        endereco_comunidade = map["endereco_comunidade"],
        ativo = map["ativo"],
        excluir = map["excluir"],
        numero_de_lojas = map["numero_de_lojas"];

  Map<String, dynamic> toMap() {
    return {
     // "id": id,
      "nome_comunidade": nome_comunidade,
      "endereco_comunidade": endereco_comunidade,
      "ativo": ativo,
      "excluir": excluir,
      "numero_de_lojas": numero_de_lojas
    };
  }
}
