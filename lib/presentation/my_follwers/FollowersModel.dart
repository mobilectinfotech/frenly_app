import 'dart:convert';

class FollowersModel {
    bool? success;
    int? status;
    List<Follower>? followers;
    int? total;

    FollowersModel({
        this.success,
        this.status,
        this.followers,
        this.total,
    });

    factory FollowersModel.fromRawJson(String str) => FollowersModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FollowersModel.fromJson(Map<String, dynamic> json) => FollowersModel(
        success: json["success"],
        status: json["status"],
        followers: json["followers"] == null ? [] : List<Follower>.from(json["followers"]!.map((x) => Follower.fromJson(x))),
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "followers": followers == null ? [] : List<dynamic>.from(followers!.map((x) => x.toJson())),
        "total": total,
    };
}

class Follower {
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
    int? followState;

    Follower({
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
        this.followState,
    });

    factory Follower.fromRawJson(String str) => Follower.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Follower.fromJson(Map<String, dynamic> json) => Follower(
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
        followState: json["followState"],
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
        "followState": followState,
    };
}
