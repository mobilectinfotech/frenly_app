// To parse this JSON data, do
//
//     final skinfactsModel = skinfactsModelFromJson(jsonString);

import 'dart:convert';

SkinfactsModel skinfactsModelFromJson(String str) => SkinfactsModel.fromJson(json.decode(str));

String skinfactsModelToJson(SkinfactsModel data) => json.encode(data.toJson());

class SkinfactsModel {
    int? status;
    bool? success;
    UserSkinfacts? userSkinfacts;
    String? message;

    SkinfactsModel({
        this.status,
        this.success,
        this.userSkinfacts,
        this.message,
    });

    factory SkinfactsModel.fromJson(Map<String, dynamic> json) => SkinfactsModel(
        status: json["status"],
        success: json["success"],
        userSkinfacts: json["user_skinfacts"] == null ? null : UserSkinfacts.fromJson(json["user_skinfacts"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "user_skinfacts": userSkinfacts?.toJson(),
        "message": message,
    };
}

class UserSkinfacts {
    int? id;
    int? userId;
    String? description;
    String? date;
    DateTime? createdAt;

    UserSkinfacts({
        this.id,
        this.userId,
        this.description,
        this.date,
        this.createdAt,
    });

    factory UserSkinfacts.fromJson(Map<String, dynamic> json) => UserSkinfacts(
        id: json["id"],
        userId: json["user_id"],
        description: json["description"],
        date: json["date"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "description": description,
        "date": date,
        "created_at": createdAt?.toIso8601String(),
    };
}
