import 'dart:convert';

class UserModel {
  String name;
  String id;
  String email;
  UserModel({required this.name, required this.email, required this.id});

  Map<String, dynamic> toJson() => {'email': email, 'id': id, 'name': name};
  UserModel.fromJson(Map<String, dynamic> json)
    : this(email: json['email'], name: json['name'], id: json['id']);
}
