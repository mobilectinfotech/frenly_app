
import 'package:flutter/material.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

class OnBoardSecond extends StatelessWidget {
  const OnBoardSecond({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          "assets/image/rafiki.png",
          height: 261.ah,
          width: 315.aw,
        ),
        SizedBox(height: 30.ah,),
        "Find".tr
            .text
            .size(18.adaptSize)
            .align(TextAlign.center)
            .fontWeight(FontWeight.w700)
            .make(),
          SizedBox(height: 30.ah),
        "Loream".tr
            .text
            .size(16.adaptSize)
            .align(TextAlign.center)
            .fontWeight(FontWeight.w400)
            .make(),


      ],
    );
  }
}
