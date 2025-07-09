import 'package:flutter/material.dart';

class FrierenPage extends StatefulWidget {
  FrierenPage({Key? key}) : super(key: key);

  @override
  State<FrierenPage> createState() => _FrierenPageState();
}

class _FrierenPageState extends State<FrierenPage> {
  final TextEditingController _commentController = TextEditingController();
  final List<String> _comments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Frieren: Beyond Journey\'s End')),
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
                Image.asset('images/frieren.jpg', height: 300, width: 200),
                Text(
                  'Frieren: Beyond Journey\'s End',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Frieren: Beyond Journey\'s End is a fantasy anime that follows the story of Frieren, a mage who was part of the hero\'s party that defeated the Demon King. After the hero\'s death, Frieren embarks on a journey to understand humanity and the passage of time, meeting new friends and facing challenges along the way.',
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
