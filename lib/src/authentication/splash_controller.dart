import 'dart:convert';
import 'dart:developer';

import 'package:nottte/src/utils/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';
import 'splash_state.dart';

class SplashController {
  // ignore: prefer_typing_uninitialized_variables
  var user;
  late final SharedPreferences prefs;
  SplashController() {
    init();
  }

  Future<void> init() async {
    log("init->user é ${user.runtimeType}");
    prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(SharedPreferencesKeys.currentUser);
    if (userString != null && userString.isNotEmpty) {
      log("init->usuário encontrado->decodificando");
      var userJson = jsonDecode(userString);
      user = UserModel.fromJson(userJson);
    }
  }

  Future<SplashState> isAuthenticated() async {
    // final prefs = await SharedPreferences.getInstance();

    //checar armazenamento local
//    prefs.reload();
    ///////////////////////////
    //////////////////////////
    // final userString = prefs.getString(SharedPreferencesKeys.currentUser);
    //if (userString != null && userString.isNotEmpty) {
//      log("autentidado");
    //    var userJson = jsonDecode(userString);
//      user = UserModel.fromJson(userJson);
    if (user.runtimeType == UserModel) {
      log("autentidado (user==UserModel)");
      return SplashStateAutenthicated();
    }
    log("não autentidado (user!=UserModel)");
    return SplashStateUnautenthicated();
  }
}
