import 'dart:convert';

import 'package:flutter_miload/features/domain/entities/user/user.dart';

class UserModel extends UserEnitity {
  const UserModel({
    required super.email,
    required super.username,
    required super.uid,
  });

  

Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'username': username,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      uid: map['uid'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

