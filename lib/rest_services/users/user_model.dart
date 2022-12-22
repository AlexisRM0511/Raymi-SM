import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? dni;
  String? name;
  String? lastname;
  String? username;
  String? email;
  String? phone;
  String? password;
  int? typeUser;
  int? status;
  Timestamp? createdAt;
  UserModel(
      {this.id,
      this.dni,
      this.name,
      this.lastname,
      this.username,
      this.email,
      this.phone,
      this.password,
      this.typeUser,
      this.status,
      this.createdAt});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"] as String,
      dni: json["dni"] as String,
      name: json["name"] as String,
      lastname: json["lastname"] as String,
      username: json["username"] as String,
      email: json["email"] as String,
      phone: json["phone"] as String,
      password: json["password"] as String,
      typeUser: json["typeUser"] as int,
      status: json["status"] as int,
      createdAt: json["createdAt"] as Timestamp);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data["id"] = id;
    if (dni != null) data['dni'] = dni;
    if (name != null) data['name'] = name;
    if (lastname != null) data['lastname'] = lastname;
    if (username != null) data['username'] = username;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;
    if (password != null) data['password'] = password;
    if (typeUser != null) data['typeUser'] = typeUser;
    if (status != null) data['status'] = status;
    if (createdAt != null) data['createdAt'] = createdAt;
    return data;
  }

  @override
  String toString() {
    return 'UserModel{id: $id, dni: $dni, name: $name, lastname: $lastname, username: $username, email: $email, phone: $phone, password: $password, typeUser: $typeUser, status: $status, createdAt: $createdAt}';
  }
}
