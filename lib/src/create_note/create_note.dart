import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nottte/models/note_model.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00127A),
        title: const Text("Criar nota"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        onChanged: () {
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 3) {
                    return 'preencha o título';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Título'),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 8,
                controller: subtitleController,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 3) {
                    return 'descreva a nota';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Descrição'),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                  onPressed: _formKey.currentState?.validate() == true
                      ? () {
                          log('---> newNotePage -->  validate=true -> cria newNote');

                          final newNote = NoteModel(
                            title: titleController.text,
                            subtitle: subtitleController.text,
                          );
                          log('---> newNotePage -->  navega devolta para home');
                          Navigator.pop(context, newNote);
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
                      Text("Salvar nota"),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.save),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
