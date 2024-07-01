import 'dart:convert';

class CategoryModel {
  final int? status;
  final String? message;
  final bool? success;
  final List<Category>? categories;

  CategoryModel({
    this.status,
    this.message,
    this.success,
    this.categories,
  });

  factory CategoryModel.fromRawJson(String str) => CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    status: json["status"],
    message: json["message"],
    success: json["success"],
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "success": success,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
  };
}

class Category {
  final int? id;
  final String? name;
  final int? createByUserId;

  Category({
    this.id,
    this.name,
    this.createByUserId,
  });

  factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    createByUserId: json["createByUserId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "createByUserId": createByUserId,
  };
}
