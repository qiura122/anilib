import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AboutPage extends StatelessWidget {
  final String apiUrl =
      "https://68773301dba809d901ee3b6e.mockapi.io/api/v1/users";

  Future<List<dynamic>> _fetchData() async {
    var result = await http.get(Uri.parse(apiUrl));
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Us')),
      body: FutureBuilder<List<dynamic>>(
        future: _fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      snapshot.data[index]['avatar'],
                    ),
                  ),
                  title: Text(
                    "${snapshot.data[index]['first_name']} ${snapshot.data[index]['last_name']}",
                  ),
                  subtitle: Text(snapshot.data[index]['email']),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
