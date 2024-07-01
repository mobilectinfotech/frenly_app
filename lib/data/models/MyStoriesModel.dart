// To parse this JSON data, do
//
//     final myStoriesModel = myStoriesModelFromJson(jsonString);

import 'dart:convert';

MyStoriesModel myStoriesModelFromJson(String str) => MyStoriesModel.fromJson(json.decode(str));

String myStoriesModelToJson(MyStoriesModel data) => json.encode(data.toJson());

class MyStoriesModel {
    String? message;
    int? status;
    bool? success;
    User? user;
    List<Story>? stories;

    MyStoriesModel({
        this.message,
        this.status,
        this.success,
        this.user,
        this.stories,
    });

    factory MyStoriesModel.fromJson(Map<String, dynamic> json) => MyStoriesModel(
        message: json["message"],
        status: json["status"],
        success: json["success"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        stories: json["stories"] == null ? [] : List<Story>.from(json["stories"]!.map((x) => Story.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "success": success,
        "user": user?.toJson(),
        "stories": stories == null ? [] : List<dynamic>.from(stories!.map((x) => x.toJson())),
    };
}

class Story {
    int? id;
    String? content;
    int? userId;
    String? storyImage;
    DateTime? createdAt;

    Story({
        this.id,
        this.content,
        this.userId,
        this.storyImage,
        this.createdAt,
    });

    factory Story.fromJson(Map<String, dynamic> json) => Story(
        id: json["id"],
        content: json["content"],
        userId: json["user_id"],
        storyImage: json["story_image"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "user_id": userId,
        "story_image": storyImage,
        "created_at": createdAt?.toIso8601String(),
    };
}

class User {
    int? id;
    String? name;
    String? lastName;
    String? email;
    dynamic phoneNumber;
    String? token;
    int? age;
    String? gender;
    String? password;
    String? showPassword;
    String? skinType;
    String? concerns;
    String? skinTone;
    String? breakouts;
    String? sideEffects;
    String? environment;
    String? stress;
    String? sleep;
    dynamic skinRoutine;
    int? signupType;
    dynamic profileImage;
    String? actToken;
    String? fcmToken;
    int? verifyUser;
    DateTime? createdAt;
    DateTime? updateAt;
    int? pageNo;

    User({
        this.id,
        this.name,
        this.lastName,
        this.email,
        this.phoneNumber,
        this.token,
        this.age,
        this.gender,
        this.password,
        this.showPassword,
        this.skinType,
        this.concerns,
        this.skinTone,
        this.breakouts,
        this.sideEffects,
        this.environment,
        this.stress,
        this.sleep,
        this.skinRoutine,
        this.signupType,
        this.profileImage,
        this.actToken,
        this.fcmToken,
        this.verifyUser,
        this.createdAt,
        this.updateAt,
        this.pageNo,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        token: json["token"],
        age: json["age"],
        gender: json["gender"],
        password: json["password"],
        showPassword: json["show_password"],
        skinType: json["skin_type"],
        concerns: json["concerns"],
        skinTone: json["skin_tone"],
        breakouts: json["breakouts"],
        sideEffects: json["side_effects"],
        environment: json["environment"],
        stress: json["stress"],
        sleep: json["sleep"],
        skinRoutine: json["skin_routine"],
        signupType: json["signup_type"],
        profileImage: json["profile_image"],
        actToken: json["act_token"],
        fcmToken: json["fcm_token"],
        verifyUser: json["verify_user"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updateAt: json["update_at"] == null ? null : DateTime.parse(json["update_at"]),
        pageNo: json["page_no"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "token": token,
        "age": age,
        "gender": gender,
        "password": password,
        "show_password": showPassword,
        "skin_type": skinType,
        "concerns": concerns,
        "skin_tone": skinTone,
        "breakouts": breakouts,
        "side_effects": sideEffects,
        "environment": environment,
        "stress": stress,
        "sleep": sleep,
        "skin_routine": skinRoutine,
        "signup_type": signupType,
        "profile_image": profileImage,
        "act_token": actToken,
        "fcm_token": fcmToken,
        "verify_user": verifyUser,
        "created_at": createdAt?.toIso8601String(),
        "update_at": updateAt?.toIso8601String(),
        "page_no": pageNo,
    };
}
