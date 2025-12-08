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
  bool? isRead;
  bool? seen;        // <-- ADD THIS
  int? isLink;
  String? isLinkId;
  String? isUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  Sender? sender;
  Chat? chat;
  String? attachmentType;     // image / video / audio / gif / file
  String? attachmentUrl;      // uploaded file URL
  String? thumbnailUrl;       // video thumbnail
  String? mimeType;           // image/png, video/mp4 etc.
  int? durationSeconds;       // audio/video duration
  int? fileSize;              // for size KB or MB


  SingleMessage({
    this.id,
    this.content,
    this.senderId,
    this.chatId,
    this.isRead,
    this.seen,       // <-- ADD THIS
    this.isLink,
    this.isLinkId,
    this.isUrl,
    this.createdAt,
    this.updatedAt,
    this.sender,
    this.chat,
    this.attachmentType,
    this.attachmentUrl,
    this.thumbnailUrl,
    this.mimeType,
    this.durationSeconds,
    this.fileSize,
  });

  factory SingleMessage.fromJson(Map<String, dynamic> json) => SingleMessage(
    id: json["id"],
    content: json["content"],
    senderId: json["senderId"],
    chatId: json["chatId"],
    isRead: json["is_read"],
    seen: json["seen"],          // <-- ADD THIS
    isLink: json["isLink"],
    isLinkId: json["isLinkId"],
    isUrl: json["isUrl"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
    chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
    // 🔥 NEW FIELDS
    attachmentType: json["attachmentType"],
    attachmentUrl: json["attachmentUrl"],
    thumbnailUrl: json["thumbnailUrl"],
    mimeType: json["mimeType"],
    durationSeconds: json["durationSeconds"],
    fileSize: json["fileSize"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
    "senderId": senderId,
    "chatId": chatId,
    "is_read": isRead,
    "seen": seen,               // <-- ADD THIS
    "isLink": isLink,
    "isLinkId": isLinkId,
    "isUrl": isUrl,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "sender": sender?.toJson(),
    "chat": chat?.toJson(),
    // 🔥 NEW FIELDS
    "attachmentType": attachmentType,
    "attachmentUrl": attachmentUrl,
    "thumbnailUrl": thumbnailUrl,
    "mimeType": mimeType,
    "durationSeconds": durationSeconds,
    "fileSize": fileSize,
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



// To parse this JSON data:
//
//     final messageModel1 = messageModel1FromJson(jsonString);
//
// import 'dart:convert';
//
// MessageModel1 messageModel1FromJson(String str) =>
//     MessageModel1.fromJson(json.decode(str));
//
// String messageModel1ToJson(MessageModel1 data) => json.encode(data.toJson());
//
// class MessageModel1 {
//   int? status;
//   String? message;
//   bool? success;
//
//   // OLD format
//   List<SingleMessage>? messages;
//
//   // NEW format
//   SingleMessage? data;
//
//   MessageModel1({
//     this.status,
//     this.message,
//     this.success,
//     this.messages,
//     this.data,
//   });
//
//   factory MessageModel1.fromJson(Map<String, dynamic> json) => MessageModel1(
//     status: json["status"],
//     message: json["message"],
//     success: json["success"],
//
//     // NEW API
//     data: json["data"] == null
//         ? null
//         : SingleMessage.fromJson(json["data"]),
//
//     // OLD API
//     messages: json["messages"] == null
//         ? []
//         : List<SingleMessage>.from(
//         json["messages"]!.map((x) => SingleMessage.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "success": success,
//     "messages": messages == null
//         ? []
//         : List<dynamic>.from(messages!.map((x) => x.toJson())),
//     "data": data?.toJson(),
//   };
// }
//
// class SingleMessage {
//   int? id;
//   String? content;
//   int? senderId;
//   int? chatId;
//
//   bool? isRead;
//   bool? seen;
//
//   int? isLink;
//   String? isLinkId;
//   String? isUrl;
//
//   // NEW FIELDS (from new response)
//   String? attachmentType;
//   String? attachmentUrl;
//   String? fileKey;
//   String? thumbnailUrl;
//   String? mimeType;
//   int? durationSeconds;
//   int? fileSize;
//
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   Sender? sender;
//   Chat? chat;
//
//   SingleMessage({
//     this.id,
//     this.content,
//     this.senderId,
//     this.chatId,
//     this.isRead,
//     this.seen,
//     this.isLink,
//     this.isLinkId,
//     this.isUrl,
//     this.attachmentType,
//     this.attachmentUrl,
//     this.fileKey,
//     this.thumbnailUrl,
//     this.mimeType,
//     this.durationSeconds,
//     this.fileSize,
//     this.createdAt,
//     this.updatedAt,
//     this.sender,
//     this.chat,
//   });
//
//   factory SingleMessage.fromJson(Map<String, dynamic> json) => SingleMessage(
//     id: json["id"],
//     content: json["content"],
//     senderId: json["senderId"],
//     chatId: json["chatId"],
//     isRead: json["is_read"],
//     seen: json["seen"],
//
//     isLink: json["isLink"],
//     isLinkId: json["isLinkId"],
//     isUrl: json["isUrl"],
//
//     attachmentType: json["attachmentType"],
//     attachmentUrl: json["attachmentUrl"],
//     fileKey: json["fileKey"],
//     thumbnailUrl: json["thumbnailUrl"],
//     mimeType: json["mimeType"],
//     durationSeconds: json["durationSeconds"],
//     fileSize: json["fileSize"],
//
//     createdAt:
//     json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//     updatedAt:
//     json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//
//     sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
//     chat: json["chat"] == null ? null : Chat.fromJson(json["chat"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "content": content,
//     "senderId": senderId,
//     "chatId": chatId,
//     "is_read": isRead,
//     "seen": seen,
//
//     "isLink": isLink,
//     "isLinkId": isLinkId,
//     "isUrl": isUrl,
//
//     "attachmentType": attachmentType,
//     "attachmentUrl": attachmentUrl,
//     "fileKey": fileKey,
//     "thumbnailUrl": thumbnailUrl,
//     "mimeType": mimeType,
//     "durationSeconds": durationSeconds,
//     "fileSize": fileSize,
//
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//
//     "sender": sender?.toJson(),
//     "chat": chat?.toJson(),
//   };
// }
//
// class Chat {
//   int? id;
//   String? name;
//   int? lastMessageId;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   Chat({
//     this.id,
//     this.name,
//     this.lastMessageId,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Chat.fromJson(Map<String, dynamic> json) => Chat(
//     id: json["id"],
//     name: json["name"],
//     lastMessageId: json["lastMessageId"],
//     createdAt:
//     json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//     updatedAt:
//     json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "lastMessageId": lastMessageId,
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//   };
// }
//
// class Sender {
//   int? id;
//   String? email;
//   String? password;
//   String? fullName;
//   String? bio;
//   String? handle;
//   String? fcmToken;
//   String? avatarUrl;
//   String? fileKey;
//   String? coverPhotoUrl;
//   String? coverfileKey;
//   String? token;
//   String? actToken;
//   bool? isVerified;
//   int? status;
//   int? numberOfFollower;
//   int? numberOfFollowing;
//   String? city;
//   String? country;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? numberOfSaves;
//   int? isOnline;
//   dynamic lastSeen;
//   bool? isPrivate;
//
//   Sender({
//     this.id,
//     this.email,
//     this.password,
//     this.fullName,
//     this.bio,
//     this.handle,
//     this.fcmToken,
//     this.avatarUrl,
//     this.fileKey,
//     this.coverPhotoUrl,
//     this.coverfileKey,
//     this.token,
//     this.actToken,
//     this.isVerified,
//     this.status,
//     this.numberOfFollower,
//     this.numberOfFollowing,
//     this.city,
//     this.country,
//     this.createdAt,
//     this.updatedAt,
//     this.numberOfSaves,
//     this.isOnline,
//     this.lastSeen,
//     this.isPrivate,
//   });
//
//   factory Sender.fromJson(Map<String, dynamic> json) => Sender(
//     id: json["id"],
//     email: json["email"],
//     password: json["password"],
//     fullName: json["full_name"],
//     bio: json["bio"],
//     handle: json["handle"],
//     fcmToken: json["fcm_token"],
//     avatarUrl: json["avatar_url"],
//     fileKey: json["fileKey"],
//     coverPhotoUrl: json["cover_photo_url"],
//     coverfileKey: json["coverfileKey"],
//     token: json["token"],
//     actToken: json["act_token"],
//     isVerified: json["isVerified"],
//     status: json["status"],
//     numberOfFollower: json["numberOfFollower"],
//     numberOfFollowing: json["numberOfFollowing"],
//     city: json["city"],
//     country: json["country"],
//     createdAt:
//     json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//     updatedAt:
//     json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//     numberOfSaves: json["numberOfSaves"],
//     isOnline: json["isOnline"],
//     lastSeen: json["lastSeen"],
//     isPrivate: json["isPrivate"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "email": email,
//     "password": password,
//     "full_name": fullName,
//     "bio": bio,
//     "handle": handle,
//     "fcm_token": fcmToken,
//     "avatar_url": avatarUrl,
//     "fileKey": fileKey,
//     "cover_photo_url": coverPhotoUrl,
//     "coverfileKey": coverfileKey,
//     "token": token,
//     "act_token": actToken,
//     "isVerified": isVerified,
//     "status": status,
//     "numberOfFollower": numberOfFollower,
//     "numberOfFollowing": numberOfFollowing,
//     "city": city,
//     "country": country,
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//     "numberOfSaves": numberOfSaves,
//     "isOnline": isOnline,
//     "lastSeen": lastSeen,
//     "isPrivate": isPrivate,
//   };
// }

