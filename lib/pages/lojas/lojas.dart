import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipheira/models/loja.dart';
import 'package:ipheira/models/produto.dart';
import 'package:ipheira/utils/image_url.dart';
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
        title: Text(widget.loja.nome_loja),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(ImageUrl.background.value),
            fit: BoxFit.scaleDown,
            alignment: Alignment.bottomCenter,
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(0.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.loja.nome_loja,
                            style: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.loja.endereco_loja,
                          ),
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
            Flexible(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                padding: const EdgeInsets.all(8.0),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: produtos.map((Produto model) {
                  return GestureDetector(
                    onTap: () {
                      // Ação a ser executada ao tocar em um produto
                      print('Produto selecionado: ${model.nome_produto}');
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment:
                                  Alignment.center, // Centralizar o ícone
                              child: const Icon(
                                Icons.panorama_rounded,
                                size: 80,
                                color: Color.fromRGBO(0, 102, 51, 1),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              model.nome_produto,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Quantidade: ${model.quantidade.toString()}",
                                ),
                                Text(
                                  "Preço: ${model.preco.toString()}",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  refresh() async {
    List<Produto> temp = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection("produtos")
        .where("ativo", isEqualTo: true)
        .where("excluir", isEqualTo: false)
        .where("loja", isEqualTo: widget.loja.id)
        .get();

    for (var resp in querySnapshot.docs) {
      Produto produto = Produto(
        id: resp.id,
        nome_produto: resp.data()['nome_produto'],
        preco: double.parse(resp.data()['preco'].toString()),
        quantidade: double.parse(resp.data()['quantidade'].toString()),
        loja: resp.data()['loja'],
        excluir: resp.data()['excluir'],
        ativo: resp.data()['ativo'],
      );
      temp.add(produto);
    }

    setState(() {
      produtos = temp;
    });
  }
}
