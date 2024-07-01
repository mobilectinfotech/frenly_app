import 'dart:convert';

class NotificationsModel {
    final bool? success;
    final int? status;
    final String? message;
    final List<Notification>? notifications;
    final int? total;
    final int? unRead;

    NotificationsModel({
        this.success,
        this.status,
        this.message,
        this.notifications,
        this.total,
        this.unRead,
    });

    factory NotificationsModel.fromRawJson(String str) => NotificationsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        notifications: json["notifications"] == null ? [] : List<Notification>.from(json["notifications"]!.map((x) => Notification.fromJson(x))),
        total: json["total"],
        unRead: json["unRead"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "notifications": notifications == null ? [] : List<dynamic>.from(notifications!.map((x) => x.toJson())),
        "total": total,
        "unRead": unRead,
    };
}

class Notification {
    final int? id;
    final int? byUserId;
    final int? toUserId;
    final bool? isRead;
    final String? content;
    final Data? data;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final ByUser? byUser;

    Notification({
        this.id,
        this.byUserId,
        this.toUserId,
        this.isRead,
        this.content,
        this.data,
        this.createdAt,
        this.updatedAt,
        this.byUser,
    });

    factory Notification.fromRawJson(String str) => Notification.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        byUserId: json["byUserId"],
        toUserId: json["toUserId"],
        isRead: json["isRead"],
        content: json["content"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        byUser: json["byUser"] == null ? null : ByUser.fromJson(json["byUser"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "byUserId": byUserId,
        "toUserId": toUserId,
        "isRead": isRead,
        "content": content,
        "data": data?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "byUser": byUser?.toJson(),
    };
}

class ByUser {
    final int? id;
    final String? email;
    final String? password;
    final String? fullName;
    final String? bio;
    final String? handle;
    final String? fcmToken;
    final String? avatarUrl;
    final dynamic coverPhotoUrl;
    final dynamic token;
    final String? actToken;
    final bool? isVerified;
    final int? numberOfFollower;
    final int? numberOfFollowing;
    final String? city;
    final String? country;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? numberOfSaves;
    final int? isOnline;
    final DateTime? lastSeen;

    ByUser({
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

    factory ByUser.fromRawJson(String str) => ByUser.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ByUser.fromJson(Map<String, dynamic> json) => ByUser(
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
        lastSeen: json["lastSeen"] == null ? null : DateTime.parse(json["lastSeen"]),
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
        "lastSeen": lastSeen?.toIso8601String(),
    };
}

class Data {
    final int? userId;
    final int? vlogId;

    Data({
        this.userId,
        this.vlogId,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userId"],
        vlogId: json["vlogId"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "vlogId": vlogId,
    };
}
