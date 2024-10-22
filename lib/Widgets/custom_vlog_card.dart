import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../core/utils/calculateTimeDifference.dart';
import '../data/models/vlog_model.dart';
import '../presentation/Vlog/vlog_like_commnet_share_common_view.dart';
import '../presentation/vlog_full_view/vlog_full_view.dart';
import 'custom_image_view.dart';

class CustomVlogCard extends StatefulWidget {
  Vlog vlog;

  bool? isRedrectRormVlogPage;

  CustomVlogCard({super.key, required this.vlog, this.isRedrectRormVlogPage});

  @override
  State<CustomVlogCard> createState() => _CustomVlogCardState();
}

class _CustomVlogCardState extends State<CustomVlogCard> {
  Rxn<Uint8List> thumbnail = Rxn<Uint8List>();

  // Function to generate thumbnail
  Future<void> generateThumbnail(String videoUrl) async {
    print("videoUrl ==> $videoUrl");
    try {
      // Generate the thumbnail asynchronously
      Uint8List? data = await VideoThumbnail.thumbnailData(
        video: videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 1280, // Set the max width for the thumbnail
        quality: 75,    // Set quality (0-100)
      );

      if (data != null) {
        // Update the thumbnail Rx with the generated thumbnail data
        thumbnail.value = data;
        print("Thumbnail generated successfully!");
      } else {
        print("Thumbnail generation failed.");
      }
    } catch (e) {
      print('Error generating thumbnail: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Make sure videoUrl is valid
    if (widget.vlog.videoUrl != null) {
      generateThumbnail(widget.vlog.videoUrl ?? "");
    } else {
      print("Invalid video URL");
    }
  }

  // Rxn<Uint8List> thumbnail = Rxn<Uint8List>();
  //
  // Future<String?> generateThumbnail(String videoUrl) async {
  //   print("videoUrl==>$videoUrl");
  //   try {
  //     VideoThumbnail.thumbnailData(
  //       video: "$videoUrl",
  //       imageFormat: ImageFormat.JPEG,
  //       maxWidth: 1280, // Set the max width for the thumbnail
  //       quality: 75,
  //     ).then(
  //           (value) {
  //             print("valueee==>$value");
  //        thumbnail.value = value;
  //       },
  //     );
  //   } catch (e) {
  //     print('Error generating thumbnail: $e');
  //     return null;
  //   }
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   generateThumbnail(widget.vlog.videoUrl ?? "");
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0.ah),
      child: InkWell(
        onTap: () {
          if (widget.isRedrectRormVlogPage == true) {
            Get.back();
          }
          Get.to(() =>
              VlogFullViewNewScreen(
                videoUrl: '${widget.vlog.videoUrl}',
                vlogId: widget.vlog.id.toString(),
              ));
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
                  ClipRRect(
                    borderRadius:  BorderRadius.circular(15.adaptSize),
                    child: Container(
                      child: Obx(() {
                        if(thumbnail.value==null){
                          return Center(child: CircularProgressIndicator());
                        }
                        return Image.memory(thumbnail.value!,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,);
                      }),
                    ),
                  ),
                  // CustomImageView(
                  //   height: 196.ah,
                  //   width: MediaQuery.of(context).size.width,
                  //   radius: BorderRadius.circular(15.adaptSize),
                  //   fit: BoxFit.cover,
                  //   // color: Colors.black,
                  //   imagePath: null,
                  // ),

                  Container(
                    height: 196.ah,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
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
                  vlogInLocationRow(widget.vlog, context),
                  SizedBox(
                    height: 196.ah,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Padding(
                      padding: EdgeInsets.all(10.0.adaptSize),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.vlog.title}'.capitalizeFirst!,
                            style: TextStyle(
                                color: const Color(0xffFFFFFF),
                                fontWeight: FontWeight.w700,
                                fontSize: 16.fSize,
                                height: 1.5),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomImageView(
                                height: 30.ah,
                                width: 30.ah,
                                imagePath: widget.vlog.user?.avatarUrl,
                                radius: BorderRadius.circular(30.ah),
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                width: 80.aw,
                                child: Text(
                                  '${widget.vlog.user?.handle}'
                                      .capitalizeFirst!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: const Color(0xffFFFFFF),
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

                              VlogLikeCommentsShareView(
                                vlog: widget.vlog,
                              ),
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

  Widget vlogInLocationRow(Vlog vlog, BuildContext context) {
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
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2.5,
                child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: [
                      TextSpan(
                          text: "${vlog.user?.city ?? ""}",
                          style: TextStyle(
                            color: HexColor('#FFFFFF'),
                            fontWeight: FontWeight.w600,
                            fontSize: 11.fSize,
                          )),
                      TextSpan(
                          text: '${vlog.user?.country}',
                          style: TextStyle(
                            color: HexColor('#FFFFFF'),
                            fontWeight: FontWeight.w600,
                            fontSize: 11.fSize,
                          )),
                    ])),
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
