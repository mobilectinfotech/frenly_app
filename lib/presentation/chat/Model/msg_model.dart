// To parse this JSON data, do
//
//     final getSingleMsgModel = getSingleMsgModelFromJson(jsonString);

import 'dart:convert';

GetSingleMsgModel getSingleMsgModelFromJson(String str) => GetSingleMsgModel.fromJson(json.decode(str));

String getSingleMsgModelToJson(GetSingleMsgModel data) => json.encode(data.toJson());

class GetSingleMsgModel {
  int? status;
  Message? message;
  bool? success;

  GetSingleMsgModel({
    this.status,
    this.message,
    this.success,
  });

  factory GetSingleMsgModel.fromJson(Map<String, dynamic> json) => GetSingleMsgModel(
    status: json["status"],
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message?.toJson(),
    "success": success,
  };
}

class Message {
  int? id;
  String? content;
  int? senderId;
  int? chatId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Sender? sender;
  Chat? chat;

  Message({
    this.id,
    this.content,
    this.senderId,
    this.chatId,
    this.createdAt,
    this.updatedAt,
    this.sender,
    this.chat,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    id: json["id"],
    content: json["content"],
    senderId: json["senderId"],
    chatId: json["chatId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
    chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "senderId": senderId,
    "chatId": chatId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "sender": sender?.toJson(),
    "chat": chat?.toJson(),
  };
}

class Chat {
  int? id;
  String? name;
  int? lastMessageId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Chat({
    this.id,
    this.name,
    this.lastMessageId,
    this.createdAt,
    this.updatedAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    id: json["id"],
    name: json["name"],
    lastMessageId: json["lastMessageId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "lastMessageId": lastMessageId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Sender {
  int? id;
  String? email;
  String? password;
  String? fullName;
  dynamic bio;
  dynamic handle;
  dynamic fcmToken;
  String? avatarUrl;
  String? coverPhotoUrl;
  dynamic token;
  String? actToken;
  bool? isVerified;
  int? numberOfFollower;
  int? numberOfFollowing;
  String? city;
  String? country;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? numberOfSaves;

  Sender({
    this.id,
    this.email,
    this.password,
    this.fullName,
    this.bio,
    this.handle,
    this.fcmToken,
    this.avatarUrl,
    this.coverPhotoUrl,
    this.token,
    this.actToken,
    this.isVerified,
    this.numberOfFollower,
    this.numberOfFollowing,
    this.city,
    this.country,
    this.createdAt,
    this.updatedAt,
    this.numberOfSaves,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["id"],
    email: json["email"],
    password: json["password"],
    fullName: json["full_name"],
    bio: json["bio"],
    handle: json["handle"],
    fcmToken: json["fcm_token"],
    avatarUrl: json["avatar_url"],
    coverPhotoUrl: json["cover_photo_url"],
    token: json["token"],
    actToken: json["act_token"],
    isVerified: json["isVerified"],
    numberOfFollower: json["numberOfFollower"],
    numberOfFollowing: json["numberOfFollowing"],
    city: json["city"],
    country: json["country"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    numberOfSaves: json["numberOfSaves"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "password": password,
    "full_name": fullName,
    "bio": bio,
    "handle": handle,
    "fcm_token": fcmToken,
    "avatar_url": avatarUrl,
    "cover_photo_url": coverPhotoUrl,
    "token": token,
    "act_token": actToken,
    "isVerified": isVerified,
    "numberOfFollower": numberOfFollower,
    "numberOfFollowing": numberOfFollowing,
    "city": city,
    "country": country,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "numberOfSaves": numberOfSaves,
  };
}
