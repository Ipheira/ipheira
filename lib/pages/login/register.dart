import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ipheira/models/usuario.dart';
import 'package:ipheira/pages/login/component/show_snackbar.dart';
import 'package:ipheira/services/auth_service.dart';
import 'package:ipheira/services/usuario_service.dart';
import 'package:ipheira/utils/image_url.dart';
import 'package:uuid/uuid.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  //controllers gerais
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  //controllers específicos de lojista
  final TextEditingController storeNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  //controllers específicos de cliente
  final TextEditingController birthdayController = TextEditingController();

  //final TextEditingController documentController = TextEditingController();

  int userTypeController = 0;
  bool showPassword = false;
  bool showConfirmPassword = false;

  final _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  UsuarioService usuarioService = UsuarioService();

  final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: 200,
                  width: 225,
                  child: Image.network(
                    ImageUrl.logo.value,
                    fit: BoxFit.fill,
                  ),
                ),
                const Text(
                  "Crie Sua Conta",
                  style: TextStyle(fontSize: 20),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListTile(
                          title: const Text("Cliente"),
                          minLeadingWidth: 0,
                          leading: Radio<int>(
                            value: 0, // 0 => para Cliente
                            groupValue: userTypeController,
                            onChanged: (value) {
                              setState(() {
                                userTypeController = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left:
                                  10), // Adicionado um padding para compensar o comprimento diferente do título
                          child: ListTile(
                            title: const Text("Lojista"),
                            minLeadingWidth: 0,
                            leading: Radio<int>(
                              value: 1, // 1 => para Lojista
                              groupValue: userTypeController,
                              onChanged: (value) {
                                setState(() {
                                  userTypeController = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    controller: nameController,
                    obscureText: false,
                    onChanged: (text) {
                      setState(() {});
                    },
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                        border: OutlineInputBorder(),
                        hintText: 'Nome Completo',
                        hintStyle: TextStyle(color: Colors.black),
                        fillColor: Color.fromRGBO(200, 200, 200, 1),
                        filled: true,
                        prefixIcon: Icon(Icons.person)),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "O campo deve ser preenchido!";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    controller: emailController,
                    obscureText: false,
                    onChanged: (text) {
                      setState(() {});
                    },
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      border: OutlineInputBorder(),
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.black),
                      fillColor: Color.fromRGBO(200, 200, 200, 1),
                      filled: true,
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "O valor de email deve ser preenchido";
                      }
                      if (!emailRegex.hasMatch(value!)) {
                        return "O email deve ser válido";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    controller: phoneController,
                    onChanged: (text) {
                      setState(() {});
                    },
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                        border: OutlineInputBorder(),
                        hintText: 'Número de Telefone',
                        hintStyle: TextStyle(color: Colors.black),
                        fillColor: Color.fromRGBO(200, 200, 200, 1),
                        filled: true,
                        prefixIcon: Icon(Icons.phone)),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'O campo de telefone é obrigatório!';
                      }
                      return null;
                    },
                  ),
                ),
                IndexedStack(
                  index: userTypeController,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        controller: birthdayController,
                        onChanged: (text) {
                          setState(() {});
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          DataInputFormatter(),
                        ],
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            border: OutlineInputBorder(),
                            hintText: 'Data de Nascimento',
                            hintStyle: TextStyle(color: Colors.black),
                            fillColor: Color.fromRGBO(200, 200, 200, 1),
                            filled: true,
                            prefixIcon: Icon(Icons.calendar_month)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            print("Tá vazio");
                            return "O campo precisa ser preenchido!";
                          }
                          return null;
                        },
                      ),
                    ),
                    // Nome da loja
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        controller: storeNameController,
                        onChanged: (text) {
                          setState(() {});
                        },
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            border: OutlineInputBorder(),
                            hintText: 'Nome da Loja',
                            hintStyle: TextStyle(color: Colors.black),
                            fillColor: Color.fromRGBO(200, 200, 200, 1),
                            filled: true,
                            prefixIcon: Icon(Icons.store)),
                        validator: (value) {
                          if (userTypeController == 1) {
                            if (value == null || value.isEmpty) {
                              return "O campo precisa ser preenchido!";
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                // Senha
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    controller: passwordController,
                    obscureText: !showPassword,
                    onChanged: (text) {
                      setState(() {});
                    },
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 8),
                      border: const OutlineInputBorder(),
                      hintText: 'Senha',
                      hintStyle: const TextStyle(color: Colors.black),
                      fillColor: const Color.fromRGBO(200, 200, 200, 1),
                      filled: true,
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: showPassword
                              ? Colors.green
                              : Color.fromRGBO(104, 104, 104, 1),
                        ),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Por favor, digite uma senha.';
                      }
                      if (value!.length < 6) {
                        return 'A senha deve ter pelo menos 6 caracteres.';
                      }
                      return null;
                    },
                  ),
                ),
                // Confirmar Senha
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    controller: confirmPasswordController,
                    obscureText: !showConfirmPassword,
                    onChanged: (text) {
                      setState(() {});
                    },
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 8),
                      border: const OutlineInputBorder(),
                      hintText: 'Confirmar Senha',
                      hintStyle: const TextStyle(color: Colors.black),
                      fillColor: const Color.fromRGBO(200, 200, 200, 1),
                      filled: true,
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          showConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            showConfirmPassword = !showConfirmPassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Por favor, confirme sua senha.';
                      }
                      if (value != passwordController.text) {
                        return 'As senhas não coincidem.';
                      }
                      return null;
                    },
                  ),
                ),
                //birthday
                IndexedStack(
                  index: userTypeController,
                  children: <Widget>[
                    Container(
                      width: 0,
                      height: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      child: TextFormField(
                        textAlign: TextAlign.start,
                        controller: birthdayController,
                        onChanged: (text) {
                          setState(() {});
                        },
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            border: OutlineInputBorder(),
                            hintText: 'Endereço da loja',
                            hintStyle: TextStyle(color: Colors.black),
                            fillColor: Color.fromRGBO(200, 200, 200, 1),
                            filled: true,
                            prefixIcon: Icon(Icons.map)),
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return "O campo precisa ser preenchido";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                // Botão Cadastro
                ElevatedButton(
                    onPressed: () {
                      // print(emailController.text);
                      // print(birthdayController.text);
                      if (_formKey.currentState!.validate()) {
                        print("Validou");
                        _createUser(
                            email: emailController.text,
                            senha: passwordController.text,
                            nome: nameController.text);
                        _registerUser(
                            fullName: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            phone: phoneController.text,
                            storeName: storeNameController.text,
                            address: addressController.text,
                            typeUser: userTypeController,
                            birthdayDate: birthdayController.text);

                        // if (userTypeController == 0) {
                        //   _registerUser(
                        //       fullName: nameController.text,
                        //       email: emailController.text,
                        //       phone: phoneController.text,
                        //       birthdayDate: birthdayController.text);
                        // } else {
                        //   _createStore(
                        //       fullName: nameController.text,
                        //       email: emailController.text,
                        //       phone: phoneController.text,
                        //       storeName: storeNameController.text,
                        //       address: addressController.text);
                        // }
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Usuário cadastrado com Sucesso!")));
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Cadastrar")),
                const SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Faça Login',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(0, 102, 51, 1)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  _createStore(
      {required String fullName,
      required String email,
      required String phone,
      required String storeName,
      required String address}) {
    //TODO
  }

  _registerUser(
      {required String fullName,
      required String email,
      required String password,
      required String phone,
      required String storeName,
      required String address,
      required int typeUser,
      required String birthdayDate}) {
    Usuario usuario = Usuario(
        id_usuario: const Uuid().v1(),
        id_loja: 0,
        tipo_usuario: typeUser,
        nome_usuario: fullName,
        data_nasc: birthdayDate,
        email_usuario: email,
        senha: password,
        telefone_usuario: phone,
        ativo: true,
        excluir: false);
    print("Entrei!");
    usuarioService.cadastrarUsuario(usuario).then((String? erro) {
      print(erro);
      if (erro == null) {
        showSnackBar(
            context: context,
            mensagem: "Usuário Cadastrado com sucesso!",
            isErro: false);
      } else {
        showSnackBar(context: context, mensagem: erro);
      }
    });
  }

  _createUser({
    required String email,
    required String senha,
    required String nome,
  }) {
    //String? erro = await authService.cadastrarUsuario(email: email, senha: senha, nome: nome, cpfCnpj: cpfCnpj, ativo: ativo, excluir: excluir, cep: cep, dt_nasc: dt_nasc, endereco: endereco, telefone: telefone, tipo_user: tipo_user, codLoja: codLoja)
    authService
        .cadastrarUsuario(
      email: email,
      senha: senha,
      nome: nome,
    )
        .then((String? erro) {
      if (erro == null) {
        showSnackBar(
            context: context,
            mensagem: "Usuário Cadastrado com sucesso!",
            isErro: false);
        Navigator.pop(context);
      } else {
        showSnackBar(context: context, mensagem: erro);
      }
    });
  }
}
