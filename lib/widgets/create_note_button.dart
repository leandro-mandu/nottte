import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nottte/models/note_model.dart';
import 'package:nottte/src/home/home_controller.dart';

import '../src/create_note/create_note.dart';

// ignore: must_be_immutable
class CreateNoteElevatedButton extends StatelessWidget {
  HomeController controller;
  bool? small;
  CreateNoteElevatedButton({super.key, required this.controller, this.small});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _navegarParaCreateNote(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00127A),
        fixedSize: small == true
            ? Size(MediaQuery.of(context).size.width / 4, 50)
            : Size(MediaQuery.of(context).size.width / 2, 50),
        shape: RoundedRectangleBorder(
            borderRadius: small == true
                ? const BorderRadius.vertical(top: Radius.elliptical(80, 80))
                : const BorderRadius.vertical(
                    bottom: Radius.elliptical(80, 80))),
      ),
      child: const Icon(Icons.edit),
    );
  }

  _navegarParaCreateNote(BuildContext context) async {
    log("${controller.myNotes.length} notas cadastradas");
    log('---> createNoteButton -->  navegando para new note');

    await Navigator.push<NoteModel?>(
      context,
      MaterialPageRoute(builder: (_) => const CreateNotePage()),
    ).then((value) {
      if (value != null && value.runtimeType == NoteModel) {
        log('---> createNoteButton -->  .then-->value = ${value.runtimeType}');
        log('---> createNoteButton -->  .then-->controller add value');

        controller.addNote(note: value);
      } else {
        log('---> createNoteButton -->  .then-->value = ${value.runtimeType}');
        log('---> createNoteButton -->  .then-->não faz nada');
      }
    });

    log("${controller.myNotes.length} notas cadastradas");
    log('---> createNoteButton -->  .then-->voltando');
  }
}
