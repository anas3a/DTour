class User {
  int? id;
  String? name;
  String? email;
  String? password;
  static const tableName = 'users';

  User({this.id, this.name, this.email, this.password});
  static User fromMap(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'].toString(),
      email: json['email'].toString(),
      password: json['password'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
