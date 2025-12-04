import 'package:flutter/material.dart';
import 'package:intl/intl.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/core/constants/app_dialogs.dart';
import 'package:frenly_app/core/constants/my_colour.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/Blog/blog_view/blog_view_screen.dart';
import 'package:get/get.dart';
import '../../Vlog/vlog_full_view/vlog_view_screen.dart';
import '../../post/post_view/post_view_screen.dart';
import '../Pages/chat_room/chat_room_model.dart';

// class OwnMessageCard extends StatelessWidget {
//   const OwnMessageCard({Key? key, required this.message, required this.createdAt}) : super(key: key);
//   final SingleMessage message;
//   final DateTime createdAt;
//
//   @override
//   Widget build(BuildContext context) {
//     DateTime time = DateTime.now().toUtc();
//     print("$time");
//
//     //Convert local date time to string format local date time
//     return Align(
//       alignment: Alignment.centerRight,
//       child: ConstrainedBox(
//         constraints: BoxConstraints(
//           maxWidth: MediaQuery.of(context).size.width - 45,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             SizedBox(
//               child: Container(
//                 margin: EdgeInsets.only(right: 10),
//                 padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 8.v),
//                 decoration: BoxDecoration(
//                   color: Color(0xffEDEDED),
//                   borderRadius: BorderRadius.only(
//                     bottomRight: Radius.circular(15.adaptSize),
//                     bottomLeft: Radius.circular(15.adaptSize),
//                     topLeft: Radius.circular(15.adaptSize),
//                     // topRight: Radius.circular(15.adaptSize),
//                   ),
//                 ),
//                 child: InkWell(
//                   onTap: () async {
//                     if(message.isLink==3){
//                       if(message.isLinkId!=null){
//                         Get.to(()=>VlogViewScreen(
//                             videoUrl: "${message.isUrl}",
//                             vlogId: "${message.isLinkId}"));
//                       }else{
//                         AppDialog.taostMessage("Vlog not Found");
//                       }
//                     }
//
//                     if(message.isLink==2){
//                       if(message.isLinkId!=null){
//                         Get.to(()=>BlogViewScreen( id: '${message.isLinkId}',));
//                       }else{
//                         AppDialog.taostMessage("Blog not Found");
//                       }
//                     }
//                     if(message.isLink==1){
//                       if(message.isLinkId!=null){
//                         Get.to(()=> PostViewScreen(id:"${message.isLinkId}",));
//                       }else{
//                         AppDialog.taostMessage("Photo not Found");
//                       }
//                     }
//                   },
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       message.isLink== 0 ? const SizedBox() : Padding(
//                         padding: const EdgeInsets.only(right: 8.0),
//                         child: CustomImageView(imagePath: "assets/image/share_in_msg_icon.svg",color: Colors.red,height: 20,),
//                       ),
//                       ConstrainedBox(
//                           constraints: BoxConstraints(
//                             maxWidth: MediaQuery.of(context).size.width*.70,
//                           ),
//                           child: Text("${message.content?.tr}",
//                               style: TextStyle(color:message.isLink== 0 ? Colors.black : MyColor.primaryColor,
//                               fontWeight:message.isLink== 0 ? FontWeight.normal : FontWeight.bold))
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//             SizedBox(height: 3.v),
//             Opacity(
//               opacity: 0.5,
//               child: Padding(
//                 padding: EdgeInsets.only(right: 10.h),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//
//                     // ⏰ Always show created time
//                     Text(
//                       DateFormat('hh:mm a').format(createdAt.toLocal()),
//                       style: TextStyle(fontSize: 12.adaptSize),
//                     ),
//
//                     SizedBox(width: 6),
//
//                     // 👁 Show Sent / Seen WITHOUT timing
//                     Text(
//                       message.isRead == true ? "seen".tr : "sent".tr,
//                       style: TextStyle(fontSize: 12.adaptSize),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 10.v),
//
//           ],
//         ),
//       ),
//     );
//   }
// }


class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({
    Key? key,
    required this.message,
    required this.createdAt,
  }) : super(key: key);

  final SingleMessage message;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
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
                  ),
                ),
                child: InkWell(
                  onTap: () async {
                    if (message.isLink == 3) {
                      if (message.isLinkId != null) {
                        Get.to(() => VlogViewScreen(
                          videoUrl: "${message.isUrl}",
                          vlogId: "${message.isLinkId}",
                        ));
                      } else {
                        AppDialog.taostMessage("Vlog not Found");
                      }
                    }

                    if (message.isLink == 2) {
                      if (message.isLinkId != null) {
                        Get.to(() => BlogViewScreen(id: '${message.isLinkId}'));
                      } else {
                        AppDialog.taostMessage("Blog not Found");
                      }
                    }

                    if (message.isLink == 1) {
                      if (message.isLinkId != null) {
                        Get.to(() => PostViewScreen(id: "${message.isLinkId}"));
                      } else {
                        AppDialog.taostMessage("Photo not Found");
                      }
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      message.isLink == 0
                          ? const SizedBox()
                          : Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomImageView(
                          imagePath: "assets/image/share_in_msg_icon.svg",
                          color: Colors.red,
                          height: 20,
                        ),
                      ),

                      /// MESSAGE TEXT
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth:
                          MediaQuery.of(context).size.width * 0.70,
                        ),
                        child: buildMessageContent(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 3.v),
            /// TIME + SEEN/SENT
            Opacity(
              opacity: 0.5,
              child: Padding(
                padding: EdgeInsets.only(right: 10.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    /// SENT / SEEN
                    Text(message.isRead == true
                          ? "seen".tr
                          : "sent".tr,
                      style: TextStyle(fontSize: 12.adaptSize),
                    ),

                    SizedBox(width: 3.aw),

                    /// Swedish formatted time
                    Text( formatMessageTime(createdAt),
                      style: TextStyle(fontSize: 12.adaptSize),
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 10.v),
          ],
        ),
      ),
    );
  }

  Widget buildMessageContent(BuildContext context) {
    // If media exists
    if (message.attachmentUrl != null && message.attachmentUrl!.isNotEmpty) {
      final url = message.attachmentUrl!;
      final type = message.attachmentType ?? "";
      final mime = message.mimeType ?? "";

      // --- FIX 1: Detect images even if backend returns 'file'
      if (type == "image" ||
          type == "gif" ||
          mime.startsWith("image") ||
          isImageFile(url)) {
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

      // --- FIX 2: Video thumbnail
      if (mime.startsWith("video")) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black12,
            image: message.thumbnailUrl != null
                ? DecorationImage(
              image: NetworkImage(message.thumbnailUrl!),
              fit: BoxFit.cover,
            ) : null,
          ),
          child: Icon(Icons.play_circle_fill, size: 60, color: Colors.white),
        );
      }

      // --- FIX 3: Audio
      if (mime.startsWith("audio")) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.audiotrack, color: Colors.black87),
            SizedBox(width: 8),
            Text("Audio message"),
          ],
        );
      }

      // --- FIX 4: Unknown file type (PDF, Docs, etc.)
      return Row(
        children: [
          Icon(Icons.insert_drive_file, color: Colors.grey),
          SizedBox(width: 8),
          Expanded(child: Text("File")),
        ],
      );
    }

    // Default text message
    return Text("${message.content}",
      style: TextStyle(
        color: message.isLink == 0 ? Colors.black : MyColor.primaryColor,
        fontWeight: message.isLink == 0 ? FontWeight.normal : FontWeight.bold,
      ),
    );
  }

  bool isImageFile(String url) {
    return url.toLowerCase().endsWith(".jpg") ||
        url.toLowerCase().endsWith(".jpeg") ||
        url.toLowerCase().endsWith(".png") ||
        url.toLowerCase().endsWith(".gif");
  }
}

