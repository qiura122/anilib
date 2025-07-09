import 'package:flutter/material.dart';

class SpyFamPage extends StatefulWidget {
  SpyFamPage({Key? key}) : super(key: key);

  @override
  State<SpyFamPage> createState() => _SpyFamPageState();
}

class _SpyFamPageState extends State<SpyFamPage> {
  final TextEditingController _commentController = TextEditingController();
  final List<String> _comments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Spy x Family')),
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
                Image.asset('images/spyfam.jpg', height: 300, width: 200),
                Text(
                  'Spy x Family',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Spy x Family is a romantic comedy anime that follows the story of a spy named Twilight, who is tasked with infiltrating an elite school. To maintain his cover, he must create a fake family, leading to a series of comedic and heartwarming situations as he navigates parenthood and espionage.',
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
