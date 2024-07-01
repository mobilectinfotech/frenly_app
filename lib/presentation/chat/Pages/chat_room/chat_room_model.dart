// To parse this JSON data, do
//
//     final messageModel1 = messageModel1FromJson(jsonString);

import 'dart:convert';

MessageModel1 messageModel1FromJson(String str) => MessageModel1.fromJson(json.decode(str));

String messageModel1ToJson(MessageModel1 data) => json.encode(data.toJson());

class MessageModel1 {
  int? status;
  String? message;
  bool? success;
  List<SingleMessage>? messages;

  MessageModel1({
    this.status,
    this.message,
    this.success,
    this.messages,
  });

  factory MessageModel1.fromJson(Map<String, dynamic> json) => MessageModel1(
    status: json["status"],
    message: json["message"],
    success: json["success"],
    messages: json["messages"] == null ? [] : List<SingleMessage>.from(json["messages"]!.map((x) => SingleMessage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "success": success,
    "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x.toJson())),
  };
}

class SingleMessage {
  int? id;
  String? content;
  int? senderId;
  int? chatId;
  int? isLink;
  String? isLinkId;
  String? isUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  Sender? sender;
  Chat? chat;

  SingleMessage({
    this.id,
    this.content,
    this.senderId,
    this.chatId,
    this.isLink,
    this.isLinkId,
    this.isUrl,
    this.createdAt,
    this.updatedAt,
    this.sender,
    this.chat,
  });

  factory SingleMessage.fromJson(Map<String, dynamic> json) => SingleMessage(
    id: json["id"],
    content: json["content"],
    senderId: json["senderId"],
    chatId: json["chatId"],
    isLink: json["isLink"],
    isLinkId: json["isLinkId"],
    isUrl: json["isUrl"],
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
    "isLink": isLink,
    "isLinkId": isLinkId,
    "isUrl": isUrl,
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
  String? bio;
  String? handle;
  String? fcmToken;
  String? avatarUrl;
  String? coverPhotoUrl;
  String? token;
  String? actToken;
  bool? isVerified;
  int? numberOfFollower;
  int? numberOfFollowing;
  String? city;
  String? country;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? numberOfSaves;
  int? isOnline;
  dynamic lastSeen;

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
    this.isOnline,
    this.lastSeen,
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
    isOnline: json["isOnline"],
    lastSeen: json["lastSeen"],
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
    "isOnline": isOnline,
    "lastSeen": lastSeen,
  };
}
