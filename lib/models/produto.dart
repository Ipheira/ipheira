class Produto {
  String id;
  String nome_produto;
  double preco;
  double quantidade;
  String loja;
  bool ativo;
  bool excluir;

  Produto(
      {required this.id,
      required this.nome_produto,
      required this.preco,
      required this.quantidade,
      required this.loja,
      required this.excluir,
      required this.ativo});

  Produto.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        nome_produto = map["nome_produto"],
        preco = map["preco"],
        quantidade = map["quantidade"],
        loja = map["quantidade"],
        ativo = map["ativo"],
        excluir = map["excluir"];

  Map<String, dynamic> toMap() {
    return {
      "nome_produto": nome_produto,
      "preco": preco,
      "ativo": ativo,
      "excluir": excluir,
      "quantidade": quantidade,
      "loja": loja
    };
  }
}
