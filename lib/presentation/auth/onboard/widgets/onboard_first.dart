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
              imagePath: "assets/image/splash.png",
              height: 45.ah,
              width: 45.ah,
            ),

            // Image.asset('assets/image/image 1.png',height:48.ah,width: 48.aw,),
           //  CustomImageView(
           //    height:52.ah,
           //    width: 52.aw,
           //    imagePath: "assets/image/frenly_logo.png",
           //
           //    // child: Center(child: Text(firestore.currentUser!.displayName!.toUpperCase().characters.first.toString(), style: TextStyle(fontSize: 20.fSize,fontWeight: FontWeight.w400),)),
           //  ),
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
