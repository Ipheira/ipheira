import 'package:flutter/material.dart';
import 'package:ipheira/pages/lojas/loja.dart';
import 'package:ipheira/pages/lojista/lojista.dart';
import 'package:ipheira/utils/image_url.dart';

class HomeLojas extends StatefulWidget {
  const HomeLojas({Key? key}) : super(key: key);

  @override
  State<HomeLojas> createState() => _HomeLojasState();
}

class _HomeLojasState extends State<HomeLojas> {
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
            children: [
              GestureDetector(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (newContext) => Loja())
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
                          children: const [
                            Text(
                              "model.loja",
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("model.desc")
                          ],
                        ),
                      ],
                    ),
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
