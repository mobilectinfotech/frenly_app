// To parse this JSON data, do
//
//     final lastSeenModel = lastSeenModelFromJson(jsonString);

import 'dart:convert';

LastSeenModel lastSeenModelFromJson(String str) => LastSeenModel.fromJson(json.decode(str));

String lastSeenModelToJson(LastSeenModel data) => json.encode(data.toJson());

class LastSeenModel {
    int? status;
    String? message;
    bool? success;
    Data? data;

    LastSeenModel({
        this.status,
        this.message,
        this.success,
        this.data,
    });

    factory LastSeenModel.fromJson(Map<String, dynamic> json) => LastSeenModel(
        status: json["status"],
        message: json["message"],
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "success": success,
        "data": data?.toJson(),
    };
}

class Data {
    bool? isLastSeenAllowed;
    DateTime? lastSeen;

    Data({
        this.isLastSeenAllowed,
        this.lastSeen,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        isLastSeenAllowed: json["isLastSeenAllowed"],
        lastSeen: json["lastSeen"] == null ? null : DateTime.parse(json["lastSeen"]),
    );

    Map<String, dynamic> toJson() => {
        "isLastSeenAllowed": isLastSeenAllowed,
        "lastSeen": lastSeen?.toIso8601String(),
    };
}
