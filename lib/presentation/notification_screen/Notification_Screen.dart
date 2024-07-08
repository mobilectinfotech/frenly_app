import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/presentation/Blog/blog_full_view_screen/blogs_full_view_screen.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_screen.dart';
import 'package:frenly_app/presentation/vlog_full_view/vlog_full_view.dart';
import 'package:get/get.dart';
import '../../data/models/PostSingleViewModel.dart';
import '../photos/photo_view_screen.dart';
import 'NotificationsModel.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationsModel notificationsModel = NotificationsModel();
  bool isLading = false;

  apiCall() async {
    isLading = true;
    setState(() {});
    notificationsModel = await ApiRepository.notification();
    isLading = false;
    setState(() {});
  }



  String removeUserName(String fullName, String content) {
    return content.replaceFirst(fullName, '').trim();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              'Notifications'.tr,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 32.fSize),
            ),
          ],
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 15.h),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_sharp)),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20.ah),

          isLading
              ?const SizedBox(
                  height: 500,
                  child: Center(
                      child: CircularProgressIndicator(strokeWidth: 1,

                  )))
              : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: notificationsModel.notifications?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      height: 78.ah,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomImageView(
                            width: 56.adaptSize,
                            height: 56.adaptSize,
                            onTap: () {
                              Get.to(() => UserProfileScreen(userId: '${notificationsModel.notifications?[index].byUser?.id}',));

                            },
                            imagePath: notificationsModel.notifications?[index].byUser?.avatarUrl,
                            radius : BorderRadius.circular(100),

                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 180.aw,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${notificationsModel.notifications?[index].byUser?.fullName}   ',
                                    style:const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                  TextSpan(
                                    text: removeUserName(notificationsModel.notifications?[index].byUser?.fullName ?? "", notificationsModel.notifications?[index].content ?? "",),
                                    style:const TextStyle(
                                      color: Color(0xFF505050),
                                      fontSize: 15,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                           // post
                           if("${notificationsModel.notifications?[index].type}" == "post")
                             Row(
                               children: [
                                 SizedBox(width : 50.aw),
                                 Padding(
                                   padding: const EdgeInsets.only(right: 8.0),
                                   child: InkWell(
                                     onTap: () async {
                                       PostSingleViewModel postmodel = await   ApiRepository.getPostsByID(id: "${notificationsModel.notifications?[index].data?.id}");
                                       Get.to(()=> PostFullViewScreen(loadPostByid: "${postmodel.post?.id}",));
                                       },
                                     child: CustomImageView(
                                       width: 47.02,
                                       height: 48,
                                      radius: BorderRadius.circular(8),
                                       imagePath:notificationsModel.notifications?[index].data?.imageUrl,
                                     ),
                                   ),
                                 ),
                               ],
                             ),

                          if("${notificationsModel.notifications?[index].type}" == "vlog")
                             Row(
                               children: [
                                 SizedBox(width : 50.aw),
                                 Padding(
                                   padding: const EdgeInsets.only(right: 8.0),
                                   child: InkWell(
                                     onTap: () async {
                                       Get.to(()=>VlogFullViewNewScreen( videoUrl: '${notificationsModel.notifications?[index].data?.videoUrl}', vlogId: '${notificationsModel.notifications?[index].data?.id}',));
                                     },
                                     child: CustomImageView(
                                       width: 47.02,
                                       height: 48,
                                       radius: BorderRadius.circular(8),
                                       imagePath:notificationsModel.notifications?[index].data?.thumbnailUrl ,
                                       fit: BoxFit.cover,

                                     ),
                                   ),
                                 ),
                               ],
                             ),

                          if("${notificationsModel.notifications?[index].type}" == "blog")
                            Row(
                              children: [
                                SizedBox(width : 50.aw),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      Get.to(()=>  BlogsFullViewScreen( id: '${notificationsModel.notifications?[index].data?.id}',));
                                    },

                                    child: CustomImageView(
                                      width: 47.02,
                                      height: 48,
                                      radius: BorderRadius.circular(8),
                                      imagePath:notificationsModel.notifications?[index].data?.imageUrl ,
                                      fit: BoxFit.cover,

                                    ),
                                  ),
                                ),
                              ],
                            ),

                          if("${notificationsModel.notifications?[index].type}" == "followRequest")
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                    ApiRepository.acepedReqest(byUserId: notificationsModel.notifications![index].byUserId!, toUserId: notificationsModel.notifications![index].toUserId!, notificationId: notificationsModel.notifications![index].id!);
                                    notificationsModel.notifications?.removeAt(index);
                                    setState(() {});
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF001649),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                  ),
                                  child: const Text(
                                    'Accept',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.aw),
                              InkWell(
                                onTap : ()async {
                                  await ApiRepository.deleteNotification(notificationID:"${notificationsModel.notifications?[index].id}");
                                  notificationsModel.notifications?.removeAt(index);
                                  setState(() {});
                                },

                                  child: Icon(Icons.close,color: Color(0xFF001649),))
                            ],
                          ),

                        ],
                      ),
                    );

                  },
                ),
          SizedBox(height: 20.ah),
        ],
      ),
    );
  }
}
