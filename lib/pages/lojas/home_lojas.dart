import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipheira/models/comunidade.dart';
import 'package:ipheira/models/loja.dart';
import 'package:ipheira/pages/lojas/lojas.dart';
import 'package:ipheira/utils/image_url.dart';

class HomeLojas extends StatefulWidget {
  final Comunidade comunidade;

  const HomeLojas({Key? key, required this.comunidade}) : super(key: key);

  @override
  State<HomeLojas> createState() => _HomeLojasState();
}

class _HomeLojasState extends State<HomeLojas> {
  List<Loja> lojas = [];
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
        title: const Text("Lojas"),
      ),
      body: Center(
        child: Container(
          height: 1000,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(ImageUrl.background.value),
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.bottomCenter // alterado aqui
                  ),
              color: Colors.white),
          child: ListView(
            children: List.generate(lojas.length, (index) {
              Loja model = lojas[index];
              return GestureDetector(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (newContext) => Lojas(loja : model))
                      // MaterialPageRoute(builder: (newContext) => Lojista())
                      )
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 220,
                    height: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.storefront_outlined,
                            size: 80, color: Color.fromRGBO(0, 102, 51, 1)),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              model.nome_loja,
                              style: const TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(model.endereco_loja)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  refresh() async {
    List<Loja> temp = [];
    print(widget.comunidade.nome_comunidade);
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection("loja")
        .where("ativo", isEqualTo: true)
        .where("excluir", isEqualTo: false)
        .where("comunidade", isEqualTo: widget.comunidade.id)
        .get();
    for (var resp in querySnapshot.docs) {
      Loja loja = Loja(
          id: resp.id,
          nome_loja: resp.data()['nome_loja'],
          endereco_loja: resp.data()['endereco_loja'],
          ativo: resp.data()['ativo'],
          excluir: resp.data()['excluir'],
          comunidade: resp.data()['comunidade'],
          imagem: resp.data()['imagem'],
          ramo: resp.data()['ramo']);
      temp.add(loja);

      setState(() {
        lojas = temp;
      });
    }
  }
}
