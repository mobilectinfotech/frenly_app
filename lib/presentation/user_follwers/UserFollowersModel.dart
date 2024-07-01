import 'dart:convert';

import '../../data/models/DiscoverUsersModel.dart';

class UserFollowersModel {
    bool? success;
    int? status;
    List<DiscoverUser>? followers;
    int? total;

    UserFollowersModel({
        this.success,
        this.status,
        this.followers,
        this.total,
    });

    factory UserFollowersModel.fromRawJson(String str) => UserFollowersModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserFollowersModel.fromJson(Map<String, dynamic> json) => UserFollowersModel(
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

