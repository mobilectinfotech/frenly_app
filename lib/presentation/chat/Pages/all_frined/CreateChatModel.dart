// To parse this JSON data, do
//
//     final createChatModel = createChatModelFromJson(jsonString);

import 'dart:convert';

import '../chats/chats_model.dart';

CreateChatModel createChatModelFromJson(String str) => CreateChatModel.fromJson(json.decode(str));

String createChatModelToJson(CreateChatModel data) => json.encode(data.toJson());

class CreateChatModel {
    int? status;
    String? message;
    bool? success;
    Payload? payload;

    CreateChatModel({
        this.status,
        this.message,
        this.success,
        this.payload,
    });

    factory CreateChatModel.fromJson(Map<String, dynamic> json) => CreateChatModel(
        status: json["status"],
        message: json["message"],
        success: json["success"],
        payload: json["payload"] == null ? null : Payload.fromJson(json["payload"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "success": success,
        "payload": payload?.toJson(),
    };
}

class Payload {
    int? id;
    String? name;
    dynamic lastMessageId;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<Participant>? participants;

    Payload({
        this.id,
        this.name,
        this.lastMessageId,
        this.createdAt,
        this.updatedAt,
        this.participants,
    });

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        id: json["id"],
        name: json["name"],
        lastMessageId: json["lastMessageId"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastMessageId": lastMessageId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
    };
}

