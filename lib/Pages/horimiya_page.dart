import 'package:flutter/material.dart';

class HorimiyaPage extends StatefulWidget {
  HorimiyaPage({Key? key}) : super(key: key);

  @override
  State<HorimiyaPage> createState() => _HorimiyaPageState();
}

class _HorimiyaPageState extends State<HorimiyaPage> {
  final TextEditingController _commentController = TextEditingController();
  final List<String> _comments = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Horimiya')),
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
                Image.asset('images/horimiya.jpg', height: 300, width: 200),
                Text(
                  'Horimiya',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Horimiya is a romantic comedy anime that follows the story of two high school students, Hori and Miyamura, who have very different personalities. Hori is a popular girl who is good at academics and sports, while Miyamura is a quiet boy with a hidden side. Their relationship develops as they get to know each other better, leading to heartwarming and humorous situations.',
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
