class User {
  int? id;
  String? nama;
  String? username;
  String? email;
  String? genre;

  User({this.id, this.nama, this.username, this.email, this.genre});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['nama'] = nama;
    map['username'] = username;
    map['email'] = email;
    map['genre'] = genre;

    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nama = map['nama'];
    this.username = map['username'];
    this.email = map['email'];
    this.genre = map['genre'];
  }
}
