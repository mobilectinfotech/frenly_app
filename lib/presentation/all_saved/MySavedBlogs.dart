// To parse this JSON data, do
//
//     final mySavedBlogs = mySavedBlogsFromJson(jsonString);

import 'dart:convert';

MySavedBlogs mySavedBlogsFromJson(String str) => MySavedBlogs.fromJson(json.decode(str));

String mySavedBlogsToJson(MySavedBlogs data) => json.encode(data.toJson());

class MySavedBlogs {
    int? status;
    String? message;
    bool? success;
    List<MySavedBlog>? mySavedBlogs;

    MySavedBlogs({
        this.status,
        this.message,
        this.success,
        this.mySavedBlogs,
    });

    factory MySavedBlogs.fromJson(Map<String, dynamic> json) => MySavedBlogs(
        status: json["status"],
        message: json["message"],
        success: json["success"],
        mySavedBlogs: json["mySavedBlogs"] == null ? [] : List<MySavedBlog>.from(json["mySavedBlogs"]!.map((x) => MySavedBlog.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "success": success,
        "mySavedBlogs": mySavedBlogs == null ? [] : List<dynamic>.from(mySavedBlogs!.map((x) => x.toJson())),
    };
}

class MySavedBlog {
    int? id;
    int? blogId;
    int? saveByUserId;
    dynamic categoryId;
    DateTime? createdAt;
    DateTime? updatedAt;
    Blog? blog;

    MySavedBlog({
        this.id,
        this.blogId,
        this.saveByUserId,
        this.categoryId,
        this.createdAt,
        this.updatedAt,
        this.blog,
    });

    factory MySavedBlog.fromJson(Map<String, dynamic> json) => MySavedBlog(
        id: json["id"],
        blogId: json["blogId"],
        saveByUserId: json["saveByUserId"],
        categoryId: json["categoryId"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        blog: json["blog"] == null ? null : Blog.fromJson(json["blog"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "blogId": blogId,
        "saveByUserId": saveByUserId,
        "categoryId": categoryId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "blog": blog?.toJson(),
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
    User? user;

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
        this.user,
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
        user: json["user"] == null ? null : User.fromJson(json["user"]),
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
        "user": user?.toJson(),
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
    };
}
