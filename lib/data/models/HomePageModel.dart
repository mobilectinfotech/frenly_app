// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

import 'package:frenly_app/data/models/post_model.dart';
import 'package:frenly_app/data/models/vlog_model.dart';

import '../../presentation/all_saved/MySavedPosts.dart';
import 'DiscoverUsersModel.dart';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
    bool? success;
    String? message;
    int? status;
    List<UsersInCity>? usersInCities;
    List<Vlog>? vlogs;
    List<Blog>? blogs;
    List<DiscoverUser>? discoverUsers;
    List<Post>? posts;

    HomeModel({
        this.success,
        this.message,
        this.status,
        this.usersInCities,
        this.vlogs,
        this.blogs,
        this.discoverUsers,
        this.posts,
    });

    factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        success: json["success"],
        message: json["message"],
        status: json["status"],
        usersInCities: json["usersInCities"] == null ? [] : List<UsersInCity>.from(json["usersInCities"]!.map((x) => UsersInCity.fromJson(x))),
        vlogs: json["vlogs"] == null ? [] : List<Vlog>.from(json["vlogs"]!.map((x) => Vlog.fromJson(x))),
        blogs: json["blogs"] == null ? [] : List<Blog>.from(json["blogs"]!.map((x) => Blog.fromJson(x))),
        discoverUsers: json["discoverUsers"] == null ? [] : List<DiscoverUser>.from(json["discoverUsers"]!.map((x) => DiscoverUser.fromJson(x))),
        posts: json["posts"] == null ? [] : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
        "usersInCities": usersInCities == null ? [] : List<dynamic>.from(usersInCities!.map((x) => x.toJson())),
        "vlogs": vlogs == null ? [] : List<dynamic>.from(vlogs!.map((x) => x.toJson())),
        "blogs": blogs == null ? [] : List<dynamic>.from(blogs!.map((x) => x.toJson())),
        "discoverUsers": discoverUsers == null ? [] : List<dynamic>.from(discoverUsers!.map((x) => x.toJson())),
        "posts": posts == null ? [] : List<dynamic>.from(posts!.map((x) => x.toJson())),
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




class PostUser {
    String? avatarUrl;
    String? coverPhotoUrl;
    String? fullName;
    int? id;

    PostUser({
        this.avatarUrl,
        this.coverPhotoUrl,
        this.fullName,
        this.id,
    });

    factory PostUser.fromJson(Map<String, dynamic> json) => PostUser(
        avatarUrl: json["avatar_url"],
        coverPhotoUrl: json["cover_photo_url"],
        fullName: json["full_name"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "avatar_url": avatarUrl,
        "cover_photo_url": coverPhotoUrl,
        "full_name": fullName,
        "id": id,
    };
}

class UsersInCity {
    String? city;
    int? userCount;
    List<UserElement>? users;
    String? country;

    UsersInCity({
        this.city,
        this.userCount,
        this.users,
        this.country,
    });

    factory UsersInCity.fromJson(Map<String, dynamic> json) => UsersInCity(
        city: json["city"],
        userCount: json["userCount"],
        users: json["users"] == null ? [] : List<UserElement>.from(json["users"]!.map((x) => UserElement.fromJson(x))),
        country: json["country"],
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "userCount": userCount,
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
        "country": country,
    };
}

class UserElement {
    int? id;
    String? avatarUrl;
    String? country;

    UserElement({
        this.id,
        this.avatarUrl,
        this.country,
    });

    factory UserElement.fromJson(Map<String, dynamic> json) => UserElement(
        id: json["id"],
        avatarUrl: json["avatar_url"],
        country: json["country"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "avatar_url": avatarUrl,
        "country": country,
    };
}


