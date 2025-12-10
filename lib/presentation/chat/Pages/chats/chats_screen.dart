import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/core/constants/my_colour.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_screen.dart';
import 'package:intl/intl.dart';
import '../../../../Widgets/custom_image_view.dart';
import '../../../../core/utils/pref_utils.dart';
import '../chat_room/chat_room_page.dart';
import 'chats_controller.dart';
import 'package:get/get.dart';
import 'chats_model.dart';


class ChatsScreen extends StatelessWidget {
  ChatsScreen({super.key});

  ChatScreenController controller = Get.put(ChatScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: messageAppbar(
            context: context,
            title: "Messages".tr,
            showImage: true,
            imagepath: null,
            back: false),
        body: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1.adaptSize
                  ),
                )
              : controller.chatsModel.value?.chats!.length == 0
                  ? Center(
                      child: Text("no_chats_found".tr),
                    )
                  : Obx(() => ListView.builder(
                        itemCount: controller.chatsModel.value?.chats!.length,
                        itemBuilder: (context, index) => chatsCard(index),
              ),
          ),
        ),
      ),
    );
  }

  Widget chatsCard(int index) {
    int indexxx = "${controller.chatsModel.value?.chats![index].participants![0].id}" == PrefUtils().getUserId() ? 1 : 0;

    return InkWell(
      onTap: () {
        Get.to(() => ChatRoomPage(
              participant: controller.chatsModel.value!.chats![index].participants![indexxx],
              chatId: controller.chatsModel.value!.chats![index].id.toString(),
            ))?.then((value) {
            controller.getchats();  // reload full list after back

          // controller.chatsModel.value!.chats![index].unreadCount = 0;
            // controller.chatsModel.refresh();
            controller.chatsModel.update((val) {
              val!.chats![index].unreadCount = 0;

              // val.chats!.sort((a, b) =>
              //     (b.lastMessage?.createdAt ?? DateTime(2000))
              //         .compareTo(a.lastMessage?.createdAt ?? DateTime(2000)));

            });
          },
        );
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 15.aw),

              CustomImageView(
                onTap: () {
                  Get.to(()=>UserProfileScreen(userId: "${controller.chatsModel.value?.chats![index].participants![indexxx].id}"));
                },
                radius: BorderRadius.circular(100.adaptSize),
                height: 55.ah, width: 55.ah,
                imagePath: controller.chatsModel.value?.chats![index].participants?[indexxx].avatarUrl,
                fit: BoxFit.cover,
              ),

              SizedBox(width: 10.aw),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [

                  // Text(
                  //   "${controller.chatsModel.value?.chats![index].participants![indexxx].fullName}".capitalizeFirst!,
                  //   style: const TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),

                  Text(capitalizeEachWord("${controller.chatsModel.value?.chats![index].participants![indexxx].fullName ?? ''}"),
                    style:TextStyle(fontSize: 16.fSize, fontWeight: FontWeight.bold)),

                  /* SizedBox(
                    width: 210.aw,
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      controller.chatsModel.value?.chats![index].lastMessage?.content ?? "",
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),*/

                  SizedBox(
                    width: 210.aw,
                    child:Text(buildLastMessagePreview(controller.chatsModel.value?.chats![index].lastMessage),
                      style: TextStyle(fontSize: 13.fSize),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ),
                ],
              ),

              const Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //  String formattedTime = DateFormat('HH:mm').format(now);
                   Text(DateFormat('hh:mm a').format(controller.chatsModel.value?.chats![index].lastMessage?.createdAt!.toLocal() ?? DateTime.now().toLocal())),

                  // Text("${controller.chatsModel.value?.chats![index].lastMessage?.createdAt!.hour}:${(controller.chatsModel.value?.chats![index].lastMessage?.createdAt!.minute ?? 0) < 10 ? "0${controller.chatsModel.value?.chats![index].lastMessage?.createdAt!.minute}" : controller.chatsModel.value?.chats![index].lastMessage?.createdAt!.minute}"),

                   SizedBox(height: 8.ah),
                  if (controller.chatsModel.value?.chats![index].unreadCount != 0)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: MyColor.primaryColor),
                          child: Center(
                              child: Padding(
                            padding: EdgeInsets.only(top: 4.0.ah, bottom: 4.ah, left: 9.aw, right: 9.aw),
                            child: Text("${controller.chatsModel.value?.chats![index].unreadCount}",
                              style: TextStyle(fontSize: 12.adaptSize, color: Colors.white)),
                          )),
                        ),
                      ],
                    ),
                  if (controller.chatsModel.value?.chats![index].unreadCount == 0)
                    if (controller.chatsModel.value?.chats![index].lastMessage ?.content != null)
                      Icon(Icons.done_all),
                ],
              ),

              SizedBox(width: 20.aw),
            ],
          ),

          SizedBox(height: 20.aw),
        ],
      ),
    );
  }
}

String capitalizeEachWord(String text) {
  if (text.isEmpty) return text;
  return text.split(' ').map((word) => word.isNotEmpty ?
  word[0].toUpperCase() + word.substring(1).toLowerCase():'').join(' ');
}

String buildLastMessagePreview(LastMessage? last) {
  if (last == null) return "";

  final mime = last.mimeType ?? "";
  final type = last.attachmentType ?? "";
  final url = last.attachmentUrl ?? "";

  if (mime.startsWith("image") || type == "image" || url.endsWith(".jpg") || url.endsWith(".png")) {
    return "📷 ${"Photo".tr}";
  }

  if (mime.startsWith("video") || type == "video" || url.endsWith(".mp4")) {
    return "🎥 ${"Video".tr}";
  }

  if (mime.startsWith("audio") || type == "audio") {
    return "🎵 ${"Audio".tr}";
  }

  if (type == "gif" || url.endsWith(".gif")) {
    return "🎞️ ${"GIF".tr}";
  }

  return last.content ?? "";
}
