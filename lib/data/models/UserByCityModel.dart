// To parse this JSON data, do
//
//     final getUserByCityModel = getUserByCityModelFromJson(jsonString);

import 'dart:convert';

GetUserByCityModel getUserByCityModelFromJson(String str) => GetUserByCityModel.fromJson(json.decode(str));

String getUserByCityModelToJson(GetUserByCityModel data) => json.encode(data.toJson());

class GetUserByCityModel {
    int? status;
    String? message;
    bool? success;
    List<User>? users;
    int? userCount;

    GetUserByCityModel({
        this.status,
        this.message,
        this.success,
        this.users,
        this.userCount,
    });

    factory GetUserByCityModel.fromJson(Map<String, dynamic> json) => GetUserByCityModel(
        status: json["status"],
        message: json["message"],
        success: json["success"],
        users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
        userCount: json["userCount"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "success": success,
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
        "userCount": userCount,
    };
}

class User {
    int? id;
    String? avatarUrl;
    String? fullName;
    String? handle;
    bool? isFollowed;
    int? numberOfFollower;

    User({
        this.id,
        this.avatarUrl,
        this.fullName,
        this.handle,
        this.isFollowed,
        this.numberOfFollower,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        avatarUrl: json["avatar_url"],
        fullName: json["full_name"],
        handle: json["handle"],
        isFollowed: json["isFollowed"],
        numberOfFollower: json["numberOfFollower"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "avatar_url": avatarUrl,
        "full_name": fullName,
        "handle": handle,
        "isFollowed": isFollowed,
        "numberOfFollower": numberOfFollower,
    };
}
