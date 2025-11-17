import 'dart:convert';

import '../../data/models/blog_model.dart';
import '../../data/models/post_model.dart';
import '../../data/models/vlog_model.dart';

class GetUserByIdModel {
  int? status;
  String? message;
  bool? success;
  ProfileUser? user;

  GetUserByIdModel({
    this.status,
    this.message,
    this.success,
    this.user,
  });

  factory GetUserByIdModel.fromRawJson(String str) => GetUserByIdModel.fromJson(json.decode(str));



  factory GetUserByIdModel.fromJson(Map<String, dynamic> json) => GetUserByIdModel(
    status: json["status"],
    message: json["message"],
    success: json["success"],
    user: json["user"] == null ? null : ProfileUser.fromJson(json["user"]),
  );


}

class ProfileUser {
  int? id;
  String? email;
  String? personalNumber;
  String? password;
  String? fullName;
  String? bio;
  String? handle;
  String? fcmToken;
  String? avatarUrl;
  String? coverPhotoUrl;
  String? token;
  String? actToken;
  bool? isVerified;
  int? status;
  int? numberOfFollower;
  int? numberOfFollowing;
  String? city;
  String? location;
  String? country;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? numberOfSaves;
  int? isOnline;
  DateTime? lastSeen;
  bool? isPrivate;
  List<Post>? posts;
  List<Vlog>? vlogs;
  List<Blog>? blogs;
  int? numberOfPosts;
  bool? commentsAllowed;
  int? followState;

  ProfileUser({
    this.id,
    this.email,
    this.personalNumber,
    this.password,
    this.fullName,
    this.bio,
    this.handle,
    this.fcmToken,
    this.avatarUrl,
    this.coverPhotoUrl,
    this.token,
    this.actToken,
    this.isVerified,
    this.status,
    this.numberOfFollower,
    this.numberOfFollowing,
    this.city,
    this.location,
    this.country,
    this.createdAt,
    this.updatedAt,
    this.numberOfSaves,
    this.isOnline,
    this.lastSeen,
    this.isPrivate,
    this.posts,
    this.vlogs,
    this.blogs,
    this.numberOfPosts,
    this.commentsAllowed,
    this.followState,
  });

  factory ProfileUser.fromRawJson(String str) => ProfileUser.fromJson(json.decode(str));



  factory ProfileUser.fromJson(Map<String, dynamic> json) => ProfileUser(
    id: json["id"],
    email: json["email"],
    personalNumber: json["personalNumber"],
    password: json["password"],
    fullName: json["full_name"],
    bio: json["bio"],
    handle: json["handle"],
    fcmToken: json["fcm_token"],
    avatarUrl: json["avatar_url"],
    coverPhotoUrl: json["cover_photo_url"],
    token: json["token"],
    actToken: json["act_token"],
    isVerified: json["isVerified"],
    status: json["status"],
    numberOfFollower: json["numberOfFollower"],
    numberOfFollowing: json["numberOfFollowing"],
    city: json["city"],
    location: json["location"],
    country: json["country"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    numberOfSaves: json["numberOfSaves"],
    isOnline: json["isOnline"],
    lastSeen: json["lastSeen"] == null ? null : DateTime.parse(json["lastSeen"]),
    isPrivate: json["isPrivate"],
    posts: json["posts"] == null ? [] : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
    vlogs: json["vlogs"] == null ? [] : List<Vlog>.from(json["vlogs"]!.map((x) => Vlog.fromJson(x))),
    blogs: json["blogs"] == null ? [] : List<Blog>.from(json["blogs"]!.map((x) => Blog.fromJson(x))),
    numberOfPosts: json["numberOfPosts"],
    commentsAllowed: json["commentsAllowed"],
    followState: json["followState"],
  );


}



