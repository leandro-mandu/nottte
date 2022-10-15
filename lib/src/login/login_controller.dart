import 'dart:convert';

import 'package:nottte/models/user_model.dart';
import 'package:nottte/src/login/login_state.dart';
import 'package:nottte/src/utils/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  LoginState state = LoginStateEmpty();
  Future<LoginState> login({
    required UserModel user,
  }) async {
//    user = UserModel(nome: nome, email: email, senha: password);
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    await prefs.setBool(SharedPreferencesKeys.hasUser, true);
    await prefs.setString(SharedPreferencesKeys.currentUser, jsonEncode(user));
    return LoginStateSuccess();
  }
}
