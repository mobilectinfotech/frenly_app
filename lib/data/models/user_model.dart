

// ignore_for_file: unused_import

import 'package:frenly_app/data/models/post_model.dart';
import 'package:frenly_app/data/models/vlog_model.dart';

import '../../presentation/all_saved/MySavedPosts.dart';
import '../../presentation/user_profile_screen/user_profile_model.dart';

class UserDaitails {
  int? id;
  String? email;
  String? password;
  String? fullName;
  dynamic bio;
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
  List<Post>? posts;
  List<Vlog>? vlogs;
  List<Blog>? blogs;
  int? numberOfPosts;
  bool? isFollowed;

  UserDaitails({
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
    this.posts,
    this.vlogs,
    this.blogs,
    this.numberOfPosts,
    this.isFollowed,
  });

  factory UserDaitails.fromJson(Map<String, dynamic> json) => UserDaitails(
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
    posts: json["posts"] == null ? [] : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
    vlogs: json["vlogs"] == null ? [] : List<Vlog>.from(json["vlogs"]!.map((x) => Vlog.fromJson(x))),
    blogs: json["blogs"] == null ? [] : List<Blog>.from(json["blogs"]!.map((x) => Blog.fromJson(x))),
    numberOfPosts: json["numberOfPosts"],
    isFollowed: json["isFollowed"],
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
    "posts": posts == null ? [] : List<dynamic>.from(posts!.map((x) => x.toJson())),
    "vlogs": vlogs == null ? [] : List<dynamic>.from(vlogs!.map((x) => x.toJson())),
    "blogs": blogs == null ? [] : List<dynamic>.from(blogs!.map((x) => x.toJson())),
    "numberOfPosts": numberOfPosts,
    "isFollowed": isFollowed,
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
  DateTime? createdAt;
  DateTime? updatedAt;
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

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
    id: json["id"],
    body: json["body"],
    title: json["title"],
    tags: json["tags"],
    city: json["city"],
    imageUrl: json["image_url"],
    country: json["country"],
    userId: json["userId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "numberOfLikes": numberOfLikes,
    "numberOfShares": numberOfShares,
    "numberOfComments": numberOfComments,
    "numberOfSaves": numberOfSaves,
  };
}


