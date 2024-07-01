// To parse this JSON data, do
//
//     final getAllPostsModel = getAllPostsModelFromJson(jsonString);

import 'dart:convert';

import '../../../data/models/post_model.dart';


GetAllPostsModel getAllPostsModelFromJson(String str) => GetAllPostsModel.fromJson(json.decode(str));

String getAllPostsModelToJson(GetAllPostsModel data) => json.encode(data.toJson());

class GetAllPostsModel {
    bool? success;
    int? status;
    String? message;
    List<Post>? posts;

    GetAllPostsModel({
        this.success,
        this.status,
        this.message,
        this.posts,
    });

    factory GetAllPostsModel.fromJson(Map<String, dynamic> json) => GetAllPostsModel(
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
