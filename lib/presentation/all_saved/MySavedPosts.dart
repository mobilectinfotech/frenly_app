// To parse this JSON data, do
//
//     final mySavedPosts = mySavedPostsFromJson(jsonString);

import 'dart:convert';

import '../../data/models/post_model.dart';

MySavedPosts mySavedPostsFromJson(String str) => MySavedPosts.fromJson(json.decode(str));

String mySavedPostsToJson(MySavedPosts data) => json.encode(data.toJson());

class MySavedPosts {
    int? status;
    String? message;
    bool? success;
    List<MySavedPost>? mySavedPosts;

    MySavedPosts({
        this.status,
        this.message,
        this.success,
        this.mySavedPosts,
    });

    factory MySavedPosts.fromJson(Map<String, dynamic> json) => MySavedPosts(
        status: json["status"],
        message: json["message"],
        success: json["success"],
        mySavedPosts: json["mySavedPosts"] == null ? [] : List<MySavedPost>.from(json["mySavedPosts"]!.map((x) => MySavedPost.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "success": success,
        "mySavedPosts": mySavedPosts == null ? [] : List<dynamic>.from(mySavedPosts!.map((x) => x.toJson())),
    };
}

class MySavedPost {
    int? id;
    int? postId;
    int? saveByUserId;
    dynamic categoryId;
    DateTime? createdAt;
    DateTime? updatedAt;
    Post? post;

    MySavedPost({
        this.id,
        this.postId,
        this.saveByUserId,
        this.categoryId,
        this.createdAt,
        this.updatedAt,
        this.post,
    });

    factory MySavedPost.fromJson(Map<String, dynamic> json) => MySavedPost(
        id: json["id"],
        postId: json["postId"],
        saveByUserId: json["saveByUserId"],
        categoryId: json["categoryId"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        post: json["post"] == null ? null : Post.fromJson(json["post"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "postId": postId,
        "saveByUserId": saveByUserId,
        "categoryId": categoryId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "post": post?.toJson(),
    };
}




