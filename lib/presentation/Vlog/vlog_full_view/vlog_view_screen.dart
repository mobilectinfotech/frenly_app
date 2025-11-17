import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/services.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/Vlog/vlog_full_view/vlog_view_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../../../Widgets/VideoPlayerWidget.dart';
import '../../../Widgets/VideoPlayerWidget.dart';
import '../../../Widgets/bottom_sheet_widgets.dart';
import '../../../Widgets/custom_image_view.dart';
import '../../../Widgets/custom_textfield.dart';
import '../../../Widgets/custom_user_card.dart';
import '../../../Widgets/custom_vlog_card.dart';
import '../../../core/constants/my_colour.dart';
import '../../../core/constants/textfield_validation.dart';
import '../../../core/utils/calculateTimeDifference.dart';
import '../../../core/utils/pref_utils.dart';
import '../../../data/models/cateogry_model.dart';
import '../../../data/models/vlog_model.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import '../../Vlog/add_new_category/add_new_cateogry_bottom_sheet.dart';
import '../../Vlog/edit_vlog/edit_vlog.dart';
import '../../Vlog/vlog_like_commnet_share_common_view.dart';
import '../../auth/my_profile_view/my_profile_controller.dart';
import '../../auth/my_profile_view/my_profile_screen.dart';
import '../../chat/Pages/all_frined/CreateChatModel.dart';
import '../../dashboard_screen/dashboardcontroller.dart';
import '../../user_profile_screen/user_profile_screen.dart';

