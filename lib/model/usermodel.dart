class UserModel {
  String name;
  String email;
  String id;

  UserModel({required this.name, required this.email, required this.id});

  static fromMap(Map<String, dynamic> data) {
    UserModel(name: data['Name'], email: data['Email'], id: data['Id']);
  }
}
