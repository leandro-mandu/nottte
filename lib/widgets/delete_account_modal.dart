import 'package:flutter/material.dart';
import 'package:nottte/src/home/home_controller.dart';

import '../src/login/login_page.dart';

Future<dynamic> deleteAccountModal(
    BuildContext context, HomeController controller) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Deseja realmente excluir sua conta?",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Text('Todos os seus dados do Nottte serão apagados'),
                ElevatedButton(
                    onPressed: () {
                      controller.deleteAccount();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const LoginPage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Excluir"),
                        Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 160, 8, 0),
                        ),
                      ],
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Voltar"),
                        Icon(
                          Icons.navigate_before,
                        ),
                      ],
                    )),
              ]),
        );
      });
}
