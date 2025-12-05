import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/core/constants/my_colour.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:get/get.dart';
import '../../../Widgets/custom_image_view.dart';
import '../../../core/constants/app_dialogs.dart';
import '../../../data/models/PostSingleViewModel.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';

import '../../Blog/blog_view/blog_view_screen.dart';
import '../../Vlog/vlog_full_view/vlog_view_screen.dart';
import '../../post/post_view/post_view_screen.dart';
import '../Pages/chat_room/chat_room_model.dart';
import 'package:intl/intl.dart';

import 'OwnMessgaeCrad.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({Key ? key, required this.message, required this.createdAt}) : super(key: key);
  final SingleMessage message;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(horizontal: 10.ah, vertical: 8.ah),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.adaptSize),
                      topRight: Radius.circular(10.adaptSize),
                      bottomRight: Radius.circular(10.adaptSize),
                  ),
                  color: MyColor.primaryColor
                ),

              child: InkWell(
                onTap: () async {
                  print("dsafgfdsgdgsfgdgdsgdsgdsfgdgdgfdgdfgd${message.isLink}");
                  print("dsafgfdsgdgsfgdgdsgdsgdsfgdgdgfdgdfgd${message.isLinkId}");
                  if(message.isLink==3){
                    if(message.isLinkId!=null){
                      Get.to(()=>VlogViewScreen(videoUrl: "${message.isUrl}", vlogId: "${message.isLinkId}"));
                    }else{
                      AppDialog.taostMessage("Vlog not Found");
                    }
                  }

                  if(message.isLink==2){
                    if(message.isLinkId!=null){
                      Get.to(()=>BlogViewScreen( id: '${message.isLinkId}',));
                    }else{
                      AppDialog.taostMessage("Blog not Found");
                    }
                  }
                  if(message.isLink==1){
                    if(message.isLinkId!=null){
                      PostSingleViewModel post = await  ApiRepository.getPostsByID(id: "${message.isLinkId}");
                      Get.to(()=>PostViewScreen(  id: "${post.post?.id}",));
                    }else{
                      AppDialog.taostMessage("Photo not Found");
                    }
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    message.isLink== 0 ? const SizedBox() : Padding(
                      padding:EdgeInsets.only(right: 8.0.aw),
                      child: CustomImageView(imagePath: "assets/image/share.png",color: Colors.white,height: 20,),
                    ),
                    ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width*.70, // Set the maximum width here
                        ),
                      child: buildReplyContent(context), // 🔥 FIXED
                      //Text("${message.content}",style: TextStyle(color:message.isLink== 0 ? Colors.white: Colors.white,fontWeight:message.isLink== 0 ?FontWeight.normal : FontWeight.bold),)
                    ),
                  ],
                ),
              ),

            ),
            SizedBox(height: 3.ah),
            Opacity(
                opacity: 0.5,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.h),
                    child: Text("  ${DateFormat('hh:mm a').format(createdAt ?? DateTime.now())}",
                      style: TextStyle(fontSize: 12.adaptSize),
                    )
                )),

            // Opacity(
            //   opacity: 0.5,
            //   child: Padding(
            //     padding: EdgeInsets.only(left: 10.h),
            //     child: Text(
            //       formatSeenTime(createdAt),
            //      // formatMessageTime(createdAt),
            //       style: TextStyle(fontSize: 12.adaptSize),
            //     ),
            //   ),
            // ),

            SizedBox(height: 10.v),
          ],
        ),
      ),
    );
  }

  Widget buildReplyContent(BuildContext context) {
    final url = message.attachmentUrl ?? "";
    final mime = message.mimeType ?? "";
    final type = message.attachmentType ?? "";

    // ---------- IMAGE ----------
    if (url.isNotEmpty &&
        (mime.startsWith("image") ||
            type == "image" ||
            type == "gif" ||
            url.toLowerCase().endsWith(".gif") ||
            url.toLowerCase().endsWith(".jpg") ||
            url.toLowerCase().endsWith(".jpeg") ||
            url.toLowerCase().endsWith(".png"))) {

      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          url,
          width: MediaQuery.of(context).size.width * 0.6,
          height: 220,
          fit: BoxFit.cover,
        ),
      );
    }

    // ---------- VIDEO ----------
    if (url.isNotEmpty &&
        (mime.startsWith("video") ||
            url.endsWith(".mp4") ||
            url.endsWith(".mov"))) {

      return InkWell(
        onTap: () {
          Get.to(() => VideoPlayerScreen(url: url));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black12,
          ),
          child: const Center(
            child: Icon(Icons.play_circle_fill, size: 60, color: Colors.white),
          ),
        ),
      );
    }

    // ---------- AUDIO ----------
    if (url.isNotEmpty &&
        (mime.startsWith("audio") ||
            url.endsWith(".aac") ||
            url.endsWith(".m4a") ||
            url.endsWith(".mp3") ||
            url.endsWith(".wav") ||
            type == "audio")) {

      return AudioMessagePlayer(url: url);
    }

    // ---------- NORMAL TEXT ----------
    return Text(
      message.content ?? "",
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }

}
