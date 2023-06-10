import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipheira/models/comunidade.dart';
import 'package:ipheira/pages/lojas/home_lojas.dart';
import 'package:ipheira/utils/image_url.dart';
import '../../services/cominidade_service.dart';

class HomeComunidades extends StatefulWidget {
  const HomeComunidades({Key? key}) : super(key: key);

  @override
  State<HomeComunidades> createState() => _HomeComunidadesState();
}

class _HomeComunidadesState extends State<HomeComunidades> {
  List<Comunidade> comunidade = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comunidades"),
      ),
      body: (comunidade.isEmpty)
          ? Center(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(ImageUrl.background.value),
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.bottomCenter,
                  ),
                  color: Colors.white,
                ),
                child: const Text(
                  "Nenhuma Comunidade encontrada!\nCadastre uma comunidade primeiramente!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(ImageUrl.background.value),
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.bottomCenter,
                ),
                color: Colors.white,
              ),
              child: ListView.builder(
                itemCount: comunidade.length,
                itemBuilder: (context, index) {
                  Comunidade model = comunidade[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (newContext) => HomeLojas(comunidade: model),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                          height: 90,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.other_houses_rounded,
                                  size: 80,
                                  color: Color.fromRGBO(0, 102, 51, 1),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model.nome_comunidade,
                                      style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      model.endereco_comunidade,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  refresh() async {
    List<Comunidade> temp = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection("comunidades")
        .where("ativo", isEqualTo: true)
        .where("excluir", isEqualTo: false)
        .get();
    for (var resp in querySnapshot.docs) {
      Comunidade com = Comunidade(
        id: resp.id,
        nome_comunidade: resp.data()['nome_comunidade'],
        endereco_comunidade: resp.data()['endereco_comunidade'],
        ativo: resp.data()['ativo'],
        excluir: resp.data()['excluir'],
        numero_de_lojas: resp.data()['numero_de_lojas'],
      );
      temp.add(com);
    }
    setState(() {
      comunidade = temp;
    });
  }
}
