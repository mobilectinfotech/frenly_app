// To parse this JSON data, do
//
//     final liveUserModel = liveUserModelFromJson(jsonString);

import 'dart:convert';

LiveUserModel liveUserModelFromJson(String str) => LiveUserModel.fromJson(json.decode(str));

String liveUserModelToJson(LiveUserModel data) => json.encode(data.toJson());

class LiveUserModel {
    bool? success;
    int? status;
    String? message;
    List<ActiveFriend>? activeFriends;

    LiveUserModel({
        this.success,
        this.status,
        this.message,
        this.activeFriends,
    });

    factory LiveUserModel.fromJson(Map<String, dynamic> json) => LiveUserModel(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        activeFriends: json["activeFriends"] == null ? [] : List<ActiveFriend>.from(json["activeFriends"]!.map((x) => ActiveFriend.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "activeFriends": activeFriends == null ? [] : List<dynamic>.from(activeFriends!.map((x) => x.toJson())),
    };
}

class ActiveFriend {
    String? city;
    int? userCount;
    List<User>? users;
    String? country;

    ActiveFriend({
        this.city,
        this.userCount,
        this.users,
        this.country,
    });

    factory ActiveFriend.fromJson(Map<String, dynamic> json) => ActiveFriend(
        city: json["city"],
        userCount: json["userCount"],
        users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
        country: json["country"],
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "userCount": userCount,
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
        "country": country,
    };
}

class User {
    int? id;
    String? avatarUrl;
    String? country;

    User({
        this.id,
        this.avatarUrl,
        this.country,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
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
