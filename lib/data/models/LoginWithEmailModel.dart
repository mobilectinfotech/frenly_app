// To parse this JSON data, do
//
//     final loginWithEmailModel = loginWithEmailModelFromJson(jsonString);

import 'dart:convert';

LoginWithEmailModel loginWithEmailModelFromJson(String str) => LoginWithEmailModel.fromJson(json.decode(str));

String loginWithEmailModelToJson(LoginWithEmailModel data) => json.encode(data.toJson());

class LoginWithEmailModel {
  int? status;
  bool? success;
  String? message;
  String? token;
  User? user;

  LoginWithEmailModel({
    this.status,
    this.success,
    this.message,
    this.token,
    this.user,
  });

  factory LoginWithEmailModel.fromJson(Map<String, dynamic> json) => LoginWithEmailModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    token: json["token"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "token": token,
    "user": user?.toJson(),
  };
}

class User {
  int? id;
  String? email;
  dynamic fcmToken;
  dynamic avatarUrl;
  dynamic coverPhotoUrl;
  dynamic bio;
  dynamic handle;
  String? fullName;
  int? numberOfFollower;
  int? numberOfFollowing;
  String? country;
  String? city;

  User({
    this.id,
    this.email,
    this.fcmToken,
    this.avatarUrl,
    this.coverPhotoUrl,
    this.bio,
    this.handle,
    this.fullName,
    this.numberOfFollower,
    this.numberOfFollowing,
    this.country,
    this.city,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    fcmToken: json["fcm_token"],
    avatarUrl: json["avatar_url"],
    coverPhotoUrl: json["cover_photo_url"],
    bio: json["bio"],
    handle: json["handle"],
    fullName: json["full_name"],
    numberOfFollower: json["numberOfFollower"],
    numberOfFollowing: json["numberOfFollowing"],
    country: json["country"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "fcm_token": fcmToken,
    "avatar_url": avatarUrl,
    "cover_photo_url": coverPhotoUrl,
    "bio": bio,
    "handle": handle,
    "full_name": fullName,
    "numberOfFollower": numberOfFollower,
    "numberOfFollowing": numberOfFollowing,
    "country": country,
    "city": city,
  };
}
