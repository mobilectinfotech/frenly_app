import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:frenly_app/core/constants/my_colour.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:just_audio/just_audio.dart';
import 'package:frenly_app/Widgets/custom_image_view.dart';
import 'package:frenly_app/core/constants/app_dialogs.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/presentation/Blog/blog_view/blog_view_screen.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../Vlog/vlog_full_view/vlog_view_screen.dart';
import '../../post/post_view/post_view_screen.dart';
import '../Pages/chat_room/chat_room_model.dart';
import 'dart:typed_data';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:http/http.dart' as http;


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
                margin: EdgeInsets.only(right: 10.aw),
                padding: EdgeInsets.symmetric(horizontal: 10.aw, vertical: 8.ah),
                decoration: BoxDecoration(
               //   color: Color(0xffEDEDED),
                  color:Colors.black12.withOpacity(0.10),
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
                        padding: EdgeInsets.only(right: 8.0.aw),
                        child: CustomImageView(
                          imagePath: "assets/image/share_in_msg_icon.svg",
                          color: Colors.red,
                          height: 20.ah,
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

            SizedBox(height: 3.ah),
            /// TIME + SEEN/SENT
            Opacity(
              opacity: 0.5,
              child: Padding(
                padding: EdgeInsets.only(right: 10.aw),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    /// SENT / SEEN
                    // Text(message.isRead == true
                    //       ? "seen".tr
                    //       : "sent".tr,
                    //   style: TextStyle(fontSize: 12.adaptSize),
                    // ),

                    Text((message.seen == true || message.isRead == true)
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
            SizedBox(height: 10.ah),
          ],
        ),
      ),
    );
  }

  Future<String> _getVideoDuration(String url) async {
    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    await controller.initialize();
    final duration = controller.value.duration;
    controller.dispose();

    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return "$minutes:$seconds";
  }


  String formatDuration(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  Future<Uint8List?> _generateThumb(String url) async {
    try {
      final bytes = await VideoThumbnail.thumbnailData(
        video: url,
        headers: {}, // IMPORTANT for network video
        imageFormat: ImageFormat.JPEG,
        maxWidth: 600,
        quality: 75,
      );
      return bytes;
    } catch (e) {
      print("Thumbnail error: $e");
      return null;
    }
  }



/*
  Widget buildMessageContent(BuildContext context) {
    final url = message.attachmentUrl ?? "";
    final mime = message.mimeType ?? "";
    final type = message.attachmentType ?? "";

    if (url.isNotEmpty) {

      // ---------- IMAGE ----------
      if (mime.startsWith("image") ||
          type == "image" ||
          type == "gif" ||
          isImageFile(url)) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: InstaImageViewer(
            child: Image.network(
              url,
              width: MediaQuery.of(context).size.width * 0.6,
              height: 220.ah,
              fit: BoxFit.cover,
            ),
          ),
        );
      }

      // ---------- VIDEO ----------
      if (mime.startsWith("video") || url.endsWith(".mp4") || url.endsWith(".mov")) {
        return InkWell(
          onTap: () {
            Get.to(() => VideoPlayerScreen(url: message.attachmentUrl!));
            print("VIDEO URL => ${message.attachmentUrl}");
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black12,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.play_circle_fill, size: 60, color: Colors.white),
              ],
            ),
          ),
        );
      }


      // ---------- AUDIO (WhatsApp style) ----------
      if (mime.startsWith("audio") ||
          url.endsWith(".aac") ||
          url.endsWith(".m4a") ||
          url.endsWith(".mp3") ||
          url.endsWith(".wav") ||
          url.endsWith(".ogg") ||
          type == "audio") {

        return AudioMessagePlayer(url: url);
      }


      // ---------- UNKNOWN FILE ----------
      return Container(
        padding: EdgeInsets.all(10.adaptSize),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12.adaptSize),
        ),
        child: Row(
          children: [
            Icon(Icons.insert_drive_file),
            SizedBox(width: 8.aw),
            Text("file".tr),
          ],
        ),
      );
    }

    // ---------- NORMAL TEXT ----------
    return Text(
      message.content ?? "",
      style: TextStyle(fontSize: 16.fSize, color: Colors.black87),
    );
  }
*/

  Widget buildMessageContent(BuildContext context) {
    final url = message.attachmentUrl ?? "";
    final mime = message.mimeType ?? "";
    final type = message.attachmentType ?? "";

    // ⭐ 1) UPLOAD IN PROGRESS UI
    if (message.isUploading == true) {
      final p = (message.uploadProgress ?? 0);
      final percent = (p * 100).clamp(0, 100).toStringAsFixed(0);

      return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: 180.ah,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12.adaptSize),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  value: p == 0 ? null : p, // null = indeterminate start, then %
                  strokeWidth: 3.aw,
                  color: MyColor.primaryColor,
                ),
                SizedBox(height: 12.ah),
                Text("${"uploading".tr} $percent%",
                  style: TextStyle(
                    fontSize: 14.fSize,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    // ⭐ 2) NORMAL FILE HANDLING (your existing code)
    if (url.isNotEmpty) {
      // IMAGE
      if (mime.startsWith("image") ||
          type == "image" ||
          type == "gif" ||
          isImageFile(url)) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12.adaptSize),
          child: InstaImageViewer(
            child: Image.network(
              url,
              width: MediaQuery.of(context).size.width * 0.6,
              height: 220.ah,
              fit: BoxFit.cover,
            ),
          ),
        );
      }

      // ---------- VIDEO ----------
      /*
      if (mime.startsWith("video") || url.endsWith(".mp4") || url.endsWith(".mov")) {
        return FutureBuilder(
          future: _getVideoDuration(url),
          builder: (context, snapshot) {
            final durationText = snapshot.data ?? "";

            return InkWell(
              onTap: () {
                Get.to(() => VideoPlayerScreen(url: message.attachmentUrl!));
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black12,
                    ),
                  ),

                  Icon(Icons.play_circle_fill, size: 60.adaptSize, color: Colors.white),
                  Positioned(
                    bottom: 10.adaptSize,
                    right: 10.adaptSize,
                    child: Text(
                      durationText,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
*/


// VIDEO
      if (mime.startsWith("video") || url.endsWith(".mp4") || url.endsWith(".mov")) {
        return FutureBuilder<Uint8List?>(
          future: _generateThumb(url),
          builder: (context, snap) {
            final bytes = snap.data;

            return InkWell(
              onTap: () => Get.to(() => VideoPlayerScreen(url: url)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.adaptSize),
                    child: bytes != null
                        ? Image.memory(bytes,
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 200.adaptSize,
                      fit: BoxFit.cover,
                    )
                        : Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 200.adaptSize,
                      color: Colors.black26,
                    ),
                  ),

                  Icon(Icons.play_circle_fill, size: 60.fSize, color: Colors.white),

                  if (message.durationSeconds != null)
                    Positioned(
                      right: 10.adaptSize,
                      bottom: 10.adaptSize,
                      child: Text(
                        formatDuration(message.durationSeconds!),
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      }

      // AUDIO
      // if (mime.startsWith("audio") ||
      //     url.endsWith(".aac") ||
      //     url.endsWith(".m4a") ||
      //     url.endsWith(".mp3") ||
      //     url.endsWith(".wav") ||
      //     url.endsWith(".ogg") ||
      //     type == "audio") {
      //   return AudioMessagePlayer(message: message);
      // }

      // In buildMessageContent(), audio if-block:
      if (mime.startsWith("audio") ||  // Now correctly "audio/mp4"
          url.toLowerCase().endsWith(".m4a") ||  // 🔥 ADDED: For new extension
          url.toLowerCase().endsWith(".aac") ||  // Legacy support
          url.toLowerCase().endsWith(".mp3") ||
          url.toLowerCase().endsWith(".wav") ||
          url.toLowerCase().endsWith(".ogg") ||
          type == "audio") {
        return AudioMessagePlayer(message: message);
      }

      // UNKNOWN FILE
      return Container(
        padding: EdgeInsets.all(10.adaptSize),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12.adaptSize),
        ),
        child: Row(
          children: [
            const Icon(Icons.insert_drive_file),
            SizedBox(width: 8.aw),
            Text("file".tr),
          ],
        ),
      );
    }

    // TEXT MESSAGE (no attachment)
    return Text(message.content ?? "",
      style: TextStyle(fontSize: 16.fSize, color: Colors.black87),
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

  String formatTime(DateTime t) => "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";

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


class AudioMessagePlayer extends StatefulWidget {
 // final String url;
  final SingleMessage message;

  const AudioMessagePlayer({Key? key, required this.message}) : super(key: key);

  @override
  _AudioMessagePlayerState createState() => _AudioMessagePlayerState();
}

class _AudioMessagePlayerState extends State<AudioMessagePlayer> {
  late final AudioPlayer _player;
  bool isPlaying = false;
  Duration totalDuration = Duration.zero;
  Duration currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    // ⭐ USE BACKEND DURATION FIRST
    if (widget.message.durationSeconds != null) {
      totalDuration = Duration(seconds: widget.message.durationSeconds!);
    }

    _init();
  }

/*
  Future<void> _init() async {
    // set the source but don't autoplay
    try {
    //  await _player.setUrl(widget.message.toString());
      await _player.setUrl(widget.message.attachmentUrl!);
    } catch (e) {
      // handle load error if needed
      debugPrint("Audio load error: $e");
    }

    // duration
    _player.durationStream.listen((d) {
      if (widget.message.durationSeconds != null) return; // 🔥 ignore metadata
      if (d != null) {
        setState(() => totalDuration = d);
      }
    });

    // position
    _player.positionStream.listen((p) {
      setState(() => currentPosition = p);
    });

    // playing state -> update icon automatically
    _player.playingStream.listen((playing) {
      setState(() => isPlaying = playing);
    });

    // handle completion
    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        // reset to start and update UI
        _player.seek(Duration.zero);
        _player.pause();
        setState(() {
          currentPosition = Duration.zero;
          isPlaying = false;
        });
        // if this player was the active one, clear it
        AudioManager.clearIfActive(_player);
      }
    });
  }
*/

  // In _AudioMessagePlayerState._init():
  Future<void> _init() async {
    final url = widget.message.attachmentUrl!;
    print("🔍 CHECKING AUDIO URL → $url");

    // Optional: Debug S3 headers (add import above)
    try {
      final response = await http.head(Uri.parse(url));
      print("🔍 S3 HEADERS → ${response.headers}");
    } catch (_) {
      // Ignore in release
    }

    try {
      await _player.setUrl(url);
    } catch (e) {
      // 🔥 ADDED: Handle release decoding errors
      print("❌ Audio load error on init: $e");
      if (mounted) {
        setState(() {
          totalDuration = Duration.zero;  // Fallback
        });
      }
      return;  // Skip listeners if load fails
    }

    // Duration listener (prioritize backend, unchanged)
    _player.durationStream.listen((d) {
      if (!mounted) return;
      if (d == null) return;
      if (widget.message.durationSeconds != null) return;
      if (mounted) setState(() => totalDuration = d);
    });

    // Position, playing, completion listeners (unchanged)
    _player.positionStream.listen((p) {
      if (mounted) setState(() => currentPosition = p);
    });

    _player.playingStream.listen((playing) {
      if (mounted) setState(() => isPlaying = playing);
    });

    _player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _player.seek(Duration.zero);
        _player.pause();
        if (mounted) {
          setState(() {
            currentPosition = Duration.zero;
            isPlaying = false;
          });
        }
        AudioManager.clearIfActive(_player);
      }
    });
  }

  // Future<void> _init() async {
  //   final url = widget.message.attachmentUrl!;
  //   print("🔍 CHECKING AUDIO URL → $url");
  //
  //   // print S3 headers (optional debugging)
  //   try {
  //     final response = await http.head(Uri.parse(url));
  //     print("🔍 S3 HEADERS → ${response.headers}");
  //   } catch (_) {}
  //
  //   // ⭐ DO NOT block audio if MIME is octet-stream
  //   // JUST load the file and let player decide
  //   try {
  //     await _player.setUrl(url);
  //   } catch (e) {
  //     print("❌ Audio load error on init: $e");
  //   }
  //
  //   // Duration listener
  //   _player.durationStream.listen((d) {
  //     if (!mounted) return;
  //     if (d == null) return;
  //     if (widget.message.durationSeconds != null) return;
  //     setState(() => totalDuration = d);
  //   });
  //
  //
  //   // Position listener
  //   _player.positionStream.listen((p) {
  //     setState(() => currentPosition = p);
  //   });
  //
  //   // Playing listener
  //   _player.playingStream.listen((playing) {
  //     setState(() => isPlaying = playing);
  //   });
  //
  //   // Completion listener
  //   _player.playerStateStream.listen((state) {
  //     if (state.processingState == ProcessingState.completed) {
  //       _player.seek(Duration.zero);
  //       _player.pause();
  //       setState(() {
  //         currentPosition = Duration.zero;
  //         isPlaying = false;
  //       });
  //       AudioManager.clearIfActive(_player);
  //     }
  //   });
  // }

  @override
  void dispose() {
    // stop & clear active reference if this player is active
    AudioManager.clearIfActive(_player);
    _player.stop();
    _player.dispose();
    super.dispose();
  }

  // Future<void> _togglePlayPause() async {
  //   print("AUDIO URL → ${widget.message.attachmentUrl}");
  //   if (isPlaying) {
  //     await _player.pause();
  //     return;
  //   }
  //
  //   // If not playing -> make this the active player (stops any other active player)
  //   await AudioManager.setActive(_player, widget.message.attachmentUrl!);
  //
  //   // ensure the audio is ready
  //   if (_player.playerState.processingState == ProcessingState.idle) {
  //     // attempt to set url again
  //     try {
  //    //   await _player.setUrl(widget.message.toString());
  //       await _player.setUrl(widget.message.attachmentUrl!);
  //
  //     } catch (e) {
  //       debugPrint("Audio load error on play: $e");
  //       return;
  //     }
  //   }
  //
  //   // finally play
  //   await _player.play();
  // }




  Future<void> _togglePlayPause() async {
    final url = widget.message.attachmentUrl!;
    print("🎧 PLAY URL → $url");
    print("FINAL URL LOADED → $url");

    if (isPlaying) {
      await _player.pause();
      return;
    }

    await AudioManager.setActive(_player, url);

    if (_player.playerState.processingState == ProcessingState.idle) {
      try {
        await _player.setUrl(url);
      } catch (e) {
        print("❌ Audio load error: $e");
        return;
      }
    }

    await _player.play();
  }


