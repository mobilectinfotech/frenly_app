// To parse this JSON data, do
//
//     final chatsModel = chatsModelFromJson(jsonString);

import 'dart:convert';

ChatsModel chatsModelFromJson(String str) => ChatsModel.fromJson(json.decode(str));

String chatsModelToJson(ChatsModel data) => json.encode(data.toJson());

class ChatsModel {
  int? status;
  String? message;
  bool? success;
  List<Chat>? chats;

  ChatsModel({
    this.status,
    this.message,
    this.success,
    this.chats,
  });

  factory ChatsModel.fromJson(Map<String, dynamic> json) => ChatsModel(
    status: json["status"],
    message: json["message"],
    success: json["success"],
    chats: json["chats"] == null ? [] : List<Chat>.from(json["chats"]!.map((x) => Chat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "success": success,
    "chats": chats == null ? [] : List<dynamic>.from(chats!.map((x) => x.toJson())),
  };
}

class Chat {
  int? id;
  String? name;
  int? lastMessageId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Participant>? participants;
  LastMessage? lastMessage;
  int? unreadCount;

  Chat({
    this.id,
    this.name,
    this.lastMessageId,
    this.createdAt,
    this.updatedAt,
    this.participants,
    this.lastMessage,
    this.unreadCount,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    id: json["id"],
    name: json["name"],
    lastMessageId: json["lastMessageId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    participants: json["participants"] == null ? [] : List<Participant>.from(json["participants"]!.map((x) => Participant.fromJson(x))),
    lastMessage: json["lastMessage"] == null ? null : LastMessage.fromJson(json["lastMessage"]),
    unreadCount: json["unreadCount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "lastMessageId": lastMessageId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "participants": participants == null ? [] : List<dynamic>.from(participants!.map((x) => x.toJson())),
    "lastMessage": lastMessage?.toJson(),
    "unreadCount": unreadCount,
  };
}

class LastMessage {
  int? id;
  String? content;
  int? senderId;
  int? chatId;
  DateTime? createdAt;
  DateTime? updatedAt;

  LastMessage({
    this.id,
    this.content,
    this.senderId,
    this.chatId,
    this.createdAt,
    this.updatedAt,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    id: json["id"],
    content: json["content"],
    senderId: json["senderId"],
    chatId: json["chatId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "senderId": senderId,
    "chatId": chatId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Participant {
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

  Participant({
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

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
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
