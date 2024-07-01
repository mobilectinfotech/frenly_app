// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
    bool? success;
    String? message;
    int? status;

    SignUpModel({
        this.success,
        this.message,
        this.status,
    });

    factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        success: json["success"],
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
    };
}