/*
  Future<void> _togglePlayPause() async {
    print("AUDIO URL → ${widget.message.attachmentUrl}");
    print("MIME FROM API → ${widget.message.mimeType}");

    if (isPlaying) {
      await _player.pause();
      return;
    }

    await AudioManager.setActive(_player, widget.message.attachmentUrl!);

    if (_player.playerState.processingState == ProcessingState.idle) {
      try {
      //  await _player.setUrl(widget.message.attachmentUrl!);
        if (widget.message.mimeType == "application/octet-stream") {
          print("❌ THIS AUDIO FILE IS CORRUPTED. CAN'T PLAY.");
          return;
        }

      } catch (e) {
        debugPrint("Audio load error on play: $e");
        return;
      }
    }

    await _player.play();
  }
*/

  String _format(Duration d) {
    final mm = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final ss = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$mm:$ss";
  }

  @override
  Widget build(BuildContext context) {
  //  final max = totalDuration.inMilliseconds.toDouble().clamp(1.0, double.infinity);
    final backendDuration = widget.message.durationSeconds;
    final displayEnd = backendDuration != null
        ? _format(Duration(seconds: backendDuration))
        : _format(totalDuration);

    // final max = totalDuration.inMilliseconds.toDouble();
    final max = totalDuration.inMilliseconds > 0
        ? totalDuration.inMilliseconds.toDouble()
        : 1.0;


    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.aw, vertical: 20.ah),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.adaptSize),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// play/pause
          InkWell(
            onTap: _togglePlayPause,
            child: Icon(
              isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
              size: 30.fSize,
              color: Colors.pinkAccent,
            ),
          ),

          SizedBox(width: 10.aw),
          /// slider and times
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.aw,top: 2.ah),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Slider(
                    activeColor: Colors.pinkAccent,
                    inactiveColor: Colors.grey.shade300,
                    padding: EdgeInsets.zero,
                    min: 0,
                    max: max,
                    value: currentPosition.inMilliseconds
                        .clamp(0, totalDuration.inMilliseconds).toDouble(),
                    onChanged: (value) {
                      final newPos = Duration(milliseconds: value.toInt());
                      _player.seek(newPos);
                    },
                  ),
                  SizedBox(height: 5.ah),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_format(currentPosition), style: TextStyle(fontSize: 12.fSize)),
                      Text(displayEnd, style: TextStyle(fontSize: 12.fSize)),
                    ],
                  )
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }
}


