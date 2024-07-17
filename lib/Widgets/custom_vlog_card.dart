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
                  // Container(color: Colors.black,
                  //  height: 196.ah,
                  //  width: MediaQuery.of(context).size.width,),
                  CustomImageView(
                    height: 196.ah,
                    width: MediaQuery.of(context).size.width,
                    radius: BorderRadius.circular(15.adaptSize),
                    fit: BoxFit.cover,
                    // color: Colors.black,
                    imagePath: vlog.thumbnailUrl,
                  ),
                  Container(
                    height: 196.ah,
                    width: MediaQuery.of(context).size.width,
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
                  vlogInLocationRow(vlog,context),
                  SizedBox(
                    height: 196.ah,
                    width: MediaQuery.of(context).size.width,
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
                            mainAxisSize: MainAxisSize.min,
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
                              Spacer(),
                              //

                              // Container(
                              //
                              //   height: 30.ah,
                              //   width: MediaQuery.of(context).size.width/4,
                              //   child: Row(
                              //     children: [
                              //       SizedBox(
                              //         width: MediaQuery.of(context).size.width/8,
                              //         child: Text(
                              //             overflow: TextOverflow.ellipsis,
                              //           '${vlog.numberOfViews} ${'views'.tr}  ',
                              //           style: TextStyle(
                              //             color: Color(0xffFFFFFF),
                              //             fontWeight: FontWeight.w600,
                              //             fontSize: 11.fSize,
                              //           ),
                              //         ),
                              //       ),
                              //
                              //       SizedBox(
                              //         width: MediaQuery.of(context).size.width/8,
                              //         child: Text(
                              //           overflow: TextOverflow.ellipsis,
                              //           calculateTimeDifference(vlog.createdAt!.toString()),
                              //           style: TextStyle(
                              //             color: const Color(0xffFFFFFF),
                              //             fontWeight: FontWeight.w600,
                              //             fontSize: 11.fSize,
                              //           ),
                              //         ),
                              //       ),
                              //
                              //
                              //     ],
                              //   ),
                              //
                              // ),


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
  Widget vlogInLocationRow(Vlog vlog,BuildContext context) {
    return SizedBox(
      height: 40.ah,
      width: double.infinity,
      child: Row(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Image.asset(
                  'assets/image/location-outline.png',
                  width: 21.ah,
                  height: 21.ah,
                ),
              ),
              Container(
                // color: Colors.red,
                width: MediaQuery.of(context).size.width/2.5,
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                    text:TextSpan(children: [
                  TextSpan(text: '${vlog.user?.city}, ',style: TextStyle(
                    color: HexColor('#FFFFFF'),
                    fontWeight: FontWeight.w600,
                    fontSize: 11.fSize,
                  )),
                  TextSpan(text: '${vlog.user?.country}',style: TextStyle(
                    color: HexColor('#FFFFFF'),
                    fontWeight: FontWeight.w600,
                    fontSize: 11.fSize,
                  )),
                ]) ),
              ),

            ],
          ),
          const Spacer(),
          // Image.asset(
          //   'assets/image/more op.png',
          //   width: 22.aw,
          // ),
          Container(
            height: 30.ah,
            child: Row(
              children: [
                Text(
                  overflow: TextOverflow.ellipsis,
                  '${vlog.numberOfViews} ${'views'.tr}  ',
                  style: TextStyle(
                    color: Color(0xffFFFFFF),
                    fontWeight: FontWeight.w600,
                    fontSize: 11.fSize,
                  ),
                ),

                Text(
                  overflow: TextOverflow.ellipsis,
                  calculateTimeDifference(vlog.createdAt!.toString()),
                  style: TextStyle(
                    color: const Color(0xffFFFFFF),
                    fontWeight: FontWeight.w600,
                    fontSize: 11.fSize,
                  ),
                ),


              ],
            ),

          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }

}
