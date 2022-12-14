import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:nottte/models/user_model.dart';
import 'package:nottte/src/home/home_page.dart';
import 'package:nottte/src/login/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00127A),
        title: const Text("Nottte - Fazer login"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Text(
                "Preencha os dados para fazer login",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Divider(),
              Form(
                key: _formKey,
                onChanged: () => setState(() {}),
                child: Column(
                  children: [
                    TextFormField(
                      controller: nomeController,
                      decoration: const InputDecoration(
                        label: Text("Nome"),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha corretamente seu nome';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(label: Text("E-mail")),
                      validator: (value) {
                        if (value == null || !EmailValidator.validate(value)) {
                          return "Preencha o e-mail corretamente";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        label: Text("Senha"),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 8) {
                          return '''Sua senha deve conter:
-no m??nimo 8 caracteres''';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                onPressed: _formKey.currentState?.validate() == true
                    ? () {
                        showDialog(
                          context: context,
                          builder: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                        final user = UserModel(
                          nome: nomeController.text,
                          email: emailController.text,
                          senha: passwordController.text,
                        );
                        controller
                            .login(
                          user: user,
                        )
                            .then((value) {
                          Navigator.pop(
                              context); //para tirar o modaL ShowDialog
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => HomePage(
                                  user: user,
                                ),
                              ));
                        });
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00127A),
                  fixedSize: Size(MediaQuery.of(context).size.width / 2, 50),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(80, 80))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Entrar"),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(Icons.navigate_next),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
