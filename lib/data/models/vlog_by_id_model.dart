// To parse this JSON data, do
//
//     final vlogByIdModel = vlogByIdModelFromJson(jsonString);

import 'dart:convert';

import 'package:frenly_app/data/models/vlog_model.dart';


VlogByIdModel vlogByIdModelFromJson(String str) => VlogByIdModel.fromJson(json.decode(str));


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


}



