// To parse this JSON data, do
//
//     final getUserByIdModel = getUserByIdModelFromJson(jsonString);

import 'dart:convert';

import '../../data/models/blog_model.dart';
import '../../data/models/post_model.dart';
import '../../data/models/user_model.dart';
import '../../data/models/vlog_model.dart';

class GetUserByIdModel {
  int? status;
  String? message;
  bool? success;
  User? user;

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
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "success": success,
    "user": user?.toJson(),
  };
}

class User {
  int? id;
  String? email;
  String? password;
  String? fullName;
  String? bio;
  String? handle;
  String? fcmToken;
  String? avatarUrl;
  String? coverPhotoUrl;
  dynamic token;
  String? actToken;
  bool? isVerified;
  int? numberOfFollower;
  int? numberOfFollowing;
  String? city;
  String? country;
  String? createdAt;
  String? updatedAt;
  int? numberOfSaves;
  int? isOnline;
  String? lastSeen;
  List<Post>? posts;
  List<Vlog>? vlogs;
  List<Blog>? blogs;
  int? numberOfPosts;
  bool? isFollowed;
  bool? commentsAllowed;

  User({
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
    this.posts,
    this.vlogs,
    this.blogs,
    this.numberOfPosts,
    this.isFollowed,
    this.commentsAllowed,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
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
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    numberOfSaves: json["numberOfSaves"],
    isOnline: json["isOnline"],
    lastSeen: json["lastSeen"],
    posts: json["posts"] == null ? [] : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
    vlogs: json["vlogs"] == null ? [] : List<Vlog>.from(json["vlogs"]!.map((x) => Vlog.fromJson(x))),
    blogs: json["blogs"] == null ? [] : List<Blog>.from(json["blogs"]!.map((x) => Blog.fromJson(x))),
    numberOfPosts: json["numberOfPosts"],
    isFollowed: json["isFollowed"],
    commentsAllowed: json["commentsAllowed"],
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
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "numberOfSaves": numberOfSaves,
    "isOnline": isOnline,
    "lastSeen": lastSeen,
    "posts": posts == null ? [] : List<dynamic>.from(posts!.map((x) => x.toJson())),
    "vlogs": vlogs == null ? [] : List<dynamic>.from(vlogs!.map((x) => x.toJson())),
    "blogs": blogs == null ? [] : List<dynamic>.from(blogs!.map((x) => x.toJson())),
    "numberOfPosts": numberOfPosts,
    "isFollowed": isFollowed,
    "commentsAllowed": commentsAllowed,
  };
}

class Blog {
  int? id;
  String? body;
  String? title;
  String? tags;
  dynamic city;
  String? imageUrl;
  dynamic country;
  int? userId;
  String? createdAt;
  String? updatedAt;
  int? numberOfLikes;
  int? numberOfShares;
  int? numberOfComments;
  int? numberOfSaves;

  Blog({
    this.id,
    this.body,
    this.title,
    this.tags,
    this.city,
    this.imageUrl,
    this.country,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.numberOfLikes,
    this.numberOfShares,
    this.numberOfComments,
    this.numberOfSaves,
  });

  factory Blog.fromRawJson(String str) => Blog.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
    id: json["id"],
    body: json["body"],
    title: json["title"],
    tags: json["tags"],
    city: json["city"],
    imageUrl: json["image_url"],
    country: json["country"],
    userId: json["userId"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    numberOfLikes: json["numberOfLikes"],
    numberOfShares: json["numberOfShares"],
    numberOfComments: json["numberOfComments"],
    numberOfSaves: json["numberOfSaves"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "body": body,
    "title": title,
    "tags": tags,
    "city": city,
    "image_url": imageUrl,
    "country": country,
    "userId": userId,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "numberOfLikes": numberOfLikes,
    "numberOfShares": numberOfShares,
    "numberOfComments": numberOfComments,
    "numberOfSaves": numberOfSaves,
  };
}



