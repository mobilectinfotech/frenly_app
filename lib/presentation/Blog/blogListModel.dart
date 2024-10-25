// To parse this JSON data, do
//
//     final popularBlogModel = popularBlogModelFromJson(jsonString);

import 'dart:convert';

import '../../data/models/blog_model.dart';

BlogListModel popularBlogModelFromJson(String str) => BlogListModel.fromJson(json.decode(str));


class BlogListModel {
    bool? success;
    int? status;
    String? message;
    List<Blog>? blogs;

    BlogListModel({
        this.success,
        this.status,
        this.message,
        this.blogs,
    });

    factory BlogListModel.fromJson(Map<String, dynamic> json) => BlogListModel(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        blogs: json["blogs"] == null ? [] : List<Blog>.from(json["blogs"]!.map((x) => Blog.fromJson(x))),
    );


}



