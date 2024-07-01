
class Post {
  int? id;
  String? caption;
  String? imageUrl;
  int? userId;
  int? numberOfLikes;
  int? numberOfShares;
  int? numberOfComments;
  int? numberOfSaves;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  bool? alreadySaved;
  bool? alreadyLiked ;

  Post({
    this.id,
    this.caption,
    this.imageUrl,
    this.userId,
    this.numberOfLikes,
    this.numberOfShares,
    this.numberOfComments,
    this.numberOfSaves,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.alreadySaved,
    this.alreadyLiked
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    alreadyLiked: json["alreadyLiked"] ?? false,
    caption: json["caption"],
    imageUrl: json["image_url"],
    userId: json["userId"],
    numberOfLikes: json["numberOfLikes"],
    numberOfShares: json["numberOfShares"],
    numberOfComments: json["numberOfComments"],
    numberOfSaves: json["numberOfSaves"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    alreadySaved: json["alreadySaved"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "caption": caption,
    "image_url": imageUrl,
    "userId": userId,
    "numberOfLikes": numberOfLikes,
    "numberOfShares": numberOfShares,
    "numberOfComments": numberOfComments,
    "numberOfSaves": numberOfSaves,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
    "alreadySaved": alreadySaved,
  };
}

class User {
  int? id;
  String? email;
  String? password;
  String? fullName;
  dynamic bio;
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

  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
