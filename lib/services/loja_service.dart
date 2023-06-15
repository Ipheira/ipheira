import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ipheira/models/loja.dart';

class LojaService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String?> cadastrarLoja(Loja loja) async {
    try {
      await firestore
          .collection("loja")
          .doc(loja.id.toString())
          .set(loja.toMap());
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

  Future<Loja?> findLoja(String idDoc) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firestore.collection("loja").doc(idDoc).get();
    Loja loja = Loja(
        id: documentSnapshot.id,
        nome_loja: documentSnapshot.data()!["nome_loja"],
        nome_lojista: documentSnapshot.data()!["nome_lojista"],
        endereco_loja: documentSnapshot.data()!['endereco_loja'],
        ativo: documentSnapshot.data()!["ativo"],
        excluir: documentSnapshot.data()!['excluir'],
        comunidade: documentSnapshot.data()!['comunidade'],
        imagem: documentSnapshot.data()!['imagem'],
        ramo: documentSnapshot.data()!['ramo']);

    print(loja);
    return loja;
  }

  Future<Loja?> findLojaByEmail(String email) async {
    QuerySnapshot<Map<String, dynamic>> documentSnapshot = await firestore
        .collection("loja")
        .where(email, isEqualTo: "email")
        .get();
    Loja loja = Loja.fromMap(documentSnapshot.docs.first.data());
    return loja;
  }
}
