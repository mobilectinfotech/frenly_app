import 'dart:convert';

import '../../data/models/DiscoverUsersModel.dart';

class UserFollowingModel {
    bool? success;
    int? status;
    List<DiscoverUser>? followings;
    int? total;

    UserFollowingModel({
        this.success,
        this.status,
        this.followings,
        this.total,
    });

    factory UserFollowingModel.fromRawJson(String str) => UserFollowingModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserFollowingModel.fromJson(Map<String, dynamic> json) => UserFollowingModel(
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

