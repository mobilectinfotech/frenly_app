// To parse this JSON data, do
//
//     final loginWithBankIdCheckModel = loginWithBankIdCheckModelFromJson(jsonString);

import 'dart:convert';

LoginWithBankIdCheckModel loginWithBankIdCheckModelFromJson(String str) => LoginWithBankIdCheckModel.fromJson(json.decode(str));

String loginWithBankIdCheckModelToJson(LoginWithBankIdCheckModel data) => json.encode(data.toJson());

class LoginWithBankIdCheckModel {
  int status;
  bool success;
  String message;

  LoginWithBankIdCheckModel({
    required this.status,
    required this.success,
    required this.message,
  });

  factory LoginWithBankIdCheckModel.fromJson(Map<String, dynamic> json) => LoginWithBankIdCheckModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
  };
}
