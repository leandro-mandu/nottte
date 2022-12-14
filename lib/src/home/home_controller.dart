import 'dart:convert';
import 'dart:developer';

import 'package:flutter/painting.dart';
import 'package:nottte/models/note_model.dart';
import 'package:nottte/src/home/home_state.dart';
import 'package:nottte/src/utils/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

class HomeController {
  HomeState state = HomeStateEmpty();

  final VoidCallback onUpdate;
  List<NoteModel> myNotes = <NoteModel>[];
  UserModel user;
  late final SharedPreferences prefs;

  HomeController({required this.onUpdate, required this.user}) {
    init();
  }

  void updateState(HomeState newState) {
    state = newState;
    onUpdate();
  }

  Future<void> init() async {
    updateState(HomeStateLoading());
    log('---> HomeController -->  instância dados');

    prefs = await SharedPreferences.getInstance();
    log('---> HomeController -->  lendo notas');
    final notes = prefs.getString(SharedPreferencesKeys.notes + user.email);
    log("buscando notas na chave concatenada ${SharedPreferencesKeys.notes + user.email} parta buscar somente as notas deste usuário");
    if (notes != null && notes.isNotEmpty) {
      final listJsonNotes = jsonDecode(notes);

      myNotes =
          List.from(listJsonNotes).map((e) => NoteModel.fromJson(e)).toList();
      if (myNotes.isEmpty) {
        updateState(HomeStateEmpty());
      } else {
        updateState(HomeStateSuccess());
      }
    } else {
      log('---> HomeController -->  sem notas: lista vazia');

      updateState(HomeStateEmpty());
    }
  }

  Future<void> addNote({required NoteModel note}) async {
    updateState(HomeStateLoading());
    log('---> HomeController -->  adicionando nota');

    myNotes.add(note);
    log('---> HomeController -->  gravando na memória');

    prefs.setString(
        SharedPreferencesKeys.notes + user.email, jsonEncode(myNotes));
    log("armazenando notas na chave concatenada ${SharedPreferencesKeys.notes + user.email} parta que cada usuário tenha suas próprias notas");
    updateState(HomeStateSuccess());
  }

  Future<void> deleteNote({required int i}) async {
    updateState(HomeStateLoading());
    myNotes.removeAt(i);

    await prefs.setString(
        SharedPreferencesKeys.notes + user.email, jsonEncode(myNotes));
    log("deletando notas na chave concatenada ${SharedPreferencesKeys.notes + user.email} parta não afetar notas de outros usuários");
    updateState(HomeStateSuccess());
    if (myNotes.isEmpty) {
      updateState(HomeStateEmpty());
    }
  }

  Future<void> logout() async {
    updateState(HomeStateLoading());
    await prefs.remove(SharedPreferencesKeys.currentUser);
    updateState(HomeStateEmpty());
  }

  Future<void> deleteAccount() async {
    updateState(HomeStateLoading());
//    await prefs.clear();
    await prefs.remove(SharedPreferencesKeys.currentUser);
    await prefs.remove(SharedPreferencesKeys.notes + user.email);
    updateState(HomeStateEmpty());
  }
}
