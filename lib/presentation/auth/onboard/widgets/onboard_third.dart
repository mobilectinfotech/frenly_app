
import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:get/get.dart';

class OnBoardThirdd extends StatelessWidget {
  const OnBoardThirdd({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:  MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/image/frefil.png",
          height: 271.ah,
          width: 248.aw,
        ),

        SizedBox(height: 35.ah,),
        "Hangout".tr
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

class OnBoardThird extends StatelessWidget {
  const OnBoardThird({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/image/amico.png",
          height: 279.ah,
          width: 262.aw,
          fit:BoxFit.fill ,
        ),

        SizedBox(height: 35.ah,),
        "Meet".tr
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
