import 'dart:convert';
import 'blog_model.dart';

GetBlogByIdModel getBlogByIdModelFromJson(String str) => GetBlogByIdModel.fromJson(json.decode(str));


class GetBlogByIdModel {
    int? status;
    String? message;
    bool? success;
    Blog? blog;

    GetBlogByIdModel({
        this.status,
        this.message,
        this.success,
        this.blog,
    });

    factory GetBlogByIdModel.fromJson(Map<String, dynamic> json) => GetBlogByIdModel(
        status: json["status"],
        message: json["message"],
        success: json["success"],
        blog: json["blog"] == null ? null : Blog.fromJson(json["blog"]),
    );


}


