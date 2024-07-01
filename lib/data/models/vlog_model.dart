
import '../../presentation/user_profile_screen/user_profile_model.dart';

class Vlog {
  int? id;
  String? title;
  String? description;
  String? videoUrl;
  String? thumbnailUrl;
  int? userId;
  int? numberOfLikes;
  int? numberOfShares;
  int? numberOfComments;
  int? numberOfSaves;
  int? numberOfViews;
  DateTime? createdAt;
  DateTime? updatedAt;
  ProfileUser ? user;
  bool? isFollowed;
  bool? alreadyLiked;
  bool? alreadySaved;
  bool? commentAllowed;

  Vlog({
    this.id,
    this.title,
    this.description,
    this.videoUrl,
    this.thumbnailUrl,
    this.userId,
    this.numberOfLikes,
    this.numberOfShares,
    this.numberOfComments,
    this.numberOfSaves,
    this.numberOfViews,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.isFollowed,
    this.alreadyLiked,
    this.alreadySaved,
    this.commentAllowed,
  });

  factory Vlog.fromJson(Map<String, dynamic> json) => Vlog(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    videoUrl: json["video_url"],
    thumbnailUrl: json["thumbnail_url"],
    userId: json["userId"],
    numberOfLikes: json["numberOfLikes"],
    numberOfShares: json["numberOfShares"],
    numberOfComments: json["numberOfComments"],
    numberOfSaves: json["numberOfSaves"],
    numberOfViews: json["numberOfViews"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    user: json["user"] == null ? null : ProfileUser.fromJson(json["user"]),
    isFollowed: json["isFollowed"],
    alreadyLiked: json["alreadyLiked"],
    alreadySaved: json["alreadySaved"],
    commentAllowed: json["commentAllowed"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "video_url": videoUrl,
    "thumbnail_url": thumbnailUrl,
    "userId": userId,
    "numberOfLikes": numberOfLikes,
    "numberOfShares": numberOfShares,
    "numberOfComments": numberOfComments,
    "numberOfSaves": numberOfSaves,
    "numberOfViews": numberOfViews,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
    "isFollowed": isFollowed,
    "alreadyLiked": alreadyLiked,
    "alreadySaved": alreadySaved,
    "commentAllowed": commentAllowed,
  };
}