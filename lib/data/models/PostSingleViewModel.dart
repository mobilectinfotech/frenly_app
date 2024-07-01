// To parse this JSON data, do
//
//     final postSingleViewModel = postSingleViewModelFromJson(jsonString);

import 'dart:convert';

PostSingleViewModel postSingleViewModelFromJson(String str) => PostSingleViewModel.fromJson(json.decode(str));

String postSingleViewModelToJson(PostSingleViewModel data) => json.encode(data.toJson());

class PostSingleViewModel {
    int? status;
    String? message;
    bool? success;
    Post? post;

    PostSingleViewModel({
        this.status,
        this.message,
        this.success,
        this.post,
    });

    factory PostSingleViewModel.fromJson(Map<String, dynamic> json) => PostSingleViewModel(
        status: json["status"],
        message: json["message"],
        success: json["success"],
        post: json["post"] == null ? null : Post.fromJson(json["post"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "success": success,
        "post": post?.toJson(),
    };
}

class Post {
    int? id;
    String? caption;
    String? imageUrl;
    int? userId;
    int? numberOfLikes;
    int? numberOfShares;
    int? numberOfComments;
    int? numberOfSaves;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? user;
    bool? alreadySaved;
    bool? commentAllowed;

    Post({
        this.id,
        this.caption,
        this.imageUrl,
        this.userId,
        this.numberOfLikes,
        this.numberOfShares,
        this.numberOfComments,
        this.numberOfSaves,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.alreadySaved,
        this.commentAllowed,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        caption: json["caption"],
        imageUrl: json["image_url"],
        userId: json["userId"],
        numberOfLikes: json["numberOfLikes"],
        numberOfShares: json["numberOfShares"],
        numberOfComments: json["numberOfComments"],
        numberOfSaves: json["numberOfSaves"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        alreadySaved: json["alreadySaved"],
        commentAllowed: json["commentAllowed"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "caption": caption,
        "image_url": imageUrl,
        "userId": userId,
        "numberOfLikes": numberOfLikes,
        "numberOfShares": numberOfShares,
        "numberOfComments": numberOfComments,
        "numberOfSaves": numberOfSaves,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "alreadySaved": alreadySaved,
        "commentAllowed": commentAllowed,
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
    dynamic lastSeen;

    User({
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

    factory User.fromJson(Map<String, dynamic> json) => User(
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
