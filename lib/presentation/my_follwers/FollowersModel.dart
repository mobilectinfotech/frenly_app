import 'dart:convert';

import '../../data/models/DiscoverUsersModel.dart';

class FollowersModel {
    bool? success;
    int? status;
    List<DiscoverUser>? followers;
    int? total;

    FollowersModel({
        this.success,
        this.status,
        this.followers,
        this.total,
    });

    factory FollowersModel.fromRawJson(String str) => FollowersModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FollowersModel.fromJson(Map<String, dynamic> json) => FollowersModel(
        success: json["success"],
        status: json["status"],
        followers: json["followers"] == null ? [] : List<DiscoverUser>.from(json["followers"]!.map((x) => DiscoverUser.fromJson(x))),
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "followers": followers == null ? [] : List<dynamic>.from(followers!.map((x) => x.toJson())),
        "total": total,
    };
}

