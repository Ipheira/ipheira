import 'package:uuid/uuid.dart';

class Usuario {
  String id_usuario;
  String id_loja;
  int tipo_usuario;
  String nome_usuario;
  String data_nasc;
  String email_usuario;
  String senha;
  String telefone_usuario;
  bool ativo;
  bool excluir;

  Usuario({required this.id_usuario,
    required this.id_loja,
    required this.tipo_usuario,
    required this.nome_usuario,
    required this.data_nasc,
    required this.email_usuario,
    required this.senha,
    required this.telefone_usuario,
    required this.ativo,
    required this.excluir});

  Usuario.fromMap(Map<String, dynamic> map)
      : id_usuario = map["id_usuario"],
        id_loja = map["id_loja"],
        tipo_usuario = map["tipo_usuario"],
        nome_usuario = map["nome_usuario"],
        data_nasc = map["data_nasc"],
        email_usuario = map["email_usuario"],
        senha = map["senha"],
        telefone_usuario = map["telefone_usuario"],
        ativo = map["ativo"],
        excluir = map["excluir"];

  Map<String, dynamic> toMap() {
    return {
      "id_usuario" : id_usuario,
      "id_loja" : id_loja,
      "tipo_usuario" : tipo_usuario,
      "nome_usuario" : nome_usuario,
      "data_nasc" : data_nasc,
      "email_usuario" : email_usuario,
      "senha" : senha,
      "telefone_usuario" : telefone_usuario,
      "ativo" : ativo,
      "excluir" : excluir,
    };
  }
}