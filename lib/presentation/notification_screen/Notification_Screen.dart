import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/presentation/request_users/req_screen.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_screen.dart';
import 'package:get/get.dart';

import 'NotificationsModel.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  NotificationsModel notificationsModel =NotificationsModel();
   bool isLading =false;

  apiCall() async{
    isLading =true;
    setState(() {});
    notificationsModel=  await ApiRepository.notification();
   isLading =false;
    setState(() {});

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
            Text('Notifications'.tr,
              style: TextStyle(
                  color: Colors.black,fontWeight: FontWeight.w700,fontSize:32.fSize
              ),
            ),
          ],
        ),
        leading: Padding(
          padding:  EdgeInsets.only(left: 15.h),
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
            InkWell(
              onTap: () {
                Get.to(()=>ReqScreen());
              },

                child: Text("reqests")),
            isLading ? SizedBox(
              height: 500,
                child: Center(child: CircularProgressIndicator(strokeWidth: 1,))):  ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: notificationsModel.notifications?.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left:20,right:20,top:25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomImageView(
                              onTap: () {
                                Get.to(()=>UserProfileScreen(userId: "${notificationsModel.notifications?[index].byUser?.id}"));
                              },
                              height: 62.ah,
                              width: 62.ah,
                              imagePath: notificationsModel.notifications?[index].byUser?.avatarUrl,
                              radius: BorderRadius.circular(63.ah),
                            ),
                            SizedBox(width: 10.aw),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('${notificationsModel.notifications?[index].byUser?.fullName}',
                                  style: TextStyle(
                                    color: Colors.black,fontWeight: FontWeight.w700,fontSize:15.fSize,
                                  ),),
                                Text('${notificationsModel.notifications?[index].content}',
                                  style: TextStyle(
                                    color: Colors.grey,fontWeight: FontWeight.w500,fontSize:15.fSize,
                                  ),),
                              ],
                            ),
                          ],
                        ),

                      ],
                    ),
                    Divider(color: Color(0xFFD9D9D9),height: 1,endIndent:40,indent: 55),

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

