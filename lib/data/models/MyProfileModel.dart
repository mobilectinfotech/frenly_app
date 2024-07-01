// To parse this JSON data, do
//
//     final myProfileModel = myProfileModelFromJson(jsonString);

import 'dart:convert';

MyProfileModel myProfileModelFromJson(String str) => MyProfileModel.fromJson(json.decode(str));

String myProfileModelToJson(MyProfileModel data) => json.encode(data.toJson());

class MyProfileModel {
    int? status;
    bool? success;
    String? message;
    UserInfo? userInfo;

    MyProfileModel({
        this.status,
        this.success,
        this.message,
        this.userInfo,
    });

    factory MyProfileModel.fromJson(Map<String, dynamic> json) => MyProfileModel(
        status: json["status"],
        success: json["success"],
        message: json["message"],
        userInfo: json["user_info"] == null ? null : UserInfo.fromJson(json["user_info"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "message": message,
        "user_info": userInfo?.toJson(),
    };
}

class UserInfo {
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
    int? followers;
    int? followings;

    UserInfo({
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
        this.followers,
        this.followings,
    });

    factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
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
        followers: json["followers"],
        followings: json["followings"],
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
        "followers": followers,
        "followings": followings,
    };
}
