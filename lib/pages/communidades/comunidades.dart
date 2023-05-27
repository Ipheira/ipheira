import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipheira/models/comunidade.dart';
import 'package:ipheira/pages/lojas/lojas.dart';

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
    // TODO: implement initState
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Comunidades"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            refresh();
          },
          child: const Icon(Icons.add),
        ),
        body: (comunidade.isEmpty)
            ? const Center(
                child: Text(
                  "Nenhuma Comunidade encontrada!\nCadastre uma comunidade primeiramente!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              )
            : ListView(
                children: List.generate(comunidade.length, (index) {
                Comunidade model = comunidade[index];
                return GestureDetector(
                    onTap: () => {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (newContext) => Lojas()
                    ))},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 220,
                      height: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.other_houses_rounded, size: 80, color: Color.fromRGBO(0, 102, 51, 1)),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(model.nome_comunidade,
                                style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 15,),
                              Text(model.endereco_comunidade)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })));
  }

  // ListTile(
  // leading: const Icon(Icons.list_alt_rounded),
  // title: Text(model.nome_comunidade),
  // subtitle: Text(model.nome_comunidade),
  // );

  refresh() async {
    List<Comunidade> temp = [];
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("comunidades").get();
    for (var doc in snapshot.docs) {
      print(doc.data());
      temp.add(Comunidade.fromMap(doc.data()));
    }
    ;

    setState(() {
      comunidade = temp;
    });
  }
}
