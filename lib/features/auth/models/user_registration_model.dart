// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:equatable/equatable.dart';

class UserRegistrationModel extends Equatable {
  final String password;
  final String email;
  final String name;
  final File? image;

  const UserRegistrationModel({
    required this.password,
    required this.email,
    required this.name,
    this.image,
  });

  UserRegistrationModel copyWith({
    String? password,
    String? email,
    String? name,
    File? image
  }) {
    return UserRegistrationModel(
      name: name??this.name,
      image: image??this.image,
      password: password ?? this.password,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'password': password,
      'email': email,
      'name': name,

    };
  }

  @override
  List<Object?> get props => [password, email, name, image];
}
