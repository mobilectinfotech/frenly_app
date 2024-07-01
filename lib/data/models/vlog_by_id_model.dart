// To parse this JSON data, do
//
//     final vlogByIdModel = vlogByIdModelFromJson(jsonString);

import 'dart:convert';

import 'package:frenly_app/data/models/vlog_model.dart';

import '../../presentation/all_saved/MySavedBlogs.dart';

VlogByIdModel vlogByIdModelFromJson(String str) => VlogByIdModel.fromJson(json.decode(str));

String vlogByIdModelToJson(VlogByIdModel data) => json.encode(data.toJson());

class VlogByIdModel {
  int? status;
  String? message;
  bool? success;
  Vlog? vlog;

  VlogByIdModel({
    this.status,
    this.message,
    this.success,
    this.vlog,
  });

  factory VlogByIdModel.fromJson(Map<String, dynamic> json) => VlogByIdModel(
    status: json["status"],
    message: json["message"],
    success: json["success"],
    vlog: json["vlog"] == null ? null : Vlog.fromJson(json["vlog"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "success": success,
    "vlog": vlog?.toJson(),
  };
}



