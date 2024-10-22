import 'dart:convert';

import 'package:get/get.dart';

class GetCommentsModel {
    int? status;
    String? message;
    bool? success;
    List<Comment>? comments;

    GetCommentsModel({
        this.status,
        this.message,
        this.success,
        this.comments,
    });

    factory GetCommentsModel.fromRawJson(String str) => GetCommentsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetCommentsModel.fromJson(Map<String, dynamic> json) => GetCommentsModel(
        status: json["status"],
        message: json["message"],
        success: json["success"],
        comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "success": success,
        "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
    };
}

class Comment {
    int? id;
    String? content;
    int? vlogId;
    int? createByUserId;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? user;
    bool? isMyComment;
    RxInt numberOfLikes=0.obs;
    RxBool isLikedByMe =false.obs;

    Comment({
        this.id,
        this.content,
        this.vlogId,
        this.createByUserId,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.isMyComment,
       required this.isLikedByMe,
        required this.numberOfLikes,

    });

    factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        content: json["content"],
        vlogId: json["vlogId"],
        createByUserId: json["createByUserId"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        isMyComment: json["isMyComment"],
        numberOfLikes: RxInt(json["numberOfLikes"]??0),
        isLikedByMe: RxBool(json["isLikedByMe"]??false),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "vlogId": vlogId,
        "createByUserId": createByUserId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "isMyComment": isMyComment,
        "numberOfLikes": numberOfLikes,
        "isLikedByMe": isLikedByMe,
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
    String? fileKey;
    String? coverPhotoUrl;
    String? coverfileKey;
    String? token;
    String? actToken;
    bool? isVerified;
    int? status;
    int? numberOfFollower;
    int? numberOfFollowing;
    String? city;
    String? country;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? numberOfSaves;
    int? isOnline;
    dynamic lastSeen;
    bool? isPrivate;

    User({
        this.id,
        this.email,
        this.password,
        this.fullName,
        this.bio,
        this.handle,
        this.fcmToken,
        this.avatarUrl,
        this.fileKey,
        this.coverPhotoUrl,
        this.coverfileKey,
        this.token,
        this.actToken,
        this.isVerified,
        this.status,
        this.numberOfFollower,
        this.numberOfFollowing,
        this.city,
        this.country,
        this.createdAt,
        this.updatedAt,
        this.numberOfSaves,
        this.isOnline,
        this.lastSeen,
        this.isPrivate,
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
        fileKey: json["fileKey"],
        coverPhotoUrl: json["cover_photo_url"],
        coverfileKey: json["coverfileKey"],
        token: json["token"],
        actToken: json["act_token"],
        isVerified: json["isVerified"],
        status: json["status"],
        numberOfFollower: json["numberOfFollower"],
        numberOfFollowing: json["numberOfFollowing"],
        city: json["city"],
        country: json["country"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        numberOfSaves: json["numberOfSaves"],
        isOnline: json["isOnline"],
        lastSeen: json["lastSeen"],
        isPrivate: json["isPrivate"],
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
        "fileKey": fileKey,
        "cover_photo_url": coverPhotoUrl,
        "coverfileKey": coverfileKey,
        "token": token,
        "act_token": actToken,
        "isVerified": isVerified,
        "status": status,
        "numberOfFollower": numberOfFollower,
        "numberOfFollowing": numberOfFollowing,
        "city": city,
        "country": country,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "numberOfSaves": numberOfSaves,
        "isOnline": isOnline,
        "lastSeen": lastSeen,
        "isPrivate": isPrivate,
    };
}
