import 'package:flutter/material.dart';
import 'package:ipheira/pages/lojas/home_lojas.dart';
import 'package:ipheira/utils/image_url.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';


class Loja extends StatefulWidget {
  const Loja({Key? key}) : super(key: key);

  @override
  State<Loja> createState() => _LojaState();
}

class _LojaState extends State<Loja> {

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
                            "model.produto",
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text("Preço: 1 - qtd: 1")
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
