
import '../../presentation/all_saved/MySavedBlogs.dart';

class Blog {
  int? id;
  String? body;
  String? title;
  String? tags;
  dynamic city;
  String? imageUrl;
  dynamic country;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? numberOfLikes;
  int? numberOfShares;
  int? numberOfComments;
  int? numberOfSaves;
  User? user;
  bool? alreadyLiked;
  bool? alreadySaved;
  bool? commentAllowed;

  Blog({
    this.id,
    this.body,
    this.title,
    this.tags,
    this.city,
    this.imageUrl,
    this.country,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.numberOfLikes,
    this.numberOfShares,
    this.numberOfComments,
    this.numberOfSaves,
    this.user,
    this.alreadyLiked,
    this.alreadySaved,
    this.commentAllowed,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
    id: json["id"],
    body: json["body"],
    title: json["title"],
    tags: json["tags"],
    city: json["city"],
    imageUrl: json["image_url"],
    country: json["country"],
    userId: json["userId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    numberOfLikes: json["numberOfLikes"],
    numberOfShares: json["numberOfShares"],
    numberOfComments: json["numberOfComments"],
    numberOfSaves: json["numberOfSaves"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    alreadyLiked: json["alreadyLiked"],
    alreadySaved: json["alreadySaved"],
    commentAllowed: json["commentAllowed"],
  );


}