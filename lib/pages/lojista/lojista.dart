import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ipheira/models/loja.dart';
import 'package:ipheira/services/produto_service.dart';
import 'package:ipheira/utils/image_url.dart';
import 'package:uuid/uuid.dart';

import '../../models/produto.dart';
import '../login/component/show_snackbar.dart';

class Lojista extends StatefulWidget {
  final Loja loja;

  const Lojista({Key? key, required this.loja}) : super(key: key);

  @override
  State<Lojista> createState() => _LojistaState();
}

class _LojistaState extends State<Lojista> {
  List<Produto> produtos = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  ProdutoService produtoService = ProdutoService();

  final TextEditingController nomeProduto = TextEditingController();
  final TextEditingController quantidade = TextEditingController();
  final TextEditingController preco = TextEditingController();

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sua Loja'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Adicionar Produto'),
                content: SizedBox(
                  width: double.maxFinite,
                  height: 230,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          textAlign: TextAlign.start,
                          onChanged: (text) {
                            setState(() {});
                          },
                          controller: nomeProduto,
                          // controller: resetPasswordEmailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            hintText: 'Nome',
                            hintStyle: TextStyle(color: Colors.black),
                            fillColor: Color.fromRGBO(200, 200, 200, 1),
                            filled: true,
                            prefixIcon: Icon(Icons.email),
                          ),
                          // Validação do campo email
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'O valor de nome deve ser preenchido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          textAlign: TextAlign.start,
                          onChanged: (text) {
                            setState(() {});
                          },
                          controller: quantidade,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            hintText: 'Quantidade',
                            hintStyle: TextStyle(color: Colors.black),
                            fillColor: Color.fromRGBO(200, 200, 200, 1),
                            filled: true,
                            prefixIcon: Icon(Icons.email),
                          ),
                          // Validação do campo email
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Digite um número válido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          textAlign: TextAlign.start,
                          onChanged: (text) {
                            setState(() {});
                          },
                          controller: preco,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 0),
                            hintText: 'Preço',
                            hintStyle: TextStyle(color: Colors.black),
                            fillColor: Color.fromRGBO(200, 200, 200, 1),
                            filled: true,
                            prefixIcon: Icon(Icons.email),
                          ),
                          // Validação do campo email
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Digite um número válido';
                            }
                            return null;
                          },
                        ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        // TextFormField(
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Insira uma URL de imagem!';
                        //     }
                        //     return null;
                        //   },
                        //   onChanged: (text) {
                        //     setState(() {});
                        //   },
                        //   keyboardType: TextInputType.url,
                        //   // controller: imageController,
                        //   textAlign: TextAlign.center,
                        //   decoration: const InputDecoration(
                        //     border: OutlineInputBorder(),
                        //     hintText: 'Imagem',
                        //     fillColor: Colors.white70,
                        //     filled: true,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      _createProduto(
                          name: nomeProduto.text,
                          preco: preco.text,
                          quantidade: quantidade.text);
                      refresh();
                      limparController();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Enviar'),
                  ),
                  TextButton(
                    onPressed: () {
                      refresh();
                      limparController();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
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
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Atualizar Produto'),
                                  content: SizedBox(
                                    width: double.maxFinite,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            textAlign: TextAlign.start,
                                            onChanged: (text) {
                                              setState(() {});
                                            },
                                            // controller: resetPasswordEmailController,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 5),
                                              hintText: 'Nome',
                                              hintStyle: TextStyle(
                                                  color: Colors.black),
                                              fillColor: Color.fromRGBO(
                                                  200, 200, 200, 1),
                                              filled: true,
                                              prefixIcon: Icon(Icons.email),
                                            ),
                                            // Validação do campo email
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'O valor de email deve ser preenchido';
                                              }
                                              if (!value.contains('@') ||
                                                  !value.contains('.') ||
                                                  value.length < 4) {
                                                return 'O email deve ser válido';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          TextFormField(
                                            textAlign: TextAlign.start,
                                            keyboardType: TextInputType.number,
                                            onChanged: (text) {
                                              setState(() {});
                                            },
                                            // controller: resetPasswordEmailController,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 5),
                                              hintText: 'Quantidade',
                                              hintStyle: TextStyle(
                                                  color: Colors.black),
                                              fillColor: Color.fromRGBO(
                                                  200, 200, 200, 1),
                                              filled: true,
                                              prefixIcon: Icon(Icons.email),
                                            ),
                                            // Validação do campo email
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'O valor de email deve ser preenchido';
                                              }
                                              if (!value.contains('@') ||
                                                  !value.contains('.') ||
                                                  value.length < 4) {
                                                return 'O email deve ser válido';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Enviar'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'Cancelar',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.mode_edit_outline_outlined)),
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
                        padding: const EdgeInsets.only(left: 5.0),
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
                            const SizedBox(height: 2),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Quantidade: ${model.quantidade.toString()}",
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Atualizar Produto'),
                                                content: SizedBox(
                                                  width: double.maxFinite,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        TextFormField(
                                                          textAlign:
                                                              TextAlign.start,
                                                          onChanged: (text) {
                                                            setState(() {});
                                                          },
                                                          // controller: resetPasswordEmailController,
                                                          decoration:
                                                              const InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            8,
                                                                        vertical:
                                                                            5),
                                                            hintText: 'Nome',
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                            fillColor:
                                                                Color.fromRGBO(
                                                                    200,
                                                                    200,
                                                                    200,
                                                                    1),
                                                            filled: true,
                                                            prefixIcon: Icon(
                                                                Icons.email),
                                                          ),
                                                          // Validação do campo email
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return 'O valor de email deve ser preenchido';
                                                            }
                                                            if (!value.contains('@') ||
                                                                !value.contains(
                                                                    '.') ||
                                                                value.length <
                                                                    4) {
                                                              return 'O email deve ser válido';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        TextFormField(
                                                          textAlign:
                                                              TextAlign.start,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          onChanged: (text) {
                                                            setState(() {});
                                                          },
                                                          // controller: resetPasswordEmailController,
                                                          decoration:
                                                              const InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            8,
                                                                        vertical:
                                                                            5),
                                                            hintText:
                                                                'Quantidade',
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                            fillColor:
                                                                Color.fromRGBO(
                                                                    200,
                                                                    200,
                                                                    200,
                                                                    1),
                                                            filled: true,
                                                            prefixIcon: Icon(
                                                                Icons.email),
                                                          ),
                                                          // Validação do campo email
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value.isEmpty) {
                                                              return 'O valor de email deve ser preenchido';
                                                            }
                                                            if (!value.contains('@') ||
                                                                !value.contains(
                                                                    '.') ||
                                                                value.length <
                                                                    4) {
                                                              return 'O email deve ser válido';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('Enviar'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      'Cancelar',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                            Icons.mode_edit_outline_outlined))
                                  ],
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

  void limparController() {
    nomeProduto.clear();
    preco.clear();
    quantidade.clear();
  }

  String _createProduto(
      {required String name,
      required String preco,
      required String quantidade}) {
    String produtoId = const Uuid().v1();

    print("antes do registro no firebase: " + produtoId);

    Produto newProduto = Produto(
        id: produtoId,
        nome_produto: name,
        preco: double.parse(preco),
        quantidade: double.parse(preco),
        loja: widget.loja.id,
        excluir: false,
        ativo: true);

    produtoService.cadastrarProduto(newProduto).then((String? erro) {
      if (erro == null) {
        showSnackBar(
            context: context,
            mensagem: "Loja Cadastrado com sucesso!",
            isErro: false);
        return newProduto.id;
      } else {
        showSnackBar(context: context, mensagem: erro);
        return erro;
      }
    });

    print('Antes do retorno: ${newProduto.id.toString()}');
    return newProduto.id.toString();
  }

  refresh() async {
    List<Produto> temp = [];

    print(widget.loja.nome_loja);

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection("produtos")
        .where("ativo", isEqualTo: true)
        .where("excluir", isEqualTo: false)
        .where("loja", isEqualTo: widget.loja.id)
        .get();

    for (var resp in querySnapshot.docs) {
      dynamic precoValue = resp.data()['preco'];
      double preco = precoValue is int ? precoValue.toDouble() : precoValue;

      dynamic quantidadeValue = resp.data()['quantidade'];
      double quantidade =
          quantidadeValue is int ? quantidadeValue.toDouble() : quantidadeValue;

      Produto produto = Produto(
          id: resp.id,
          nome_produto: resp.data()['nome_produto'],
          preco: preco,
          quantidade: quantidade,
          loja: resp.data()['loja'],
          excluir: resp.data()['excluir'],
          ativo: resp.data()['ativo']);
      temp.add(produto);
    }

    setState(() {
      produtos = temp;
    });
  }
}
