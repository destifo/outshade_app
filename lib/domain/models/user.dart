class User {
  final name;
  final id;
  final atype;

  User({this.name, this.id, this.atype});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        id: json['id'],
        atype: json['atype']);
  }

}
