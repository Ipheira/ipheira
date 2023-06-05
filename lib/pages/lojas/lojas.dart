import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipheira/models/loja.dart';
import 'package:ipheira/models/produto.dart';
import 'package:ipheira/pages/lojas/home_lojas.dart';
import 'package:ipheira/utils/image_url.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Lojas extends StatefulWidget {
  final Loja loja;

  const Lojas({Key? key, required this.loja}) : super(key: key);

  @override
  State<Lojas> createState() => _LojaState();
}

class _LojaState extends State<Lojas> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Produto> produtos = [];
  @override
  void initState() {
    refresh();
    super.initState();
  }


  _launchWhatsApp() async {
    final whatsappInstalled = await canLaunchUrlString("whatsapp://send");

    if (whatsappInstalled) {
      // Substitua o número de telefone com o número para o qual deseja enviar a mensagem
      // Vamos fazer uma string formated com o número

      final url = "whatsapp://send?phone=+5591981692937";

      await launchUrlString(url);
    } else {
      print("O WhatsApp não está instalado no dispositivo.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Loja"),
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
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  height: 120,
                  color: Color.fromRGBO(153, 232, 157, 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.loja.nome_loja,
                              style: const TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(""),
                            SizedBox(
                              width: 15,
                            ),
                            Text(widget.loja.endereco_loja)
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.message),
                          onPressed: _launchWhatsApp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 220,
                  height: 90,
                  child: ListView(
                    children: List.generate(produtos.length, (index) {
                      Produto model = produtos[index];
                      return GestureDetector(
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
                                      model.nome_produto,
                                      style: const TextStyle(
                                          fontSize: 21, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text("Preço: " + model.preco.toString() + " - Quantidade: " + model.quantidade.toString())
                                  ],
                                ),
                              ]
                            ),
                          ),
                        ),
                      );
                    })
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  refresh() async {
    List<Produto> temp = [];
    print(widget.loja.id);
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection("produtos")
        .where("ativo", isEqualTo: true)
        .where("excluir", isEqualTo: false)
        .where("loja", isEqualTo: widget.loja.id)
        .get();
    print(widget.loja.id);
    for (var resp in querySnapshot.docs) {
      Produto produto = Produto(
          id: resp.id,
          nome_produto: resp.data()['nome_produto'],
          preco: resp.data()['preco'],
          quantidade: resp.data()['quantidade'],
          loja: resp.data()['loja'],
          excluir: resp.data()['excluir'],
          ativo: resp.data()['ativo']);
      temp.add(produto);
      print(produto.nome_produto);

      setState(() {
        produtos = temp;
      });
    }
  }
}