/// GLOBAL AUDIO MANAGER — ensures ONLY ONE audio plays at a time
class AudioManager {
  static AudioPlayer? _activePlayer;

  /// Stop any currently active player before starting a new one
  static Future<void> setActive(AudioPlayer player, String url) async {
    if (_activePlayer != null && _activePlayer != player) {
      try {
        await _activePlayer!.stop();
        await _activePlayer!.seek(Duration.zero);
      } catch (_) {}
    }
    _activePlayer = player;
  }

  /// Clear active player (when disposed or completed)
  static void clearIfActive(AudioPlayer player) {
    if (_activePlayer == player) {
      _activePlayer = null;
    }
  }

  /// Stop all players globally
  static Future<void> stopAll() async {
    if (_activePlayer != null) {
      try {
        await _activePlayer!.stop();
        await _activePlayer!.seek(Duration.zero);
      } catch (_) {}
      _activePlayer = null;
    }
  }
}


class VideoPlayerScreen extends StatefulWidget {
  final String url;

  const VideoPlayerScreen({super.key, required this.url});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _showPlayButton = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
      ..initialize().then((_) {
        setState(() => _initialized = true);
      });

    _controller.addListener(() {
      // hide play icon when video is playing
      if (_controller.value.isPlaying && _showPlayButton) {
        setState(() => _showPlayButton = false);
      }
    });

    _controller.addListener(() {
      if (mounted) setState(() {});
    });

  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      setState(() => _showPlayButton = true);
    } else {
      _controller.play();
      setState(() => _showPlayButton = false);
    }
  }

  String get videoDuration {
    if (!_initialized) return "";
    final d = _controller.value.duration;
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  String get currentPosition {
    if (!_initialized) return "";
    final p = _controller.value.position;
    final minutes = p.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = p.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Center(
        child: !_initialized
            ? const CircularProgressIndicator(color: Colors.white)
            : GestureDetector(
          onTap: () {
            setState(() {
              _showPlayButton = !_showPlayButton;
            });
          },

          child: Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),

              /// Play / Pause overlay button
              if (_showPlayButton || !_controller.value.isPlaying)
                GestureDetector(
                  onTap: _togglePlayPause,
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_fill,
                    size: 90.adaptSize,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),

                Positioned(
                bottom: 30.adaptSize,
               // right: 20.adaptSize,
                child: Container(
                  width:Get.width,
                  decoration: BoxDecoration(
                   // borderRadius: BorderRadius.circular(30.adaptSize),
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text("${currentPosition} / ${videoDuration}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}




/*
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
