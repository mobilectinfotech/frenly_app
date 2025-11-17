// To parse this JSON data, do
//
//     final mySettingModel = mySettingModelFromJson(jsonString);

import 'dart:convert';

MySettingModel mySettingModelFromJson(String str) => MySettingModel.fromJson(json.decode(str));

String mySettingModelToJson(MySettingModel data) => json.encode(data.toJson());

class MySettingModel {
    int status;
    String message;
    bool success;
    UserSetting userSetting;

    MySettingModel({
        required this.status,
        required this.message,
        required this.success,
        required this.userSetting,
    });

    factory MySettingModel.fromJson(Map<String, dynamic> json) => MySettingModel(
        status: json["status"],
        message: json["message"],
        success: json["success"],
        userSetting: UserSetting.fromJson(json["userSetting"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "success": success,
        "userSetting": userSetting.toJson(),
    };
}

class UserSetting {
    int id;
    bool lastSeen;
    int userId;
    bool commentsAllowed;
    bool chatNotification;
    bool feedNotification;
    bool hideLikes;
    String language;

    UserSetting({
      required  this.id,
      required  this.lastSeen,
      required  this.userId,
      required  this.commentsAllowed,
      required  this.chatNotification,
      required  this.feedNotification,
      required  this.hideLikes,
      required  this.language,
    });

    factory UserSetting.fromJson(Map<String, dynamic> json) => UserSetting(
        id: json["id"],
        lastSeen: json["lastSeen"],
        userId: json["userId"],
        commentsAllowed: json["commentsAllowed"],
        chatNotification: json["chatNotification"],
        feedNotification: json["feedNotification"],
        hideLikes: json["hideLikes"],
        language: json["language"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "lastSeen": lastSeen,
        "userId": userId,
        "commentsAllowed": commentsAllowed,
        "chatNotification": chatNotification,
        "feedNotification": feedNotification,
        "hideLikes": hideLikes,
        "language": language,
    };
}
