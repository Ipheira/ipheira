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
}
