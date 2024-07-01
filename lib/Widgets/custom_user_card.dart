import 'package:flutter/material.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
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
            imagePath: widget.users.coverPhotoUrl,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 4.ah),
          Text(
            widget.users.fullName!.capitalizeFirst!,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 13.fSize),
          ),
          SizedBox(height: 2.ah),
          Text(
            widget.users.handle ?? "",
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 12.fSize),
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
          InkWell(
            onTap: () {
              setState(
                    () {
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
                color: widget.users.followState ==1!
                    ? Colors.red
                    : HexColor('#001649'),
              ),
              child: Center(
                child: Text(
                  widget.users.followState == 1  ? "Requested".tr : widget.users.followState == 0  ? "Follow".tr  : "Following",

                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.fSize),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
