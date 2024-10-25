import 'dart:convert';
import '../../data/models/blog_model.dart';

BlogModel getBlogByIdModelFromJson(String str) => BlogModel.fromJson(json.decode(str));


class BlogModel {
  int? status;
  String? message;
  bool? success;
  Blog? blog;

  BlogModel({
    this.status,
    this.message,
    this.success,
    this.blog,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
    status: json["status"],
    message: json["message"],
    success: json["success"],
    blog: json["blog"] == null ? null : Blog.fromJson(json["blog"]),
  );


}


