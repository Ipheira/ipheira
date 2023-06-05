import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ipheira/models/loja.dart';

class LojaService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String?> cadastrarLoja(Loja loja) async {
    try{
      await firestore.collection("loja").doc(loja.id.toString()).set(loja.toMap());
    } on FirebaseException catch(e) {
      switch (e.code ){
        case "not-found":
          return "Loja não encontrado";
      }
      print(e.code);
      return e.code;

    }
    return null;
  }
}