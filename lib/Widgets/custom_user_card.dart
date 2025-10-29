import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../core/utils/pref_utils.dart';
import '../data/models/DiscoverUsersModel.dart';
import '../data/repositories/api_repository.dart';
import 'custom_image_view.dart';

class CustomUserCard extends StatefulWidget {
  DiscoverUser users;
   CustomUserCard({super.key,required this.users});

  @override
  State<CustomUserCard> createState() => _CustomUserCardState();
}

class _CustomUserCardState extends State<CustomUserCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 223.ah,
      width: 120.aw,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            //color: HexColor('#FFFFFF'),
              color: Colors.black12,
              width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
            radius: BorderRadius.circular(100.ah),
            height: 100.ah,
            width: 100.ah,
            imagePath: widget.users.avatarUrl,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 4.ah),
          Padding(
            padding: EdgeInsets.only(left:10.aw,right:10.aw),
            child: Center(
              child: Text(
                widget.users.fullName!.capitalizeFirst!,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.fSize,
                ),
              ),
            ),
          ),

          SizedBox(height: 2.ah),
          Padding(
            padding: EdgeInsets.only(left:10.aw,right:10.aw),
            child: Center(
              child: Text(
                widget.users.handle ?? "",
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.fSize),
              ),
            ),
          ),
          SizedBox(height: 2.ah),
          Text(
            '${widget.users.numberOfFollower}',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 12.fSize),
          ),
         SizedBox(height: 10.ah),

          if(PrefUtils().getUserId() != "${widget.users.id}")
          InkWell(
            onTap: () {
              setState(() {
                  if (widget.users.followState == 0) {
                    widget.users.followState = 1;
                    setState(() {});
                    ApiRepository.follow(userId: "${widget.users.id!}");

                  }else{
                    widget.users.followState = 0;
                    setState(() {});
                    ApiRepository.unfollow(userId: "${widget.users.id!}");
                  }

                },
              );
            },
            child: Container(
              height: 24.ah,
              width: 98.aw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                // color: HexColor('#001649'),
                color: (
                    widget.users.followState == 1 ||
                        widget.users.followState == 2)
                    ? Colors.pinkAccent
                    : HexColor('#001649'),
                // color: widget.users.followState == 1
                //     ? Colors.pinkAccent
                //     : HexColor('#001649'),
              ),
              child: Center(
                child: Text(
                  // widget.users.followState == 1 ? widget.users.isPrivate == false ?
                  // "Following".tr : "Requested".tr : widget.users.followState == 0
                  //     ? "Follow".tr  : "Following".tr,
                  widget.users.followState == 0
                      ? "Follow".tr
                      : widget.users.isPrivate == true &&
                      widget.users.followState == 1
                      ? "Requested".tr
                      : "Following".tr,
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w500, fontSize: 14.fSize),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


