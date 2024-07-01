// To parse this JSON data, do
//
//     final getAllPostsModel = getAllPostsModelFromJson(jsonString);

import 'dart:convert';

import '../../../data/models/post_model.dart';


PhotosListsModel getAllPostsModelFromJson(String str) => PhotosListsModel.fromJson(json.decode(str));

String getAllPostsModelToJson(PhotosListsModel data) => json.encode(data.toJson());

class PhotosListsModel {
    bool? success;
    int? status;
    String? message;
    List<Post>? posts;

    PhotosListsModel({
        this.success,
        this.status,
        this.message,
        this.posts,
    });

    factory PhotosListsModel.fromJson(Map<String, dynamic> json) => PhotosListsModel(
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
