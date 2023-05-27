import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:ipheira/pages/communidades/comunidades.dart';
import 'package:ipheira/pages/login/component/show_snackbar.dart';
import 'package:ipheira/pages/login/register.dart';
import 'package:ipheira/utils/image_url.dart';
import 'package:shimmer/shimmer.dart';
import '../../services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController resetPasswordEmailController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _logoAnimation;
  late Animation<double> _scaleAnimation;

  final _formKey = GlobalKey<FormState>();

  //Objeto com as funcões de autenticação
  AuthService authService = AuthService();

  bool _obscureText = true;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _logoAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5; // Aumenta a duração da animação (opcional)

    return Form(
      key: _formKey,
      child: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.only(bottom: 1),
            height: 1000,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(ImageUrl.background.value),
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
              ),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  ScaleTransition(
                    scale: _logoAnimation,
                    child: Container(
                      color: Colors.white,
                      height: 200,
                      width: 225,
                      child: Image.network(
                        ImageUrl.logo.value,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  // BEM-VINDO
                  FadeTransition(
                    opacity: _logoAnimation,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        RichText(
                          text: TextSpan(
                            text: 'Bem-vindo\n',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                            ),
                            children: [
                              TextSpan(
                                text: 'ao\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                ),
                              ),
                              TextSpan(
                                text: 'Ipheira',
                                style: TextStyle(
                                  color: const Color.fromRGBO(77, 167, 104, 1),
                                  fontSize: 19,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  // EMAIL
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      onChanged: (text) {
                        setState(() {});
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.black),
                        fillColor: const Color.fromRGBO(200, 200, 200, 1),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      textAlign: TextAlign.start,
                      controller: passwordController,
                      obscureText: _obscureText,
                      onChanged: (text) {
                        setState(() {});
                      },
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Senha',
                        hintStyle: TextStyle(color: Colors.black),
                        fillColor: const Color.fromRGBO(200, 200, 200, 1),
                        filled: true,
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: _togglePasswordVisibility,
                          child: IconButton(
                            onPressed: _togglePasswordVisibility,
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: _passwordVisible
                                  ? Colors.green
                                  : Color.fromRGBO(104, 104, 104, 1),
                            ),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 4) {
                          return 'A senha deve ser válida';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _entrarUsuario(
                            email: emailController.text,
                            senha: passwordController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 18),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 33, vertical: 13),
                      ),
                      child: const Text('Login'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (newContext) => const RegisterForm(),
                        ),
                      );
                    },
                    child: const Text(
                      'Ainda não tem conta? Cadastre-se agora',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Color.fromRGBO(0, 102, 51, 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Redefinir Senha'),
                            content: Container(
                              width: double.maxFinite,
                              child: TextFormField(
                                textAlign: TextAlign.start,
                                onChanged: (text) {
                                  setState(() {});
                                },
                                controller: resetPasswordEmailController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  hintText: 'Digite seu email',
                                  hintStyle: TextStyle(color: Colors.black),
                                  fillColor:
                                      const Color.fromRGBO(200, 200, 200, 1),
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
                    child: const Text(
                      'Esqueceu a senha?',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // METODO DE AUTENTICAÇÃO FIREBASE
  _entrarUsuario({required String email, required String senha}) {
    authService.entrarUsuario(email: email, senha: senha).then((String? erro) {
      if (erro == null) {
        showSnackBar(
          context: context,
          mensagem: 'Bem vindo!',
          isErro: false,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (newContext) => const HomeComunidades(),
          ),
        );
      } else {
        showSnackBar(context: context, mensagem: erro);
      }
    });
  }
}
