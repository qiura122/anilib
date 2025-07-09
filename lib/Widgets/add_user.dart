import 'package:flutter/material.dart';
import 'form_user.dart';
import 'database/db_helper.dart';
import 'model/user.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  List<User> listUser = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    super.initState();
    _getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("All User"))),
      body: ListView.builder(
        itemCount: listUser.length,
        itemBuilder: (context, index) {
          User user = listUser[index];
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListTile(
              leading: const Icon(Icons.person, size: 50),
              title: Text('${user.nama}'),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text("Username: ${user.username}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text("Email: ${user.email}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text("Genre: ${user.genre}"),
                  ),
                ],
              ),
              trailing: FittedBox(
                fit: BoxFit.fill,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        _openFormEdit(user);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        AlertDialog hapus = AlertDialog(
                          title: const Text("Information"),
                          content: SizedBox(
                            height: 100,
                            child: Column(
                              children: [
                                Text(
                                  "Yakin ingin menghapus Data ${user.nama}?",
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                _deleteUser(user, index);
                                Navigator.pop(context);
                              },
                              child: const Text("Ya"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Tidak"),
                            ),
                          ],
                        );
                        showDialog(
                          context: context,
                          builder: (context) => hapus,
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openFormCreate();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _getAllUser() async {
    var list = await db.getAllUser();
    setState(() {
      listUser.clear();
      list?.forEach((kontak) {
        listUser.add(User.fromMap(kontak));
      });
    });
  }

  Future<void> _deleteUser(User user, int index) async {
    await db.deleteUser(user.id!);
    setState(() {
      listUser.removeAt(index);
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormUser()),
    );
    if (result == 'save') {
      _getAllUser();
    }
  }

  Future<void> _openFormEdit(User user) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FormUser(user: user)),
    );
    if (result == 'update') {
      _getAllUser();
    }
  }
}
