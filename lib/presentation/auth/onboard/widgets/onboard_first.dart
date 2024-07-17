import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/core/utils/size_utils.dart';


class OnBoardFirst extends StatelessWidget {
  const OnBoardFirst({super.key,});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          "assets/image/cuate.png",
          height: 285.ah,
          width: 285.ah,
        ),

        SizedBox(height: 100.ah,),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomImageView(
              imagePath: "assets/icons/app_icon.png",
              height: 45.ah,
              width: 45.ah,
            ),

            SizedBox(width: 10.aw),
            Text('Frenly',
              style: TextStyle(fontFamily: 'Roboto',
                  color: Color(0xff001649),fontWeight: FontWeight.w700,fontSize:35.fSize
              ),
            ),
          ],
        ),

      ],
    );
  }
}
