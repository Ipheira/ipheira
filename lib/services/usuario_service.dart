import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ipheira/models/usuario.dart';

class UsuarioService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String?> cadastrarUsuario(Usuario usuario) async {
    try {
      await firestore
          .collection("usuario")
          .doc(usuario.id_usuario.toString())
          .set(usuario.toMap());
    } on FirebaseException catch (e) {
      switch (e.code) {
        case "not-found":
          return "Usuário não encontrado";
      }
      print(e.code);
      return e.code;
    }
    return null;
  }

  Future<Usuario?> findTipoUsuario(String email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection("usuario")
          .where("email_usuario", isEqualTo: email)
          .get();
      // if(querySnapshot.docs.isNotEmpty){
      //   print("Não tá vazio");
      // }
      Usuario usuario = Usuario.fromMap(querySnapshot.docs.first.data());
      print(usuario.nome_usuario);
      return usuario;
    } on FirebaseException catch(e) {
      print("Usuário não encontrado");
      return null;
    }

  }
}
