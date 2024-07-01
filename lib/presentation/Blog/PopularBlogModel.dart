// To parse this JSON data, do
//
//     final popularBlogModel = popularBlogModelFromJson(jsonString);

import 'dart:convert';

import '../../data/models/blog_model.dart';

PopularBlogModel popularBlogModelFromJson(String str) => PopularBlogModel.fromJson(json.decode(str));


class PopularBlogModel {
    bool? success;
    int? status;
    String? message;
    List<Blog>? blogs;

    PopularBlogModel({
        this.success,
        this.status,
        this.message,
        this.blogs,
    });

    factory PopularBlogModel.fromJson(Map<String, dynamic> json) => PopularBlogModel(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        blogs: json["blogs"] == null ? [] : List<Blog>.from(json["blogs"]!.map((x) => Blog.fromJson(x))),
    );


}



