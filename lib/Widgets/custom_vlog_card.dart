import 'package:flutter/material.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../core/utils/calculateTimeDifference.dart';
import '../data/models/vlog_model.dart';
import '../presentation/Vlog/vlog_like_commnet_share_common_view.dart';
import '../presentation/vlog_full_view/vlog_full_view.dart';
import 'custom_image_view.dart';

class CustomVlogCard extends StatelessWidget {
  Vlog vlog ;
  bool ?  isRedrectRormVlogPage ;
  CustomVlogCard({super.key,required this.vlog,this.isRedrectRormVlogPage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 30.0.ah),
      child: InkWell(
        onTap: () {
          if(isRedrectRormVlogPage==true) {
            Get.back();
          }
          Get.to(()=>VlogFullViewNewScreen(videoUrl: '${vlog.videoUrl}', vlogId:vlog.id.toString(),));
          },

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 196.ah,
              width: double.infinity,
              child: Stack(
                children: [
                  CustomImageView(
                    height: 196.ah,
                    width: double.infinity,
                    radius: BorderRadius.circular(15.adaptSize),
                    fit: BoxFit.cover,
                    // color: Colors.black,
                    imagePath: vlog.thumbnailUrl,
                  ),
                  Container(
                    height: 196.ah,
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        end: const Alignment(-0.45, 0.87),
                        begin: const Alignment(0.45, -0.87),
                        colors: [
                          Colors.black.withOpacity(.10),
                          Colors.black.withOpacity(.55),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.adaptSize),
                      ),
                    ),
                  ),
                   vlogInLocationRow(vlog),
                  SizedBox(
                    height: 196.ah,
                    width: double.infinity,
                    child: Padding(
                      padding:  EdgeInsets.all(10.0.adaptSize),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${vlog.title}'.capitalizeFirst!,
                            style: TextStyle(
                                color: const Color(0xffFFFFFF),
                                fontWeight: FontWeight.w700,
                                fontSize: 16.fSize,
                                height: 1.5),
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            children: [
                              CustomImageView(
                                height: 30.ah,
                                width: 30.ah,
                                imagePath: vlog.user?.avatarUrl,
                                radius: BorderRadius.circular(30.ah),
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 5,),
                              SizedBox(
                                width: 80.aw,
                                child: Text(
                                  '${vlog.user?.handle}'.capitalizeFirst!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color:const  Color(0xffFFFFFF),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11.fSize,
                                  ),
                                ),
                              ),
                              Text(
                                '${vlog.numberOfViews} views  ',
                                style: TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.fSize,
                                ),
                              ),
                              Text(calculateTimeDifference(vlog.createdAt!.toString()),
                                style: TextStyle(
                                  color: const Color(0xffFFFFFF),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 11.fSize,
                                ),
                              ),
                              const Spacer(),
                              VlogLikeCommentsShareView(vlog: vlog,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget vlogInLocationRow(Vlog vlog) {
    return SizedBox(
      height: 40.ah,
      width: double.infinity,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Image.asset(
              'assets/image/location-outline.png',
              width: 21.ah,
              height: 21.ah,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              '${vlog.user?.city}, ',
              style: TextStyle(
                color: HexColor('#FFFFFF'),
                fontWeight: FontWeight.w600,
                fontSize: 11.fSize,
              ),
            ),
          ),
          Text(
            '${vlog.user?.country}',
            style: TextStyle(
              color: HexColor('#FFFFFF'),
              fontWeight: FontWeight.w600,
              fontSize: 11.fSize,
            ),
          ),
          const Spacer(),
          // Image.asset(
          //   'assets/image/more op.png',
          //   width: 22.aw,
          // ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }

}
