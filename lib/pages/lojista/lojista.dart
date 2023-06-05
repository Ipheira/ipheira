import 'package:flutter/material.dart';
import 'package:ipheira/utils/image_url.dart';

class Lojista extends StatefulWidget {
  const Lojista({Key? key}) : super(key: key);

  @override
  State<Lojista> createState() => _LojistaState();
}

class _LojistaState extends State<Lojista> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lojista"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Adicionar Produto'),
              content: SizedBox(
                width: double.maxFinite,
                height: 180,
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
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          hintText: 'Nome',
                          hintStyle: TextStyle(color: Colors.black),
                          fillColor:
                          Color.fromRGBO(200, 200, 200, 1),
                          filled: true,
                          prefixIcon: Icon(Icons.email),
                        ),
                        // Validação do campo email
                        validator: (value) {
                          if (value == null || value.isEmpty) {
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
                      const SizedBox(height: 8,),
                      TextFormField(
                        textAlign: TextAlign.start,
                        onChanged: (text) {
                          setState(() {});
                        },
                        // controller: resetPasswordEmailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          hintText: 'Quantidade',
                          hintStyle: TextStyle(color: Colors.black),
                          fillColor:
                          Color.fromRGBO(200, 200, 200, 1),
                          filled: true,
                          prefixIcon: Icon(Icons.email),
                        ),
                        // Validação do campo email
                        validator: (value) {
                          if (value == null || value.isEmpty) {
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
                      const SizedBox(height: 8,),
                      TextFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Insira uma URL de imagem!';
                          }
                          return null;
                        },
                        onChanged: (text){
                          setState(() {});
                        },
                        keyboardType: TextInputType.url,
                        // controller: imageController,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Imagem',
                          fillColor: Colors.white70,
                          filled: true,
                        ),
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
        child: const Icon(Icons.add, color: Colors.white,),
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
                  color: const Color.fromRGBO(153, 232, 157, 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "NOME DA LOJA",
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("Nome do proprietário"),
                            SizedBox(
                              width: 15,
                            ),
                            Text("model.desc")
                          ],
                        ),
                        IconButton(onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: const Text('Atualizar Loja'),
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
                                              contentPadding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 5),
                                              hintText: 'Descrição',
                                              hintStyle: TextStyle(color: Colors.black),
                                              fillColor:
                                              Color.fromRGBO(200, 200, 200, 1),
                                              filled: true,
                                              prefixIcon: Icon(Icons.email),
                                            ),
                                            // Validação do campo email
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
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
                                          const SizedBox(height: 8,),
                                          TextFormField(
                                            textAlign: TextAlign.start,
                                            onChanged: (text) {
                                              setState(() {});
                                            },
                                            // controller: resetPasswordEmailController,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              contentPadding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 5),
                                              hintText: 'Telefone',
                                              hintStyle: TextStyle(color: Colors.black),
                                              fillColor:
                                              Color.fromRGBO(200, 200, 200, 1),
                                              filled: true,
                                              prefixIcon: Icon(Icons.email),
                                            ),
                                            // Validação do campo email
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
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
                          icon: const Icon(Icons.mode_edit_outline_outlined)
                        )
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.storefront_outlined,
                          size: 80, color: Color.fromRGBO(0, 102, 51, 1)),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Row(
                            children: [
                              const Text(
                                "model.produto",
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
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
                                                      contentPadding: EdgeInsets.symmetric(
                                                          horizontal: 8, vertical: 5),
                                                      hintText: 'Nome',
                                                      hintStyle: TextStyle(color: Colors.black),
                                                      fillColor:
                                                      Color.fromRGBO(200, 200, 200, 1),
                                                      filled: true,
                                                      prefixIcon: Icon(Icons.email),
                                                    ),
                                                    // Validação do campo email
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
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
                                                  const SizedBox(height: 8,),
                                                  TextFormField(
                                                    textAlign: TextAlign.start,
                                                    keyboardType:  TextInputType.number,
                                                    onChanged: (text) {
                                                      setState(() {});
                                                    },
                                                    // controller: resetPasswordEmailController,
                                                    decoration: const InputDecoration(
                                                      border: OutlineInputBorder(),
                                                      contentPadding: EdgeInsets.symmetric(
                                                          horizontal: 8, vertical: 5),
                                                      hintText: 'Quantidade',
                                                      hintStyle: TextStyle(color: Colors.black),
                                                      fillColor:
                                                      Color.fromRGBO(200, 200, 200, 1),
                                                      filled: true,
                                                      prefixIcon: Icon(Icons.email),
                                                    ),
                                                    // Validação do campo email
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
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
                                  icon: const Icon(Icons.mode_edit_outline_outlined)
                              )
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Preço: 1 / qtd: 1"),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}