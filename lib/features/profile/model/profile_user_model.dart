// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class UpdateProfileUserModel extends Equatable {
  final String name;
  final String id;
  final Uint8List? profileImage;
  final Uint8List? backgroundImage;
  final bool isBackgroundImageDeleted;
  final String? bio;
  const UpdateProfileUserModel({
    required this.name,
    required this.id,
    this.profileImage,
    this.backgroundImage,
  required   this.isBackgroundImageDeleted,
    this.bio,
  });
  
  @override

  List<Object?> get props => [id, name, profileImage, backgroundImage, bio];
}
