import 'package:flutter/material.dart';
import 'package:frenly_app/core/constants/my_colour.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/vlog_full_view/vlog_full_view.dart';
import 'package:get/get.dart';
import '../../../Widgets/custom_image_view.dart';
import '../../../core/constants/app_dialogs.dart';
import '../../../data/models/PostSingleViewModel.dart';
import '../../../data/repositories/api_repository.dart';
import '../../Blog/blog_full_view_screen/blogs_full_view_screen.dart';
import '../../photos/photo_view_screen.dart';
import '../Pages/chat_room/chat_room_model.dart';
import 'package:intl/intl.dart';

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
                padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 8.v),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                  ),
                  color: MyColor.primaryColor
                ),
                // decoration: AppDecoration.fillGray.copyWith(
                //     borderRadius: BorderRadiusStyle.customBorderTL10),
                // child: Text("$message",
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 16.adaptSize,
                //       fontWeight: FontWeight.w400
                //     ),
                //
                // ),
              child: InkWell(
                onTap: () async {
                  print("dsafgfdsgdgsfgdgdsgdsgdsfgdgdgfdgdfgd${message.isLink}");
                  print("dsafgfdsgdgsfgdgdsgdsgdsfgdgdgfdgdfgd${message.isLinkId}");
                  if(message.isLink==3){
                    if(message.isLinkId!=null){
                      Get.to(()=>VlogFullViewNewScreen(videoUrl: "${message.isUrl}", vlogId: "${message.isLinkId}"));
                    }else{
                      AppDialog.taostMessage("Vlog not Found");
                    }
                  }

                  if(message.isLink==2){
                    if(message.isLinkId!=null){
                      Get.to(()=>BlogsFullViewScreen( id: '${message.isLinkId}',));
                    }else{
                      AppDialog.taostMessage("Blog not Found");
                    }
                  }
                  if(message.isLink==1){
                    if(message.isLinkId!=null){
                      PostSingleViewModel post = await  ApiRepository.getPostsByID(id: "${message.isLinkId}");
                      Get.to(()=>PostFullViewScreen(  loadPostByid: "${post.post?.id}",));

                    }else{
                      AppDialog.taostMessage("Photo not Found");
                    }
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    message.isLink== 0 ? const SizedBox() : Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CustomImageView(imagePath: "assets/image/share.png",color: Colors.white,height: 20,),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width *.62,
                      child: Text("${message.content}",style: TextStyle(color:message.isLink== 0 ?   Colors.white :  Colors.white,fontWeight:message.isLink== 0 ?FontWeight.normal : FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

            ),
            SizedBox(height: 3.v),
            Opacity(
                opacity: 0.5,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.h),
                    child: Text("  ${DateFormat('hh:mm a').format(createdAt ?? DateTime.now())}",
                      style: TextStyle(fontSize: 12.adaptSize),
                    )

                )),
            SizedBox(height: 10.v),

          ],
        ),
      ),
    );
  }
}
