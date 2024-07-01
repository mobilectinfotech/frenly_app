import 'dart:convert';

class NotificationsModel {
    bool? success;
    int? status;
    String? message;
    List<Notification>? notifications;
    int? total;
    int? unRead;

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
    int? id;
    int? byUserId;
    int? toUserId;
    bool? isRead;
    String? content;
    String? type;
    int? followStatus;
    Data? data;
    DateTime? createdAt;
    DateTime? updatedAt;
    ByUser? byUser;

    Notification({
        this.id,
        this.byUserId,
        this.toUserId,
        this.isRead,
        this.content,
        this.type,
        this.followStatus,
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
        type: json["type"],
        followStatus: json["followStatus"],
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
        "type": type,
        "followStatus": followStatus,
        "data": data?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "byUser": byUser?.toJson(),
    };
}

class ByUser {
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
    DateTime? lastSeen;
    bool? isPrivate;

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
        this.isPrivate,
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
        isPrivate: json["isPrivate"],
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
        "isPrivate": isPrivate,
    };
}

class Data {
    int? id;
    String? imageUrl;
    String? videoUrl;
    String? thumbnailUrl;

    Data({
        this.id,
        this.imageUrl,
        this.videoUrl,
        this.thumbnailUrl,
    });

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        imageUrl: json["image_url"],
        videoUrl: json["video_url"],
        thumbnailUrl: json["thumbnail_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "video_url": videoUrl,
        "thumbnail_url": thumbnailUrl,
    };
}