String formatMessageTime(DateTime dateTime) {
  final now = DateTime.now();
  final local = dateTime.toLocal();

  String lang = Get.locale?.languageCode ?? "en";

  String formatTime(DateTime t) =>
      "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";

  final diff = now.difference(local);

  // LANGUAGE-SPECIFIC STRINGS
  String minsAgo(int m) =>
      lang == "swe" || lang == "sv" ? "$m min sedan" : "$m min ago";

  String hoursAgo(int h) =>
      lang == "swe" || lang == "sv" ? "$h timmar sedan" : "$h hours ago";

  String justNow =
  lang == "swe" || lang == "sv" ? "nyss" : "just now";

  String yesterdayWord =
  lang == "swe" || lang == "sv" ? "Igår" : "Yesterday";

  // WEEKDAY names based on language
  final weekdays = lang == "swe" || lang == "sv"
      ? ['Mån', 'Tis', 'Ons', 'Tor', 'Fre', 'Lör', 'Sön']
      : ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  // MONTH names based on language
  final months = lang == "swe" || lang == "sv"
      ? ['Jan','Feb','Mar','Apr','Maj','Jun','Jul','Aug','Sep','Okt','Nov','Dec']
      : ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

  bool isToday = now.year == local.year &&
      now.month == local.month &&
      now.day == local.day;

  bool isYesterday = now.subtract(Duration(days: 1)).day == local.day &&
      now.month == local.month &&
      now.year == local.year;

  // FIXED week range (inclusive)
  DateTime weekStart = now.subtract(Duration(days: now.weekday - 1)); // Monday
  DateTime weekEnd = weekStart.add(Duration(days: 6)); // Sunday
  bool isThisWeek = !local.isBefore(weekStart) && !local.isAfter(weekEnd);

  // --- TODAY → show "ago" text ---
  if (isToday) {
    if (diff.inMinutes < 1) return justNow;
    if (diff.inMinutes < 60) return minsAgo(diff.inMinutes);
    if (diff.inHours < 24) return hoursAgo(diff.inHours);
    return formatTime(local);
  }

  if (isYesterday) {
    return "$yesterdayWord ${formatTime(local)}";
  }

  if (isThisWeek) {
    return "${weekdays[local.weekday - 1]} ${formatTime(local)}";
  }

  return "${local.day} ${months[local.month - 1]} ${formatTime(local)}";
}


