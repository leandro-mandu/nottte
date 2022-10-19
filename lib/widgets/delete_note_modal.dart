import 'package:flutter/material.dart';
import 'package:nottte/src/home/home_controller.dart';

Future<dynamic> deleteNoteModal(
    BuildContext context, int i, HomeController controller) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Deseja realmente excluir esta nota?",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                ElevatedButton(
                    onPressed: () {
                      controller.deleteNote(i: i);
                      Navigator.pop(context);
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
