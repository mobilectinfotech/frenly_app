// To parse this JSON data, do
//
//     final getUserByCityModel = getUserByCityModelFromJson(jsonString);

import 'dart:convert';

import 'DiscoverUsersModel.dart';

GetUserByCityModel getUserByCityModelFromJson(String str) => GetUserByCityModel.fromJson(json.decode(str));

String getUserByCityModelToJson(GetUserByCityModel data) => json.encode(data.toJson());

class GetUserByCityModel {
    int? status;
    String? message;
    bool? success;
    List<DiscoverUser>? users;
    int? userCount;

    GetUserByCityModel({
        this.status,
        this.message,
        this.success,
        this.users,
        this.userCount,
    });

    factory GetUserByCityModel.fromJson(Map<String, dynamic> json) => GetUserByCityModel(
        status: json["status"],
        message: json["message"],
        success: json["success"],
        users: json["users"] == null ? [] : List<DiscoverUser>.from(json["users"]!.map((x) => DiscoverUser.fromJson(x))),
        userCount: json["userCount"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "success": success,
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
        "userCount": userCount,
    };
}

