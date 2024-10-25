import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/core/constants/app_dialogs.dart';
import 'package:frenly_app/core/constants/my_colour.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/Blog/blog_view/blog_view_screen.dart';
import 'package:get/get.dart';
import '../../Vlog/vlog_full_view/vlog_view_screen.dart';
import '../../post/post_view/post_view_screen.dart';
import '../Pages/chat_room/chat_room_model.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({Key? key, required this.message, required this.createdAt}) : super(key: key);
  final SingleMessage message;
  final DateTime createdAt;


  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now().toUtc();
    print("$time");

    // convert local date time to string format local date time

    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              child: Container(
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 8.v),
                decoration: BoxDecoration(
                  color: Color(0xffEDEDED),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15.adaptSize),
                    bottomLeft: Radius.circular(15.adaptSize),
                    topLeft: Radius.circular(15.adaptSize),
                    // topRight: Radius.circular(15.adaptSize),
                  ),
                ),
                child: InkWell(
                  onTap: () async {
                    if(message.isLink==3){
                      if(message.isLinkId!=null){
                        Get.to(()=>VlogViewScreen(videoUrl: "${message.isUrl}",
                            vlogId: "${message.isLinkId}"));
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
                        Get.to(()=> PostViewScreen(  id:  "${message.isLinkId}",));
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
                        child: CustomImageView(imagePath: "assets/image/share_in_msg_icon.svg",color: Colors.red,height: 20,),
                      ),
                      ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width*.70, // Set the maximum width here
                          ),
                          child: Text("${message.content}",style: TextStyle(color:message.isLink== 0 ?  Colors.black :  MyColor.primaryColor,fontWeight:message.isLink== 0 ?FontWeight.normal : FontWeight.bold),)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.v),
            Opacity(
                opacity: 0.5,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.h),
                    child: Text("${createdAt.hour}:${createdAt.minute < 10 ? "0${createdAt.minute}" : createdAt.minute}    ",
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
