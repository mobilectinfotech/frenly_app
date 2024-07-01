// To parse this JSON data, do
//
//     final allFriendsModel = allFriendsModelFromJson(jsonString);

import 'dart:convert';

AllFriendsModel allFriendsModelFromJson(String str) => AllFriendsModel.fromJson(json.decode(str));

String allFriendsModelToJson(AllFriendsModel data) => json.encode(data.toJson());

class AllFriendsModel {
    bool? success;
    int? status;
    String? message;
    List<Friend>? friends;

    AllFriendsModel({
        this.success,
        this.status,
        this.message,
        this.friends,
    });

    factory AllFriendsModel.fromJson(Map<String, dynamic> json) => AllFriendsModel(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        friends: json["friends"] == null ? [] : List<Friend>.from(json["friends"]!.map((x) => Friend.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "friends": friends == null ? [] : List<dynamic>.from(friends!.map((x) => x.toJson())),
    };
}

class Friend {
    int? id;
    String? fullName;
    String? avatarUrl;
    String? handle;
    int? numberOfFollower;

    Friend({
        this.id,
        this.fullName,
        this.avatarUrl,
        this.handle,
        this.numberOfFollower,
    });

    factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        id: json["id"],
        fullName: json["full_name"],
        avatarUrl: json["avatar_url"],
        handle: json["handle"],
        numberOfFollower: json["numberOfFollower"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "avatar_url": avatarUrl,
        "handle": handle,
        "numberOfFollower": numberOfFollower,
    };
}
