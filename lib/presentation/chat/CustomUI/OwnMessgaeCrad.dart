import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
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
                        Get.to(()=> PostViewScreen(id:"${message.isLinkId}",));
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
                          child: Text("${message.content}",style: TextStyle(color:message.isLink== 0 ?  Colors.black :  MyColor.primaryColor,fontWeight:message.isLink== 0 ?FontWeight.normal : FontWeight.bold))),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.v),
            // Opacity(
            //     opacity: 0.5,
            //     child: Padding(
            //         padding: EdgeInsets.only(left: 10.h),
            //         child: Text("${createdAt.hour}:${createdAt.minute < 10 ? "0${createdAt.minute}" : createdAt.minute}    ",
            //           style: TextStyle(fontSize: 12.adaptSize))
            //     )),

            Opacity(
              opacity: 0.5,
              child: Padding(
                padding: EdgeInsets.only(right: 10.h),
                child: Text(
                  formatSeenTime(createdAt),
                 // formatSeenTime(controller.messageSeenTime.value),
                  style: TextStyle(fontSize: 12.adaptSize),
                ),
              ),
            ),

            SizedBox(height: 10.v),
          ],
        ),
      ),
    );
  }
}


/*
String formatMessageTime(DateTime dateTime) {
  final now = DateTime.now();
  final localTime = dateTime.toLocal();

  // Format AM/PM time
  String formatTime(DateTime t) {
    final hour = t.hour > 12 ? t.hour - 12 : (t.hour == 0 ? 12 : t.hour);
    final minute = t.minute.toString().padLeft(2, '0');
    final amPm = t.hour >= 12 ? 'PM' : 'AM';
    return "$hour:$minute $amPm";
  }

  // Check if same day
  bool isToday = now.day == localTime.day &&
      now.month == localTime.month &&
      now.year == localTime.year;

  // Check if within same week
  final weekStart = now.subtract(Duration(days: now.weekday - 1)); // Monday
  final weekEnd = weekStart.add(Duration(days: 6));
  bool isSameWeek = localTime.isAfter(weekStart) && localTime.isBefore(weekEnd);

  if (isToday) {
    return formatTime(localTime); // e.g. "10:30 AM"
  } else if (isSameWeek) {
    final dayOfWeek = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun'
    ][localTime.weekday - 1];
    return "$dayOfWeek ${formatTime(localTime)}"; // e.g. "Wed 11:45 AM"
  } else {
    return "${localTime.day} ${[
      'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'
    ][localTime.month - 1]} ${formatTime(localTime)}"; // e.g. "12 Oct 10:30 AM"
  }
}
*/

String formatSeenTime(DateTime seenTime) {
  final now = DateTime.now();
  final difference = now.difference(seenTime);

  if (difference.inMinutes < 1) {
    return 'seen_just'.tr; // seen just now
  } else if (difference.inMinutes < 10) {
    return '${"seen".tr} ${difference.inMinutes} ${"minute_ago".tr}';
  } else {
    final time = "${seenTime.hour.toString().padLeft(2, '0')}:${seenTime.minute.toString().padLeft(2, '0')},";
    final date = "${seenTime.day.toString().padLeft(2, '0')} ${_monthName(seenTime.month)}";
    return '${"seen".tr} $time $date';
  }
}

String _monthName(int month) {
  final months = [
    "jan".tr,
    "feb".tr,
    "mar".tr,
    "apr".tr,
    "may".tr,
    "jun".tr,
    "jul".tr,
    "aug".tr,
    "sep".tr,
    "oct".tr,
    "nov".tr,
    "dec".tr,
  ];
  return months[month - 1];
}


// Perfect — you want this same logic but localized to Swedish, so:
//
// Days → “Mån, Tis, Ons, Tor, Fre, Lör, Sön”
//
// Months → “Jan, Feb, Mar, Apr, Maj, Jun, Jul, Aug, Sep, Okt, Nov, Dec”
//
// AM/PM → In Swedish, they usually use 24-hour format, not AM/PM.
// So instead of “10:30 AM” → you’ll get “10:30”, and instead of “9:15 PM” → “21:15”.
//
// Here’s your updated Swedish-localized version

// String formatMessageTime(DateTime dateTime) {
//   final now = DateTime.now();
//   final localTime = dateTime.toLocal();
//
//   // Format 24-hour time (Swedish style)
//   String formatTime(DateTime t) {
//     final hour = t.hour.toString().padLeft(2, '0');
//     final minute = t.minute.toString().padLeft(2, '0');
//     return "$hour:$minute"; // e.g. 21:15
//   }
//
//   // Check if same day
//   bool isToday = now.day == localTime.day &&
//       now.month == localTime.month &&
//       now.year == localTime.year;
//
//   // Check if within same week
//   final weekStart = now.subtract(Duration(days: now.weekday - 1)); // Monday
//   final weekEnd = weekStart.add(Duration(days: 6));
//   bool isSameWeek = localTime.isAfter(weekStart) && localTime.isBefore(weekEnd);
//
//   if (isToday) {
//     return formatTime(localTime); // e.g. "10:30"
//   } else if (isSameWeek) {
//     final dayOfWeek = [
//       'Mån', // Monday
//       'Tis',
//       'Ons',
//       'Tor',
//       'Fre',
//       'Lör',
//       'Sön'
//     ][localTime.weekday - 1];
//     return "$dayOfWeek ${formatTime(localTime)}"; // e.g. "Ons 11:45"
//   } else {
//     return "${localTime.day} ${[
//       'Jan','Feb','Mar','Apr','Maj','Jun','Jul','Aug','Sep','Okt','Nov','Dec'
//     ][localTime.month - 1]} ${formatTime(localTime)}"; // e.g. "12 Okt 10:30"
//   }
// }
