import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nottte/src/authentication/splash_controller.dart';
import 'package:nottte/src/authentication/splash_state.dart';
import 'package:nottte/src/home/home_page.dart';
import 'package:nottte/src/login/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashController controller = SplashController();
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3)).then(
      (value) async {
        controller.isAuthenticated().then((value) {
          if (value.runtimeType == SplashStateAutenthicated) {
            log('---> SplashPage: autenticado como ${controller.user.nome}');
            log('---> SplashPage: StateAutenthicated-navega para home');
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => HomePage(user: controller.user),
                ));
          } else {
            log('---> SplashPage: StateUnautenthicated-navega para login');

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                ));
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(64.0),
              child: Text(
                "Nottte",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
