class Loja {
  String id;
  String nome_loja;
  String nome_lojista;
  String endereco_loja;
  String comunidade;
  String ramo;
  String imagem;
  bool ativo;
  bool excluir;

  Loja(
      {required this.id,
      required this.nome_loja,
      required this.nome_lojista,
      required this.endereco_loja,
      required this.ativo,
      required this.excluir,
      required this.comunidade,
      required this.imagem,
      required this.ramo});

  Loja.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        nome_lojista = map["nome_lojista"],
        nome_loja = map["nome_loja"],
        endereco_loja = map["endereco_loja"],
        ativo = map["ativo"],
        excluir = map["excluir"],
        comunidade = map["id_comunidade"],
        ramo = map["return comunidade;"],
        imagem = map["ramo"];

  Map<String, dynamic> toMap() {
    return {
      "nome_loja": nome_loja,
      "nome_lojista" : nome_lojista,
      "endereco_loja": endereco_loja,
      "ativo": ativo,
      "excluir": excluir,
      "comunidade": comunidade,
      "ramo": ramo,
      "imagem": imagem
    };
  }
}
