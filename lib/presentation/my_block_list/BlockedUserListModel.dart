// To parse this JSON data, do
//
//     final blockedUserListModel = blockedUserListModelFromJson(jsonString);

import 'dart:convert';

BlockedUserListModel blockedUserListModelFromJson(String str) => BlockedUserListModel.fromJson(json.decode(str));

String blockedUserListModelToJson(BlockedUserListModel data) => json.encode(data.toJson());

class BlockedUserListModel {
    int? status;
    String? message;
    int? total;
    bool? success;
    List<MyBlockedUserList>? myBlockedUserList;

    BlockedUserListModel({
        this.status,
        this.message,
        this.total,
        this.success,
        this.myBlockedUserList,
    });

    factory BlockedUserListModel.fromJson(Map<String, dynamic> json) => BlockedUserListModel(
        status: json["status"],
        message: json["message"],
        total: json["total"],
        success: json["success"],
        myBlockedUserList: json["myBlockedUserList"] == null ? [] : List<MyBlockedUserList>.from(json["myBlockedUserList"]!.map((x) => MyBlockedUserList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "total": total,
        "success": success,
        "myBlockedUserList": myBlockedUserList == null ? [] : List<dynamic>.from(myBlockedUserList!.map((x) => x.toJson())),
    };
}

class MyBlockedUserList {
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
    DateTime? createdAt;
    DateTime? updatedAt;
    int? numberOfSaves;
    int? isOnline;
    bool? isFollowed;

    dynamic lastSeen;

    MyBlockedUserList({
        this.isFollowed,
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
    });

    factory MyBlockedUserList.fromJson(Map<String, dynamic> json) => MyBlockedUserList(
        isFollowed: true,
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
        lastSeen: json["lastSeen"],
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
        "lastSeen": lastSeen,
    };
}
