// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

import 'package:frenly_app/data/models/post_model.dart';
import 'package:frenly_app/data/models/vlog_model.dart';

import '../../presentation/all_saved/MySavedBlogs.dart';
import '../../presentation/all_saved/MySavedPosts.dart';
import 'DiscoverUsersModel.dart';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));


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


