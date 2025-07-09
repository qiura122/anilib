import 'package:flutter/material.dart';

class OpmPage extends StatefulWidget {
  OpmPage({Key? key}) : super(key: key);

  @override
  State<OpmPage> createState() => _OpmPageState();
}

class _OpmPageState extends State<OpmPage> {
  final TextEditingController _commentController = TextEditingController();
  final List<String> _comments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('One Punch Man')),
      body: SafeArea(
        child: SingleChildScrollView(
          // Agar bisa discroll saat keyboard muncul
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset('images/opm.jpg', height: 300, width: 200),
                Text(
                  'One Punch Man',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'One Punch Man is an action-comedy anime that follows the story of Saitama, a hero who is so powerful that he can defeat any opponent with a single punch. Bored with his overwhelming strength, he seeks to find a worthy adversary while navigating the challenges of being a hero in a world filled with monsters and villains.',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Form(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _commentController,
                            decoration: InputDecoration(
                              labelText: 'Tulis komentar...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            final comment = _commentController.text;
                            if (comment.isNotEmpty) {
                              setState(() {
                                _comments.add(comment);
                              });
                              _commentController.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Komentar terkirim: $comment'),
                                ),
                              );
                            }
                          },
                          child: Text('Kirim'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 200, // Atur tinggi agar list komentar tetap terlihat
                  child:
                      _comments.isEmpty
                          ? Center(child: Text('Belum ada komentar.'))
                          : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            itemCount: _comments.length,
                            itemBuilder:
                                (context, index) => Card(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 4,
                                  ),
                                  child: ListTile(
                                    leading: Icon(Icons.comment),
                                    title: Text(_comments[index]),
                                  ),
                                ),
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
