// To parse this JSON data, do
//
//     final getVlogModel = getVlogModelFromJson(jsonString);

import 'dart:convert';

import 'package:frenly_app/data/models/vlog_model.dart';


GetVlogModel getVlogModelFromJson(String str) => GetVlogModel.fromJson(json.decode(str));


class GetVlogModel {
    bool? success;
    int? status;
    String? message;
    List<Vlog>? vlogs;

    GetVlogModel({
        this.success,
        this.status,
        this.message,
        this.vlogs,
    });

    factory GetVlogModel.fromJson(Map<String, dynamic> json) => GetVlogModel(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        vlogs: json["vlogs"] == null ? [] : List<Vlog>.from(json["vlogs"]!.map((x) => Vlog.fromJson(x))),
    );


}

