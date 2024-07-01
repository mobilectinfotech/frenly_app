// To parse this JSON data, do
//
//     final discoverUsersModel = discoverUsersModelFromJson(jsonString);

import 'dart:convert';

DiscoverUsersModel discoverUsersModelFromJson(String str) => DiscoverUsersModel.fromJson(json.decode(str));

String discoverUsersModelToJson(DiscoverUsersModel data) => json.encode(data.toJson());

class DiscoverUsersModel {
    bool? success;
    int? status;
    String? message;
    List<DiscoverUser>? discoverUsers;

    DiscoverUsersModel({
        this.success,
        this.status,
        this.message,
        this.discoverUsers,
    });

    factory DiscoverUsersModel.fromJson(Map<String, dynamic> json) => DiscoverUsersModel(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        discoverUsers: json["discoverUsers"] == null ? [] : List<DiscoverUser>.from(json["discoverUsers"]!.map((x) => DiscoverUser.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "discoverUsers": discoverUsers == null ? [] : List<dynamic>.from(discoverUsers!.map((x) => x.toJson())),
    };
}

class DiscoverUser {
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
    int ? followState;

    DiscoverUser({
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
        this.followState,
    });

    factory DiscoverUser.fromJson(Map<String, dynamic> json) => DiscoverUser(
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
        "isFollowed": followState
        ,
    };
}
