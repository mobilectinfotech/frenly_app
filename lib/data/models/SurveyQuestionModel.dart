// To parse this JSON data, do
//
//     final surveyQuestionModel = surveyQuestionModelFromJson(jsonString);

import 'dart:convert';

SurveyQuestionModel surveyQuestionModelFromJson(String str) => SurveyQuestionModel.fromJson(json.decode(str));

String surveyQuestionModelToJson(SurveyQuestionModel data) => json.encode(data.toJson());

class SurveyQuestionModel {
    String? message;
    int? status;
    bool? success;
    List<SurveyQuestion>? surveyQuestion;

    SurveyQuestionModel({
        this.message,
        this.status,
        this.success,
        this.surveyQuestion,
    });

    factory SurveyQuestionModel.fromJson(Map<String, dynamic> json) => SurveyQuestionModel(
        message: json["message"],
        status: json["status"],
        success: json["success"],
        surveyQuestion: json["survey_question"] == null ? [] : List<SurveyQuestion>.from(json["survey_question"]!.map((x) => SurveyQuestion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "success": success,
        "survey_question": surveyQuestion == null ? [] : List<dynamic>.from(surveyQuestion!.map((x) => x.toJson())),
    };
}

class SurveyQuestion {
    int? id;
    String? name;
    String? lastName;
    String? email;
    String? phoneNumber;
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
    String? enviroment;
    String? stress;
    String? sleep;
    String? skinRoutine;
    int? signupType;
    String? profileImage;
    String? actToken;
    String? fcmToken;
    int? verifyUser;
    DateTime? createdAt;
    DateTime? updateAt;

    SurveyQuestion({
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
        this.enviroment,
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
    });

    factory SurveyQuestion.fromJson(Map<String, dynamic> json) => SurveyQuestion(
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
        enviroment: json["enviroment"],
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
        "enviroment": enviroment,
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
    };
}
