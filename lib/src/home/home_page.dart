import 'package:flutter/material.dart';
import 'package:nottte/models/user_model.dart';
import 'package:nottte/src/home/home_controller.dart';
import 'package:nottte/src/home/home_state.dart';
import 'package:nottte/widgets/create_note_button.dart';

import '../../widgets/delete_account_modal.dart';
import '../../widgets/delete_note_modal.dart';
import '../../widgets/logout_modal.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  UserModel user;
  HomePage({
    super.key,
    required this.user,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController controller;

  @override
  void initState() {
    /*
    WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
      controller = HomeController(onUpdate: () {
        setState(() {});
      });
    });
    */
    controller = HomeController(onUpdate: () {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00127A),
        title: Text("Nottte - Olá ${widget.user.nome}"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                logoutModal(context, controller);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Builder(builder: (context) {
        if (controller.state.runtimeType == HomeStateEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Olá ${widget.user.nome}, seja bem vindo(a)!"),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Seu Nottte está vazio!!!',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                const Text("Comece a criar notas agora mesmo!"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CreateNoteElevatedButton(controller: controller),
                ),
              ],
            ),
          );
        } else if (controller.state.runtimeType == HomeStateSuccess) {
          return ListView.builder(
            itemCount: controller.myNotes.length,
            itemBuilder: (context, i) {
              return Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFF00127A),
                        child: Icon(
                          Icons.article,
                        ),
                      ),
                      title: Text(controller.myNotes[i].title),
                      subtitle: Text(controller.myNotes[i].subtitle),
                      trailing: IconButton(
                        onPressed: () {
                          deleteNoteModal(context, i, controller);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Color.fromARGB(255, 237, 16, 0),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }

        return Container();
      }),
      floatingActionButton: CreateNoteElevatedButton(
        controller: controller,
        small: true,
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF00127A),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture:
                  const CircleAvatar(child: Icon(Icons.person)),
              accountName: Text(widget.user.nome),
              accountEmail: Text(widget.user.email),
            ),
            ElevatedButton(
                onPressed: () {
                  logoutModal(context, controller);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Sair"),
                    Icon(Icons.logout),
                  ],
                )),
            ElevatedButton(
                onPressed: () {
                  deleteAccountModal(context, controller);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Excluir minha conta"),
                    Icon(
                      Icons.delete_forever,
                      color: Color.fromARGB(255, 160, 8, 0),
                    ),
                  ],
                )),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Início",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "Criar nota"),
      ]),
    );
  }
}
