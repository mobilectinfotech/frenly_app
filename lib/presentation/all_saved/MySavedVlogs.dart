// To parse this JSON data, do
//
//     final mySavedVlogs = mySavedVlogsFromJson(jsonString);

import 'dart:convert';

import '../../data/models/vlog_model.dart';

MySavedVlogs mySavedVlogsFromJson(String str) => MySavedVlogs.fromJson(json.decode(str));


class MySavedVlogs {
    int? status;
    String? message;
    bool? success;
    List<MySavedVlog>? mySavedVlogs;

    MySavedVlogs({
        this.status,
        this.message,
        this.success,
        this.mySavedVlogs,
    });

    factory MySavedVlogs.fromJson(Map<String, dynamic> json) => MySavedVlogs(
        status: json["status"],
        message: json["message"],
        success: json["success"],
        mySavedVlogs: json["mySavedVlogs"] == null ? [] : List<MySavedVlog>.from(json["mySavedVlogs"]!.map((x) => MySavedVlog.fromJson(x))),
    );


}

class MySavedVlog {
    int? id;
    int? vlogId;
    int? saveByUserId;
    dynamic categoryId;
    DateTime? createdAt;
    DateTime? updatedAt;
    Vlog? vlog;

    MySavedVlog({
        this.id,
        this.vlogId,
        this.saveByUserId,
        this.categoryId,
        this.createdAt,
        this.updatedAt,
        this.vlog,
    });

    factory MySavedVlog.fromJson(Map<String, dynamic> json) => MySavedVlog(
        id: json["id"],
        vlogId: json["vlogId"],
        saveByUserId: json["saveByUserId"],
        categoryId: json["categoryId"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        vlog: json["vlog"] == null ? null : Vlog.fromJson(json["vlog"]),
    );


}


