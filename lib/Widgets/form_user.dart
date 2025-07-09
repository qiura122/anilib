import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'model/user.dart';

class FormUser extends StatefulWidget {
  final User? user;

  FormUser({this.user});

  @override
  _FormUserState createState() => _FormUserState();
}

class _FormUserState extends State<FormUser> {
  DbHelper db = DbHelper();

  TextEditingController? nama;
  TextEditingController? username;
  TextEditingController? email;
  TextEditingController? genre;

  @override
  void initState() {
    super.initState();
    nama = TextEditingController(
      text: widget.user == null ? '' : widget.user!.nama ?? '',
    );
    username = TextEditingController(
      text: widget.user == null ? '' : widget.user!.username ?? '',
    );
    email = TextEditingController(
      text: widget.user == null ? '' : widget.user!.email ?? '',
    );
    genre = TextEditingController(
      text: widget.user == null ? '' : widget.user!.genre ?? '',
    );
  }

  @override
  void dispose() {
    nama?.dispose();
    username?.dispose();
    email?.dispose();
    genre?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Kontak')),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: nama,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: username,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: genre,
              decoration: InputDecoration(
                labelText: 'Genre',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              child: (widget.user == null)
                  ? Text('Simpan', style: TextStyle(color: Colors.black))
                  : Text('Update', style: TextStyle(color: Colors.black)),
              onPressed: () {
                upsertUser();
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> upsertUser() async {
    if (widget.user != null) {
      await db.updateUser(User(
        id: widget.user!.id,
        nama: nama!.text,
        username: username!.text,
        email: email!.text,
        genre: genre!.text,
      ));
      Navigator.pop(context, 'update');
    } else {
      await db.saveUser(User(
        nama: nama!.text,
        username: username!.text,
        email: email!.text,
        genre: genre!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
