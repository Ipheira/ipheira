import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ipheira/models/comunidade.dart';

class ComunidadeService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Comunidade>> getComunidades() async {
    List<Comunidade> temp = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection("comunidades")
        .where("ativo", isEqualTo: true)
        .where("excluir", isEqualTo: false)
        .get();
    for (var resp in querySnapshot.docs) {
      temp.add(Comunidade.fromMap(resp.data()));
    }
    print(temp);
    return temp;
  }

  Future<Comunidade> findById(String id_comunidade) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('loja')
        .where('id_comunidade', isEqualTo: id_comunidade)
        .where("ativo", isEqualTo: true)
        .where("excluir", isEqualTo: false)
        .get();
    Comunidade comunidade = Comunidade.fromMap(querySnapshot.docs.first.data());
    return comunidade;
  }
}
