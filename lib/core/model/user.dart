// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userId;
  final String name;
  final String? bio;
  final String email;
  ///profile image
  final String? image;
  final String? backgroudImage;

  const User({
    required this.userId,
    required this.name,
    this.bio,
    required this.email,
    this.image,
    this.backgroudImage,

  });

  @override
  List<Object?> get props => [userId, name, email, image];

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['id'],
      name: map['name'],
      bio: map['bio'],
      email: map['email'],
      image: map['image'],
      backgroudImage: map['backgroundImage'],
   
    );
  }
}



