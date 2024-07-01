// To parse this JSON data, do
//
//     final getVlogModel = getVlogModelFromJson(jsonString);

import 'dart:convert';

import 'package:frenly_app/data/models/vlog_model.dart';


GetVlogModel getVlogModelFromJson(String str) => GetVlogModel.fromJson(json.decode(str));

String getVlogModelToJson(GetVlogModel data) => json.encode(data.toJson());

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

    Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "vlogs": vlogs == null ? [] : List<dynamic>.from(vlogs!.map((x) => x.toJson())),
    };
}