/*String formatSeenTime(DateTime seenTime) {
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

String formatMessageTime(DateTime dateTime) {
  final now = DateTime.now();
  final localTime = dateTime.toLocal();

  // Format 24-hour time (Swedish style)
  String formatTime(DateTime t) {
    final hour = t.hour.toString().padLeft(2, '0');
    final minute = t.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  bool isToday = now.day == localTime.day &&
      now.month == localTime.month &&
      now.year == localTime.year;

  final weekStart = now.subtract(Duration(days: now.weekday - 1)); // Monday
  final weekEnd = weekStart.add(Duration(days: 6));
  bool isSameWeek =
      localTime.isAfter(weekStart) && localTime.isBefore(weekEnd);

  if (isToday) {
    return formatTime(localTime); // "10:30"
  } else if (isSameWeek) {
    final dayOfWeek = [
      'Mån',
      'Tis',
      'Ons',
      'Tor',
      'Fre',
      'Lör',
      'Sön'
    ][localTime.weekday - 1];
    return "$dayOfWeek ${formatTime(localTime)}"; // "Ons 11:45"
  } else {
    return "${localTime.day} ${[
      'Jan','Feb','Mar','Apr','Maj','Jun','Jul','Aug','Sep','Okt','Nov','Dec'
    ][localTime.month - 1]} ${formatTime(localTime)}"; // "12 Okt 10:30"
  }
}*/


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

/*
the .tr value  2 min ago 3 hour ago like gets translated immediately and then saved as plain text (for example in your backend database).

Changing app language later won’t change existing stored messages, because the string "Send a post of Camilla" is no longer linked to .tr.
It’s just a regular message now.

💬 Example Analogy

Imagine WhatsApp messages:
If you change phone language after sending a message, your old chats don’t change to the new language — because they are saved text, not translatable templates.

Same thing here.*/
