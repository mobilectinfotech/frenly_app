import 'dart:convert';

import '../../data/models/HomePageModel.dart';
import '../../data/models/PostSingleViewModel.dart';
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

  String toRawJson() => json.encode(toJson());

  factory GetUserByIdModel.fromJson(Map<String, dynamic> json) => GetUserByIdModel(
    status: json["status"],
    message: json["message"],
    success: json["success"],
    user: json["user"] == null ? null : ProfileUser.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "success": success,
    "user": user?.toJson(),
  };
}

class ProfileUser {
  int? id;
  String? email;
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
  int? numberOfFollower;
  int? numberOfFollowing;
  String? city;
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
    this.numberOfFollower,
    this.numberOfFollowing,
    this.city,
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

  String toRawJson() => json.encode(toJson());

  factory ProfileUser.fromJson(Map<String, dynamic> json) => ProfileUser(
    id: json["id"],
    email: json["email"],
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
    numberOfFollower: json["numberOfFollower"],
    numberOfFollowing: json["numberOfFollowing"],
    city: json["city"],
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

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "password": password,
    "full_name": fullName,
    "bio": bio,
    "handle": handle,
    "fcm_token": fcmToken,
    "avatar_url": avatarUrl,
    "cover_photo_url": coverPhotoUrl,
    "token": token,
    "act_token": actToken,
    "isVerified": isVerified,
    "numberOfFollower": numberOfFollower,
    "numberOfFollowing": numberOfFollowing,
    "city": city,
    "country": country,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "numberOfSaves": numberOfSaves,
    "isOnline": isOnline,
    "lastSeen": lastSeen?.toIso8601String(),
    "isPrivate": isPrivate,
    "posts": posts == null ? [] : List<dynamic>.from(posts!.map((x) => x.toJson())),
    "vlogs": vlogs == null ? [] : List<dynamic>.from(vlogs!.map((x) => x.toJson())),
    "blogs": blogs == null ? [] : List<dynamic>.from(blogs!.map((x) => x.toJson())),
    "numberOfPosts": numberOfPosts,
    "commentsAllowed": commentsAllowed,
    "followState": followState,
  };
}



