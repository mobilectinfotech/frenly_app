// To parse this JSON data, do
//
//     final getAllPostsModel = getAllPostsModelFromJson(jsonString);

import 'dart:convert';

import '../../data/models/post_model.dart';


PostListsModel getAllPostsModelFromJson(String str) => PostListsModel.fromJson(json.decode(str));

String getAllPostsModelToJson(PostListsModel data) => json.encode(data.toJson());

class PostListsModel {
    bool? success;
    int? status;
    String? message;
    List<Post>? posts;

    PostListsModel({
        this.success,
        this.status,
        this.message,
        this.posts,
    });

    factory PostListsModel.fromJson(Map<String, dynamic> json) => PostListsModel(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        posts: json["posts"] == null ? [] : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "posts": posts == null ? [] : List<dynamic>.from(posts!.map((x) => x.toJson())),
    };
}
