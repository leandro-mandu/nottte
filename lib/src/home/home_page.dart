import 'package:flutter/material.dart';
import 'package:nottte/models/user_model.dart';
import 'package:nottte/src/home/home_controller.dart';
import 'package:nottte/src/home/home_state.dart';
import 'package:nottte/src/login/login_page.dart';
import 'package:nottte/widgets/create_note_button.dart';

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
                logoutModal(context);
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
                          deleteNoteModal(context, i);
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
                  logoutModal(context);
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
                  deleteAccountModal(context);
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
    );
  }

  Future<dynamic> deleteNoteModal(BuildContext context, int i) {
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

  Future<dynamic> deleteAccountModal(BuildContext context) {
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginPage()));
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

  Future<dynamic> logoutModal(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 200,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Deseja realmente sair?",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Text(
                      'Vocẽ poderá fazer login depois para ver suas notas'),
                  ElevatedButton(
                      onPressed: () {
                        controller.logout();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginPage()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Sair"),
                          Icon(
                            Icons.logout,
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
}
