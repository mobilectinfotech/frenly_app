import 'dart:convert';
import '../../data/models/vlog_model.dart';

VlogsListModel trendingVlogModelFromJson(String str) => VlogsListModel.fromJson(json.decode(str));


class VlogsListModel {
    bool? success;
    int? status;
    String? message;
    List<Vlog>? vlogs;

    VlogsListModel({
        this.success,
        this.status,
        this.message,
        this.vlogs,
    });

    factory VlogsListModel.fromJson(Map<String, dynamic> json) => VlogsListModel(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        vlogs: json["vlogs"] == null ? [] : List<Vlog>.from(json["vlogs"]!.map((x) => Vlog.fromJson(x))),
    );


}


