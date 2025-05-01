import 'dart:convert';

class BankIdToggleModel {
  bool success;
  int status;
  String message;
  Admin admin;

  BankIdToggleModel({
    this.success = false,
    this.status = 0,
    this.message = '',
    Admin? admin,
  }) : admin = admin ?? Admin();

  factory BankIdToggleModel.fromRawJson(String str) =>
      BankIdToggleModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BankIdToggleModel.fromJson(Map<String, dynamic> json) =>
      BankIdToggleModel(
        success: json["success"] ?? false,
        status: json["status"] ?? 0,
        message: json["message"] ?? '',
        admin: Admin.fromJson(json["admin"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status": status,
    "message": message,
    "admin": admin.toJson(),
  };
}

class Admin {
  int bankIdToggle;

  Admin({this.bankIdToggle = 0});

  factory Admin.fromRawJson(String str) => Admin.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    bankIdToggle: json["bankIdToggle"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "bankIdToggle": bankIdToggle,
  };
}
