import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ipheira/models/produto.dart';

class ProdutoService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String?> cadastrarProduto(Produto produto) async {
    try {
      await firestore
          .collection("produtos")
          .doc(produto.id.toString())
          .set(produto.toMap());
    } on FirebaseException catch (e) {
      switch (e.code) {
        case "not-found":
          return "Loja não encontrado";
      }
      print(e.code);
      return e.code;
    }
    return null;
  }
}