// class VlogFullViewNewScreen1 extends StatefulWidget {
//   String videoUrl;
//   String vlogId;
//
//   VlogFullViewNewScreen1(
//       {super.key, required this.videoUrl, required this.vlogId});
//
//   @override
//   State<VlogFullViewNewScreen1> createState() => _VlogFullViewNewScreen1State();
// }
//
// class _VlogFullViewNewScreen1State extends State<VlogFullViewNewScreen1> {
//   bool _isFullScreen = false;
//
//   void _toggleFullScreen() {
//     setState(() {
//       if (_isFullScreen) {
//         //  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
//       } else {
//         //  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
//       }
//       _isFullScreen = !_isFullScreen;
//     });
//   }
//
//   Rxn<VideoPlayerController> _video_play_controller = Rxn(null);
//   VlogFullViewController controller = Get.put(VlogFullViewController(), permanent: true);
//
//
//
//
//
//
//   TextEditingController reasonController = TextEditingController();
//
//   void reportFun(
//       BuildContext context,
//       PostType postType,
//       ) async {
//     await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//               title: Text(
//                 'vlog_report_reason'.tr,
//                 style: TextStyle(
//                   color: const Color(0XFF111111),
//                   fontWeight: FontWeight.w600,
//                   fontSize: 18.adaptSize,
//                   fontFamily: 'Roboto',
//                 ),
//               ),
//               actions: <Widget>[
//                 SizedBox(
//                   width: 300,
//                   child: CustomTextFormField(
//                     context: context,
//                     maxLines: 4,
//                     controller: reasonController,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Center(
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Get.back();
//                         },
//                         child: Container(
//                           height: 44.adaptSize,
//                           width: 110.adaptSize,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(
//                                   color: const Color(0xff001649), width: 1.aw)),
//                           child: Center(
//                             child: Text(
//                               'cancel'.tr,
//                               style: TextStyle(
//                                 color: const Color(0XFF001649),
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 15.adaptSize,
//                                 fontFamily: 'Roboto',
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 30.aw),
//                       InkWell(
//                         onTap: () async {
//                           if(reasonController.text.trim().isEmpty || reasonController.text == "" ){
//                             Get.snackbar("", "please_enter_report_reason".tr, backgroundColor: Color(0xff001649),colorText: Colors.white);
//
//                           }else{
//                             print("vlogid==>${widget.vlogId}");
//                             bool isreport =  await ApiRepository.reportPostVlogBlog(id: widget.vlogId, reason: reasonController.text,postType: postType);
//                             if(isreport){
//                               reasonController.clear();
//                               Get.back();
//                             }
//                           }
//                         },
//                         child: Container(
//                           height: 44.adaptSize,
//                           width: 110.adaptSize,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: const Color(0xff001649),
//                           ),
//                           child: Center(
//                             child: Text(
//                               'Report'.tr,
//                               style: TextStyle(
//                                 color: const Color(0XFFFFFFFF),
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 15.adaptSize,
//                                 fontFamily: 'Roboto',
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ]);
//         });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 2)).then(
//       (value) {
//         controller.getVlogById(vlogId: widget.vlogId);
//         _video_play_controller.value =
//             VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
//               ..initialize().then((_) {
//                 _video_play_controller.value?.play();
//                 setState(() {});
//               });
//       },
//     );
//   }
//
//   void _showBottomSheet(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height * .55,
//             child: Padding(
//               padding: EdgeInsets.only(left: 20.0.ah, right: 20.ah),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const SizedBox(
//                       width: double.infinity,
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Center(
//                         child: Text(
//                       "description".tr,
//                       style: const TextStyle(
//                           fontWeight: FontWeight.w600, fontSize: 25),
//                     )),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       "${controller.vlogByIdModel?.value?.vlog?.description}",
//                       style: TextStyle(fontSize: 18.adaptSize),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                   ]),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   void _showBottomSheetOwnVlog(BuildContext context, String vlogId) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
//           child: Container(
//             child: Padding(
//               padding: EdgeInsets.only(left: 20.0.ah, right: 20.ah),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     InkWell(
//                       onTap: () async {
//                         await ApiRepository.deleteVlog(postId: "${vlogId}");
//                         if (Get.isRegistered<MyProfileController>()) {
//                           Get.find<MyProfileController>().getProfile();
//                         }
//                         Get.back();
//                         Get.back();
//                       },
//                       child: Row(
//                         children: [
//                           CustomImageView(
//                             height: 38,
//                             width: 38,
//                             imagePath: "assets/image/delete.png",
//                           ),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           SizedBox(
//                             child: Text("delete_this_vlog".tr),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     InkWell(
//                       onTap: () async {
//                         Get.back();
//                         Get.to(() => EditVlogScreen(
//                               vlogByIdModel: controller.vlogByIdModel.value!,
//                             ));
//                       },
//                       child: Row(
//                         children: [
//                           CustomImageView(
//                             height: 38,
//                             width: 38,
//                             imagePath: "assets/image/edit_with_container.png",
//                           ),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           SizedBox(
//                             child: Text("edit_this_vlog".tr),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 50,
//                     ),
//                   ]),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);
//     _video_play_controller.value?.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _toggleFullScreen();
//     return OrientationBuilder(
//       builder: (context, orientation) {
//         if (orientation == Orientation.portrait) {
//           _isFullScreen = true;
//           return Scaffold(
//             appBar: appBarPrimary(),
//             body: Padding(
//               padding: EdgeInsets.only(
//                 left: 18.0.aw,
//                 right: 18.0.aw,
//               ),
//               child: Obx(() {
//                 if (_video_play_controller.value == null) {
//                   return const Center(
//                       child:
//                           CircularProgressIndicator(color: Color(0xff001649)));
//                 }
//                 return ListView(
//                   children: [
//                     Stack(
//                       children: [
//                         Column(
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 setState(() {
//                                   _video_play_controller.value!.value.isPlaying
//                                       ? _video_play_controller.value?.pause()
//                                       : _video_play_controller.value?.play();
//                                 });
//                               },
//                               child: Center(
//                                   child: _video_play_controller
//                                           .value!.value.isInitialized
//                                       ? SizedBox(
//                                           width: MediaQuery.of(context).size.width,
//                                           height: 200,
//                                           child: ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             child: VideoPlayer(
//                                                 _video_play_controller.value!),
//                                           ),
//                                         )
//                                       : SizedBox(
//                                           width:
//                                               MediaQuery.of(context).size.width,
//                                           height: 200,
//                                           child: LinearProgressIndicator(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             color: Colors.grey.shade200,
//                                             backgroundColor:
//                                                 Colors.grey.shade100,
//                                           ),
//                                         )),
//                             ),
//                             // VideoProgressIndicator(
//                             //     _controller,
//                             //     allowScrubbing: true),
//                           ],
//                         ),
//                         Positioned(
//                             right: 20,
//                             bottom: 20,
//                             child: InkWell(
//                               onTap: () {
//                                 SystemChrome.setPreferredOrientations([
//                                   DeviceOrientation.landscapeLeft,
//                                   DeviceOrientation.landscapeRight
//                                 ]);
//                               },
//                               child: const SizedBox(
//                                 height: 30,
//                                 width: 30,
//                                 child: Icon(
//                                   Icons.fullscreen,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ))
//                       ],
//                     ),
//                     SizedBox(height: 15.ah),
//                     Obx(
//                       () => controller.isLoadingVlogById.value
//                           ? Container(
//                               height: 130.ah,
//                               child: LinearProgressIndicator(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.grey.shade200,
//                                 backgroundColor: Colors.grey.shade100,
//                               ))
//                           : Container(
//                               height: 130.ah,
//                               child: Column(
//                                 children: [
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       CustomImageView(
//                                         height: 50.ah,
//                                         width: 50.ah,
//                                         fit: BoxFit.cover,
//                                         onTap: () {
//                                           Get.to(() => UserProfileScreen(
//                                                 userId:
//                                                     '${controller.vlogByIdModel.value?.vlog?.user?.id}',
//                                               ));
//                                         },
//                                         radius: BorderRadius.circular(50),
//                                         imagePath: controller.vlogByIdModel.value?.vlog
//                                             ?.user?.avatarUrl,
//                                       ),
//                                       SizedBox(
//                                         width: 10.aw,
//                                       ),
//                                       Column(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             '${controller.vlogByIdModel.value?.vlog?.title}'
//                                                 .capitalizeFirst!,
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w700,
//                                                 fontSize: 16.adaptSize,
//                                                 height: 1.5),
//                                           ),
//
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 '${controller.vlogByIdModel.value?.vlog?.user?.fullName} :  '
//                                                     .capitalizeFirst!,
//                                                 style: TextStyle(
//                                                   color: Colors.black
//                                                       .withOpacity(.50),
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize: 11.fSize,
//                                                 ),
//                                               ),
//                                               Text(
//                                                 '${controller.vlogByIdModel.value?.vlog?.numberOfViews} ${"views".tr} :  ',
//                                                 style: TextStyle(
//                                                   color: Colors.black
//                                                       .withOpacity(.50),
//                                                   fontWeight: FontWeight.w600,
//                                                   fontSize: 11.fSize,
//                                                 ),
//                                               ),
//                                               Builder(builder: (context) {
//                                                 DateTime currentDate =
//                                                     DateTime.now();
//
//                                                 return Text(
//                                                   calculateTimeDifference(
//                                                       controller.vlogByIdModel.value!
//                                                               .vlog?.createdAt
//                                                               .toString() ??
//                                                           "${currentDate}"),
//                                                   style: TextStyle(
//                                                     color: Colors.black
//                                                         .withOpacity(.50),
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: 11.fSize,
//                                                   ),
//                                                 );
//                                               }),
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                       const Spacer(),
//
//                                       Column(
//                                         children: [
//                                           PrefUtils().getUserId() == "${controller.vlogByIdModel?.value?.vlog?.user?.id}" ?SizedBox() :  InkWell(
//                                             onTap: () {
//                                             reportFun(context,PostType.vlog);
//                                             },
//                                             child: const Padding(
//                                               padding: EdgeInsets.only(bottom: 4.0),
//                                               child: Icon(Icons.more_vert_outlined),
//                                             ),
//                                           ),
//                                           PrefUtils().getUserId() == "${controller.vlogByIdModel?.value?.vlog?.user?.id}"
//                                               ? InkWell(
//                                                   onTap: () {
//                                                     _showBottomSheetOwnVlog(context,
//                                                         "${controller.vlogByIdModel?.value?.vlog?.id}");
//                                                   },
//                                                   child: CustomImageView(
//                                                     imagePath:
//                                                         "assets/image/ic_info_outline_24px.png",
//                                                     height: 25,
//                                                   ))
//                                               : InkWell(
//                                                   onTap: () {
//                                                     _showBottomSheet(context);
//                                                   },
//                                                   child: CustomImageView(
//                                                     imagePath:
//                                                         "assets/image/ic_info_outline_24px.png",
//                                                     height: 25,
//                                                   )),
//                                         ],
//                                       ),
//                                       const SizedBox(
//                                         width: 20,
//                                       )
//                                     ],
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 2.0.aw, right: 2.aw),
//                                     child: SizedBox(
//                                       height: 34.ah,
//                                       child: Row(
//                                         children: [
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           Text(
//                                             '${controller.vlogByIdModel?.value?.vlog?.user?.numberOfFollower}',
//                                             style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 18.adaptSize,
//                                               fontFamily: 'Roboto',
//                                               fontWeight: FontWeight.w700,
//                                               letterSpacing: -0.41,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 10.aw,
//                                           ),
//                                           Opacity(
//                                             opacity: 0.50,
//                                             child: Text(
//                                               'Followers'.tr,
//                                               style: const TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 16,
//                                                 fontFamily: 'Roboto',
//                                                 fontWeight: FontWeight.w600,
//                                                 letterSpacing: -0.41,
//                                               ),
//                                             ),
//                                           ),
//                                           const Spacer(),
//                                           VlogLikeCommentsShareView(
//                                             vlog:
//                                                 controller.vlogByIdModel?.value?.vlog ??
//                                                     Vlog(),
//                                             colors: true,
//                                           ),
//                                           const Spacer(),
//                                           // Text("data${ PrefUtils().getUserId()}"),
//                                           // Text("data${controller.vlogByIdModel?.value?.vlog!.user?.id}"),
//                                           PrefUtils().getUserId() ==
//                                                   "${controller.vlogByIdModel?.value?.vlog?.user?.id}"
//                                               ? const SizedBox()
//                                               : InkWell(
//                                                   onTap: () async {
//                                                     if (controller.vlogByIdModel?.value?.vlog!.isFollowed ==
//                                                         false) {
//                                                       await ApiRepository.follow(
//                                                           userId:
//                                                               "${controller.vlogByIdModel?.value?.vlog?.user?.id}");
//                                                       setState(() {
//                                                         controller
//                                                             .vlogByIdModel.value!
//                                                             .vlog!
//                                                             .isFollowed = true;
//                                                       });
//                                                     } else {
//                                                       await ApiRepository.unfollow(
//                                                           userId:
//                                                               "${controller.vlogByIdModel?.value?.vlog!.user?.id}");
//                                                       setState(() {
//                                                         controller
//                                                             .vlogByIdModel.value!
//                                                             .vlog!
//                                                             .isFollowed = false;
//                                                       });
//                                                     }
//                                                   },
//                                                   child: Container(
//                                                     width: 98.aw,
//                                                     height: 34.ah,
//                                                     decoration: ShapeDecoration(
//                                                       color: const Color(
//                                                           0xFF001649),
//                                                       shape:
//                                                           RoundedRectangleBorder(
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           4)),
//                                                     ),
//                                                     child: Center(
//                                                       child: Text(
//                                                         controller
//                                                                     .vlogByIdModel.value!
//                                                                     .vlog
//                                                                     ?.isFollowed ==
//                                                                 false
//                                                             ? "Follow".tr
//                                                             : "Unfollow".tr,
//                                                         textAlign:
//                                                             TextAlign.center,
//                                                         style: const TextStyle(
//                                                           color: Colors.white,
//                                                           fontSize: 14,
//                                                           fontFamily: 'Roboto',
//                                                           fontWeight:
//                                                               FontWeight.w500,
//                                                           height: 0,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                     ),
//                     const SizedBox(height: 10),
//                     discoverUsers(),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Obx(() => controller.isLoadingGetVlog.value
//                         ? Container()
//                         : ListView.builder(
//                             itemCount:
//                                 controller.trendingVlogModel.vlogs?.length ?? 0,
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemBuilder: (BuildContext context, int index) {
//                               return CustomVlogCard(
//                                 isRedrectRormVlogPage: true,
//                                 vlog: controller.trendingVlogModel.vlogs![index],
//                               );
//                             },
//                           ))
//                   ],
//                 );
//               }),
//             ),
//           );
//         } else {
//           _isFullScreen = false;
//           return Scaffold(
//             body: InkWell(
//               onTap: () {
//                 setState(() {
//                   _video_play_controller.value!.value.isPlaying
//                       ? _video_play_controller.value!.pause()
//                       : _video_play_controller.value!.play();
//                 });
//               },
//               child: Stack(
//                 children: [
//                   Center(
//                     child: _video_play_controller.value!.value.isInitialized
//                         ? ClipRRect(
//                             child: VideoPlayer(_video_play_controller.value!),
//                           )
//                         : SizedBox(
//                             width: double.infinity,
//                             height: 170.ah,
//                             child: const Center(
//                                 child: CircularProgressIndicator(
//                               strokeWidth: 1,
//                             )),
//                           ),
//                   ),
//                   Positioned(
//                       right: 20,
//                       bottom: 20,
//                       child: InkWell(
//                         onTap: () {
//                           SystemChrome.setPreferredOrientations([
//                             DeviceOrientation.portraitUp,
//                           ]);
//                         },
//                         child: const SizedBox(
//                           height: 30,
//                           width: 30,
//                           child: Icon(
//                             Icons.fullscreen,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ))
//                 ],
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
//
//   Widget discoverUsers() {
//     VlogFullViewController controller = Get.find<VlogFullViewController>();
//     return SizedBox(
//       height: 223.ah,
//       child: Obx(
//         () => controller.isLoadingDiscoveruser.value
//             ? Container()
//             : ListView.builder(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: controller
//                         .discoverUsersModelData.value.discoverUsers?.length ??
//                     0,
//                 itemBuilder: (context, index) {
//                   var users = controller
//                       .discoverUsersModelData.value.discoverUsers![index];
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 14.0),
//                     child: InkWell(
//                       onTap: () {
//                         Get.to(() => UserProfileScreen(
//                               userId: '${users.id}',
//                             ));
//                       },
//                       child: CustomUserCard(
//                         users: users,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }

class VlogViewScreen extends StatefulWidget {
  final String videoUrl;
  final String vlogId;

  VlogViewScreen({Key? key, required this.videoUrl, required this.vlogId}) : super(key: key);

  @override
  State<VlogViewScreen> createState() => _VlogViewScreenState();
}

class _VlogViewScreenState extends State<VlogViewScreen> {
  final VlogFullViewController controller = Get.put(VlogFullViewController());

  @override
  void initState() {
    super.initState();
    controller.getVlogById(vlogId: widget.vlogId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("_vlog".tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildUserInfoRow(),


          const SizedBox(height: 10),
          VideoPlayerWidget(videoUrl: widget.videoUrl),
          const SizedBox(height: 15),
          buildLikeShareSaveRow(),
          const SizedBox(height: 10),
          buildVlogDetails(),
        ],
      ),
    );
  }

  Widget buildUserInfoRow() {
    return Row(
      children: [
        const SizedBox(width: 10),
        InkWell(
          onTap: () {
            final user = controller.vlogByIdModel.value?.vlog?.user;
            Get.to(() => UserProfileScreen(userId:"${user?.id}"));
          },
          child: Row(
            children: [
              Obx(() {
                final user = controller.vlogByIdModel.value?.vlog?.user;
                return CustomImageView(
                  height: 30.adaptSize, width: 30.adaptSize,
                  fit: BoxFit.cover,
                  onTap: () {
                    Get.to(() => UserProfileScreen(userId: "${user?.id}"));
                   // Get.to(() => MyProfileScreen());
                  },
                  radius: BorderRadius.circular(50),
                  imagePath: user?.avatarUrl,
                );
              }),

              const SizedBox(width: 10),
              Obx(() {
                final handle = controller.vlogByIdModel.value?.vlog?.user?.handle ?? "";
                return Text(handle,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.90),
                    fontWeight: FontWeight.w600, fontSize: 12.fSize,
                  ),
                );
              }),
            ],
          ),
        ),

        const Spacer(),
        InkWell(
          onTap: () {
            VlogBottomSheets.vlogmenuBottomSheet(
              context: context,
              id: widget.vlogId,
              postType: PostType.vlog,
              userHandle: controller.vlogByIdModel.value?.vlog?.user?.handle ?? '',
              isUrl: controller.vlogByIdModel.value?.vlog?.videoUrl ?? '',
              userId: "${controller.vlogByIdModel.value?.vlog?.user?.id}"
            );
          },
          child: Icon(Icons.more_vert_outlined, color: Colors.black.withOpacity(0.90), size: 20),
        ),
        const SizedBox(width: 20),
      ],
    );
  }
  Widget buildLikeShareSaveRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.aw),
      child: Row(
        children: [
          Obx(() {
            final alreadyLiked = controller.vlogByIdModel.value?.vlog?.alreadyLiked ?? false;
            return InkWell(
              onTap: () async {
                controller.toggleLikeStatus();
                await ApiRepository.vlogLike(userId: "${controller.vlogByIdModel.value?.vlog?.id}");
              },
              child: CustomImageView(
                imagePath: alreadyLiked
                    ? 'assets/image/love_true_blue.svg'
                    : 'assets/image/love_false_blue.svg',
                width: 21.aw,
                height: 21.aw,
              ),
            );
          }),
          const SizedBox(width: 20),
          if (controller.vlogByIdModel.value?.vlog?.commentAllowed ?? true)
            InkWell(
              onTap: () {
                VlogBottomSheets.commentsBottomSheet(
                  context: context,
                  id: widget.vlogId,
                  postType: PostType.vlog,
                );
              },
              child: CustomImageView(
                imagePath: 'assets/image/comments_blue.png',
                width: 21.aw,
                height: 21.aw,
              ),
            ),
          const SizedBox(width: 20),
          InkWell(
            onTap: () {
              VlogBottomSheets.shareBottomSheet(
                context: context,
                id: widget.vlogId,
                postType: PostType.vlog,
                userName: controller.vlogByIdModel.value?.vlog?.user?.handle ?? '',
                isUrl: controller.vlogByIdModel.value?.vlog?.videoUrl ?? '',
              );
            },
            child: CustomImageView(
              imagePath: 'assets/image/Vector (1).png',
              color: MyColor.primaryColor,
              height: 21.aw,
            ),
          ),
          const Spacer(),
          Obx(() {
            final alreadySaved = controller.vlogByIdModel.value?.vlog?.alreadySaved ?? false;
            return InkWell(
              onTap: () async {
                if (alreadySaved) {
                  await ApiRepository.saveAllById(
                    postType: PostType.vlog,
                    id: "${controller.vlogByIdModel.value?.vlog?.id}",
                    categoryId: "0",
                  );
                } else {
                  VlogBottomSheets.saveBottomSheet(
                    context: context,
                    id: widget.vlogId,
                    postType: PostType.vlog,
                  );
                }
                controller.getVlogById(vlogId: widget.vlogId);
              },
              child: CustomImageView(
                imagePath: alreadySaved
                    ? 'assets/image/save_true_blue.svg'
                    : 'assets/image/save_false_blue.svg',
                width: 21.aw,
                height: 21.aw,
              ),
            );
          }),
        ],
      ),
    );
  }
  Widget buildVlogDetails() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.aw),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  final views = controller.vlogByIdModel.value?.vlog?.numberOfViews ?? "0";
                  return Text(
                    "$views views",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.fSize,
                      letterSpacing: 0.70,
                    ),
                  );
                }),
                Obx(() {
                  final handle = controller.vlogByIdModel.value?.vlog?.user?.handle ?? "";
                  final title = controller.vlogByIdModel.value?.vlog?.title ?? "";
                  return RichText(
                    text: TextSpan(
                      text: handle,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                      recognizer: (
                          TapGestureRecognizer()
                        ..onTap = () {
                          final user = controller.vlogByIdModel.value?.vlog?.user;
                          Get.to(() => UserProfileScreen(userId: "${user?.id}"));
                        }),
                      children: [
                        TextSpan(
                          text: " $title",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.60),
                            fontWeight: FontWeight.w500,
                            fontSize: 14.fSize,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                Obx(() {
                  final createdAt = controller.vlogByIdModel.value?.vlog?.createdAt?.toString() ?? "";
                  return Text(
                    calculateTimeDifference(createdAt),
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.50),
                      fontWeight: FontWeight.w500,
                      fontSize: 11.fSize,
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VlogBottomSheets {
  static TextEditingController reasonController = TextEditingController();

  static Future<void> commentsBottomSheet(
      {required BuildContext context,
        required String id,
        required PostType postType}) async {

    ComnetsController commentsController = Get.put(ComnetsController());
    commentsController.getComments(id: id, postType: postType);
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SizedBox(
          height: 400.ah,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20.ah),
                Center(
                  child: Text('comments'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.98,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                SizedBox(height: 20.ah),
                Obx(() => commentsController.isLoading.value
                      ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  )
                      : Expanded(
                    child:
                    commentsController.getCommentsModel
                        .comments?.length ==
                        0
                        ? Center(
                      child: Text(
                        "no_comment".tr,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight:
                            FontWeight.w600),
                      ),
                    )
                        : ListView.builder(
                      reverse: true,
                      itemCount: commentsController
                          .getCommentsModel
                          .comments
                          ?.length,
                      itemBuilder:
                          (BuildContext context,
                          int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: 10.0.ah),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            mainAxisSize:
                            MainAxisSize.min,
                            children: [
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .start,
                                children: [
                                  CustomImageView(
                                    width: 40.adaptSize,
                                    height:
                                    40.adaptSize,
                                    imagePath:
                                    commentsController
                                        .getCommentsModel
                                        .comments?[
                                    index]
                                        .user
                                        ?.avatarUrl,
                                    fit: BoxFit.cover,
                                    radius: BorderRadius
                                        .circular(45
                                        .adaptSize),
                                    onTap: () {
                                      Get.back();
                                      Get.to(() =>
                                          UserProfileScreen(
                                              userId:
                                              "${commentsController.getCommentsModel.comments?[index].user?.id}"));
                                    },
                                  ),
                                  SizedBox(
                                    width: 18.aw,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${commentsController.getCommentsModel.comments?[index].user?.fullName}  ",
                                            style:
                                            TextStyle(
                                              color: Colors
                                                  .black,
                                              fontSize:
                                              14.adaptSize,
                                              fontFamily:
                                              'Roboto',
                                              fontWeight:
                                              FontWeight
                                                  .w700,
                                            ),
                                          ),
                                          Text(
                                            calculateTimeDifference(
                                                "${commentsController.getCommentsModel.comments?[index].createdAt}"),
                                            style:
                                            TextStyle(
                                              color: Colors
                                                  .black
                                                  .withOpacity(
                                                  .50),
                                              fontSize:
                                              14,
                                              fontFamily:
                                              'Roboto',
                                              fontWeight:
                                              FontWeight
                                                  .w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width:
                                            230.aw,
                                            child: Text(
                                              "${commentsController.getCommentsModel.comments?[index].content}",
                                              style:
                                              TextStyle(
                                                color: Colors
                                                    .black
                                                    .withOpacity(.50),
                                                fontSize:
                                                14,
                                                fontFamily:
                                                'Roboto',
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width:
                                            20.aw,
                                          ),
                                          Column(
                                            children: [
                                              Obx(
                                                    () => InkWell(
                                                    onTap: () async {
                                                      //  Get.snackbar("title", "${commentsController.getCommentsModel.comments?[index].id}");
                                                      //  print("object_sdfdsfdfdsf");
                                                      //    Get.snackbar("", '',backgroundColor:  const Color(0xFF001649),colorText: Colors.white,titleText:const Text("Please write something",style: TextStyle(color: Colors.white),));
                                                      commentsController.getCommentsModel.comments?[index].isLikedByMe.value = !commentsController.getCommentsModel.comments![index].isLikedByMe.value;
                                                      if (commentsController.getCommentsModel.comments?[index].isLikedByMe.value == true) {
                                                        commentsController.getCommentsModel.comments?[index].numberOfLikes.value = (commentsController.getCommentsModel.comments?[index].numberOfLikes.value ?? 1) + 1;
                                                      } else {
                                                        commentsController.getCommentsModel.comments?[index].numberOfLikes.value = (commentsController.getCommentsModel.comments?[index].numberOfLikes.value ?? 1) - 1;
                                                      }

                                                      // setState(() {});
                                                      // widget.blog.alreadyLiked = false;
                                                      // widget.blog.numberOfLikes =
                                                      //     widget.blog.numberOfLikes! - 1;
                                                      // setState(() {});
                                                      bool isLiked = await ApiRepository.commnetLikeONvlog(volgId: "${commentsController.getCommentsModel.comments?[index].id}",postType: postType);
                                                    },
                                                    child: CustomImageView(
                                                      imagePath: commentsController.getCommentsModel.comments?[index].isLikedByMe.value == true ? "assets/image/love_true_blue.svg" : 'assets/image/love_false_blue.svg',
                                                      width: 21.aw,
                                                      height: 21.aw,
                                                    )),
                                              ),
                                              Obx(() {
                                                return Text(
                                                  "${commentsController.getCommentsModel.comments?[index].numberOfLikes.value == 0 ? "" : commentsController.getCommentsModel.comments?[index].numberOfLikes}",
                                                );
                                              }),
                                            ],
                                          )
                                        ],
                                      ),
                                      if ("${commentsController.getCommentsModel.comments?[index].user?.id}" == PrefUtils().getUserId())
                                        InkWell(
                                          onTap: () async {
                                            commentsController.deleteComments(id: id, postType: postType, commentId: "${commentsController.getCommentsModel.comments?[index].id}");
                                          },
                                          child: Text(
                                            "Delete".tr,
                                            style:
                                            TextStyle(
                                              color: Colors
                                                  .black,
                                              fontSize:
                                              12.adaptSize,
                                              fontFamily:
                                              'Roboto',
                                              fontWeight:
                                              FontWeight
                                                  .w500,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )),

                SizedBox(height: 10.v,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    children: [
                      Form(
                        key: commentsController.formKey,
                        child: SizedBox(
                          width: 290.aw,
                          child: TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 15),
                                disabledBorder: InputBorder.none,
                                hintText: "add_comment".tr),
                            onTap: () {},
                            validator: Validator.pleaseWriteSomething,
                            onEditingComplete: () {
                              if(commentsController.formKey.currentState!.validate()){
                                FocusScope.of(context).unfocus();
                                commentsController.postComments(
                                    id: id,
                                    postType: postType,
                                    comment: commentsController.commnetsTc.text.trim());
                              }
                            },
                            controller: commentsController.commnetsTc,
                            textInputAction: TextInputAction.send,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.v,
                      ),
                      InkWell(
                        onTap: () {
                          if(commentsController.formKey.currentState!.validate()){
                            FocusScope.of(context).unfocus();
                            commentsController.postComments(
                                id: id,
                                postType: postType,
                                comment: commentsController.commnetsTc.text.trim());
                          }
                        },
                        child: Text(
                          'Postt'.tr,
                          style: TextStyle(
                            color: Color(0xFF001649),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]
          ),
        ),
      ),
      isScrollControlled: true, // Optional: Adjust based on content size
      backgroundColor: Colors.transparent,
    );
    Get.find<DashBoardController>().bottomBarShow.value = true;
  }

  static Future<void> shareBottomSheet({
    required BuildContext context,
    required String id,
    required PostType postType,
    required String userName,
    required String isUrl,
  }) async {
    ShareController controller = Get.find<ShareController>();
    await Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SizedBox(
          height: 400.ah,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                  child: Center(
                    child: Text(
                      'share'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.98,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                Obx(
                      () => controller.isLoading.value
                      ? const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
                  )
                      : SizedBox(
                    height: MediaQuery.of(context).size.height * .40,
                    child: controller.allFriendsModel.friends?.length ==
                        0
                        ? Center(child: Text("no_friends_found".tr))
                        : ListView.builder(
                      //  shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller
                          .allFriendsModel.friends?.length ??
                          0,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(10.0.adaptSize),
                          child: InkWell(
                            onTap: () async {
                              Get.back();
                              CreateChatModel createChatModel =
                              await ApiRepository.createChat(
                                  userId:
                                  "${controller.allFriendsModel.friends?[index].id}");
                              int indexxx =
                              "${createChatModel.payload?.participants?[0].id}" ==
                                  PrefUtils().getUserId()
                                  ? 1
                                  : 0;
                              print("chatId $indexxx");
                              // "send_a_vlog": "Send a Vlog of",
                              // "send_a_blog": "Send a blog of",
                              // "send_a_post": "Send a post of",
                              //
                              var msg = ".";
                              var post = "send_a_post".tr;
                              var vlog = "send_a_vlog".tr;
                              var blog = "send_a_blog".tr;
                              if (postType.name == "post") {
                                msg = "${post} $userName";
                              }
                              if (postType.name == "vlog") {
                                msg = "${vlog} $userName";
                              }
                              if (postType.name == "blog") {
                                msg = "${blog} $userName";
                              }

                              final response = await ApiRepository
                                  .sendMessageWithShare(
                                  message: msg,
                                  chatId: createChatModel
                                      .payload!.id
                                      .toString(),
                                  postType: postType,
                                  isUrl: isUrl,
                                  isLinkId: id);
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 60.adaptSize,
                                  width: 60.adaptSize,
                                  child: CustomImageView(
                                    height: 60.adaptSize,
                                    width: 60.adaptSize,
                                    imagePath: controller
                                        .allFriendsModel
                                        .friends?[index]
                                        .avatarUrl,
                                    fit: BoxFit.cover,
                                    radius: BorderRadius.circular(
                                        45.adaptSize),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    "${controller.allFriendsModel.friends?[index].fullName}")
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ]
          ),
        ),
      ),
      isScrollControlled: true, // Optional: Adjust based on content size
      backgroundColor: Colors.transparent,
    );

    Get.find<DashBoardController>().bottomBarShow.value = true;
  }

  static Future<bool> saveBottomSheet({
    required BuildContext context,
    required String id,
    required PostType postType,
  }) async {
    SaveController controller;
    if (Get.isRegistered<SaveController>()) {
      controller = Get.find<SaveController>();
    } else {
      controller = Get.put(SaveController());
      print("MyController is not initialized.");
    }

    bool issave = false;
    RxBool apiLoading = false.obs;
    await Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 24.ah),
            Row(
              children: [
                Text(
                  "save_post".tr,
                  style: GoogleFonts.roboto().copyWith(
                      fontSize: 22.fSize,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Get.bottomSheet(
                        Container(
                          color: Colors.white,
                          height: 400.ah,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AddNewCategoryBottomSheet(),
                            ],
                          ),
                        )
                    );

                    // onTapAddNewCategory(context: context);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.add),
                      SizedBox(
                        width: 5.aw,
                      ),
                      Text("NewCategoryy".tr)
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 10.ah),
            for (Category data
            in (controller.cateogoryModel.value?.categories ??
                []))
              InkWell(
                onTap: () async {
                  apiLoading.value = true;
                  issave = await ApiRepository.saveAllById(
                      postType: postType,
                      id: id,
                      categoryId: "${data.id}");
                  if(issave){
                    if(postType.name == "vlog"){
                      Get.find<VlogFullViewController>().getVlogById(vlogId: id);
                    }
                  }
                  print("Line544==$issave");
                  Get.back();
                  apiLoading.value = false;
                },
                child: Container(
                  child: Padding(
                    padding:  EdgeInsets.all(12.0.adaptSize),
                    child: Row(
                      children: [
                        const Icon(Icons.check_box_outline_blank),
                        SizedBox(width: 5.aw),
                        Text(data.name ?? "")
                      ],
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: 20.ah,
            )
          ],
        ),
      ),
      isScrollControlled: true, // Optional: Adjust based on content size
      backgroundColor: Colors.transparent,
    );
    return true ;
  }

  static Future<void> vlogmenuBottomSheet({
    required String id,
    required PostType postType,
    required BuildContext context,
    required String userHandle,
    required String isUrl,
    required String userId,
  }) async {
    await Get.bottomSheet(
      Container(
        padding:  EdgeInsets.all(20.0.adaptSize),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
           mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           if(PrefUtils().getUserId() == userId)
            InkWell(
              onTap: () async{
                Get.back();
                await ApiRepository.deletePostBolgVlog(id: id, postType: postType);
                if (Get.isRegistered<MyProfileController>()) {
                  Get.find<MyProfileController>().getProfile();
                }
                Get.back();
              },
              child: Row(
                children: [
                  SizedBox(height: 20.ah,),
                  Container(
                    width: 38,
                    height: 38,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFDEDEDE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    child: Center(child: Icon(Icons.save,size: 18,),),
                  ),
                  SizedBox(width: 10.aw,),
                  Text('_delete'.tr,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.ah,),
            InkWell(
              onTap: () {
                Get.back();
                saveBottomSheet(
                    context: context,
                    id: id,
                    postType: postType,
                );
              },
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: ShapeDecoration(
                      color: Color(0xFFDEDEDE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    child: Center(child: Icon(Icons.save,size: 18,),),
                  ),
                  SizedBox(width: 10.aw,),
                  Text('_save'.tr,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 20.ah,),
            InkWell(
              onTap: () {
                 Get.back();
                 shareBottomSheet(
                     context: context,
                     id: id,
                     postType: postType,
                     userName:userHandle,
                     isUrl: isUrl
                 );
              },
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: ShapeDecoration(
                      color: Color(0xFFDEDEDE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    child: Center(child: Icon(Icons.share,size: 18,),),
                  ),
                  SizedBox(width: 10.aw,),
                  Text(
                    '_share'.tr,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 20.ah,),
            InkWell(
              onTap: () {
                Get.back();
                reportFun(Get.context!,id,postType);
              },
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: ShapeDecoration(
                     // color: Color(0xFFDEDEDE),
                      color: Colors.red.withOpacity(0.30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    child: Center(child: Icon(Icons.report,color: Colors.red)),
                  ),
                  SizedBox(width: 10.aw,),
                  Text(
                    '_report'.tr,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.ah,),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }


  static void reportFun(
      BuildContext context,
      String  vlogId,
      PostType postType,
      ) async {
    await showDialog(
        context: context,

        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Text(
                'vlog_report_reason'.tr,
                style: TextStyle(
                  color: const Color(0XFF111111),
                  fontWeight: FontWeight.w600,
                  fontSize: 18.adaptSize,
                  fontFamily: 'Roboto',
                ),
              ),
              actions: <Widget>[
                SizedBox(
                  width: 300,
                  child: CustomTextFormField(
                    context: context,
                    maxLines: 4,
                    controller: reasonController,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 44.adaptSize,
                          width: 110.adaptSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: const Color(0xff001649), width: 1.aw)),
                          child: Center(
                            child: Text(
                              'cancel'.tr,
                              style: TextStyle(
                                color: const Color(0XFF001649),
                                fontWeight: FontWeight.w700,
                                fontSize: 15.adaptSize,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 30.aw),
                      InkWell(
                        onTap: () async {
                          if(reasonController.text.trim().isEmpty || reasonController.text == "" ){
                            Get.snackbar("", "please_enter_report_reason".tr, backgroundColor:const Color(0xff001649),colorText: Colors.white);
                          }else{
                            print("vlogid==>${vlogId}");
                            bool isreport =  await ApiRepository.reportPostVlogBlog(id: vlogId, reason: reasonController.text,postType: postType);
                            if(isreport){
                              reasonController.clear();
                              Get.back();
                            }
                          }
                        },
                        child: Container(
                          height: 44.adaptSize,
                          width: 110.adaptSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff001649),
                          ),
                          child: Center(
                            child: Text(
                              'Report'.tr,
                              style: TextStyle(
                                color: const Color(0XFFFFFFFF),
                                fontWeight: FontWeight.w700,
                                fontSize: 15.adaptSize,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]);
        });
  }
}

/*SizedBox(height: 10),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Image.asset(
                  'assets/image/location-outline.png',
                  width: 21.ah,
                  height: 21.ah,
                  color: Colors.black.withOpacity(0.70),
                ),
              ),

              SizedBox(width: 5),
              Obx(() {
                final handle = controller.vlogByIdModel.value?.vlog?.location ?? "";
                return Text(handle,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.70),
                    fontWeight: FontWeight.w600, fontSize: 12.fSize,
                  ),
                );
              }),
            ],
          ),*/

