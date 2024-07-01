import 'dart:convert';

SertchUserModel sertchUserModelFromJson(String str) => SertchUserModel.fromJson(json.decode(str));

String sertchUserModelToJson(SertchUserModel data) => json.encode(data.toJson());

class SertchUserModel {
    bool? success;
    String? message;
    List<User>? users;
    int? status;

    SertchUserModel({
        this.success,
        this.message,
        this.users,
        this.status,
    });

    factory SertchUserModel.fromJson(Map<String, dynamic> json) => SertchUserModel(
        success: json["success"],
        message: json["message"],
        users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
        "status": status,
    };
}

class User {
    int? id;
    String? fullName;
    String? avatarUrl;
    String? handle;

    User({
        this.id,
        this.fullName,
        this.avatarUrl,
        this.handle,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["full_name"],
        avatarUrl: json["avatar_url"],
        handle: json["handle"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "avatar_url": avatarUrl,
        "handle": handle,
    };
}
