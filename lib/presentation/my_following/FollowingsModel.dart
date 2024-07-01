import 'dart:convert';

import 'package:frenly_app/data/models/DiscoverUsersModel.dart';

class FollowingsModel {
    bool? success;
    int? status;
    List<DiscoverUser>? followings;
    int? total;

    FollowingsModel({
        this.success,
        this.status,
        this.followings,
        this.total,
    });

    factory FollowingsModel.fromRawJson(String str) => FollowingsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FollowingsModel.fromJson(Map<String, dynamic> json) => FollowingsModel(
        success: json["success"],
        status: json["status"],
        followings: json["followings"] == null ? [] : List<DiscoverUser>.from(json["followings"]!.map((x) => DiscoverUser.fromJson(x))),
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "followings": followings == null ? [] : List<dynamic>.from(followings!.map((x) => x.toJson())),
        "total": total,
    };
}


