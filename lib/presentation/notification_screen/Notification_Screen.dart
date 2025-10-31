import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frenly_app/presentation/chat/Pages/chat_room/chat_room_page.dart';
import 'package:frenly_app/presentation/chat/Pages/chats/chats_screen.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';

import 'package:frenly_app/presentation/Blog/blog_view/blog_view_screen.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_screen.dart';
import 'package:get/get.dart';
import '../../core/utils/pref_utils.dart';
import '../../data/models/PostSingleViewModel.dart';
import '../Vlog/vlog_full_view/vlog_view_screen.dart';
import '../chat/Pages/all_frined/CreateChatModel.dart';
import '../chat/Pages/all_frined/all_friend_controller.dart';
import '../post/post_view/post_view_screen.dart';
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

  void deleteNotification(
      BuildContext context,
      ) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: Text('are_you_sure'.tr,
                style: TextStyle(
                  color: const Color(0XFF111111),
                  fontWeight: FontWeight.w600,
                  fontSize: 18.adaptSize,
                  fontFamily: 'Roboto',
                ),
              ),
              actions: <Widget>[
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
                              border: Border.all(color:Color(0xff001649),width: 1.aw)),
                          child: Center(
                            child: Text('cancel'.tr,
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
                      SizedBox(width: 15.aw),
                      InkWell(
                        onTap: () async{
                          Get.back();
                          Get.back();
                          await ApiRepository.deleteNotificationAll(postId: '');
                          setState(() {
                          });

                        },
                        child: Container(
                          height: 44.adaptSize,
                          width: 110.adaptSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xff001649),
                          ),
                          child: Center(
                            child: Text('clear'.tr,
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

  @override
  Widget build(BuildContext context) {
    AllFriendController controller= Get.put(AllFriendController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text('Notifications'.tr,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 32.fSize),
        ),
        actions: [
          InkWell(
            onTap: (){
              deleteNotification(context);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 15.h),
              child: Text('Clearall'.tr,
                style: TextStyle(color: Color(0xFF001649),
                    fontWeight: FontWeight.w700, fontSize: 17.fSize),
              ),
            ),
          ),
        ],
        leading: Padding(
          padding: EdgeInsets.only(left: 15.h),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_sharp)),
        ),
      ),
      body: notificationsModel.notifications?.length==0?Center(child:Text("no_notification_found".tr),):ListView(
        children: [
          SizedBox(height: 20.ah),
          isLading ?const SizedBox(
                  height: 500,
                  child: Center(
                      child: CircularProgressIndicator(strokeWidth: 1,
                  )))
              : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: notificationsModel.notifications?.length ?? 0,
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        height: 78.ah,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: SingleChildScrollView(
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
                              SizedBox(width: 10),
                              SizedBox(
                                width: 180.aw,
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '${notificationsModel.notifications?[index].byUser?.fullName ?? "App Notification"} ',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15, fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w500, height: 0),

                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            try {
                                              // Pass the correct friend/notification userId
                                              final friendId = notificationsModel.notifications?[index].byUser?.id;

                                              if (friendId == null) {
                                                print("Error: friendId is null");
                                                return;
                                              }

                                              // Create chat with backend
                                              final createChatModel = await ApiRepository.createChat(userId: friendId.toString());

                                              if (createChatModel.payload == null) {
                                                print("Create chat failed: payload is null");
                                                return;
                                              }

                                              // Choose correct participant
                                              final int indexxx =
                                              createChatModel.payload!.participants![0].id.toString() == PrefUtils().getUserId()
                                                  ? 1
                                                  : 0;

                                              // ✅ Use chatId from backend payload, not from notification
                                              final chatId = createChatModel.payload!.id.toString();

                                              // Navigate to ChatRoomPage
                                              Get.off(() => ChatRoomPage(
                                                participant: createChatModel.payload!.participants![indexxx],
                                                chatId: chatId,
                                              ));
                                            } catch (e) {
                                              print("Navigation to ChatRoomPage failed: $e");
                                            }
                                          },
                                      ),

                                      TextSpan(
                                        text: removeUserName(notificationsModel.notifications?[index].byUser?.fullName ?? "App", notificationsModel.notifications?[index].content ?? "",),
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
                                           Get.to(()=> PostViewScreen(id: "${postmodel.post?.id}",));
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
                                           Get.to(()=>VlogViewScreen( videoUrl: '${notificationsModel.notifications?[index].data?.videoUrl}', vlogId: '${notificationsModel.notifications?[index].data?.id}',));
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
                                          Get.to(()=>  BlogViewScreen( id: '${notificationsModel.notifications?[index].data?.id}',));
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
                                      child: const Text('Accept',
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
                        ),
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
