import 'dart:async';
import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/core/constants/my_colour.dart';
import 'package:frenly_app/core/utils/pref_utils.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/data/data_sources/remote/api_client.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/data/models/LastSeenModel.dart';
import 'package:frenly_app/socket_service/socket_service.dart';
import 'package:frenly_app/presentation/chat/Pages/chat_room/chat_room_controller.dart';
import 'package:frenly_app/presentation/chat/Pages/chat_room/chat_room_model.dart';
import 'package:frenly_app/presentation/chat/Pages/chats/chats_model.dart';
import '../../CustomUI/OwnMessgaeCrad.dart';
import '../../CustomUI/ReplyCard.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';
import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';   // <-- ADD THIS IMPORT
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

/*
enum MessageType { text, image, video, audio, gif }
*/

class ChatRoomPage extends StatefulWidget {
//  final String userId;
  const ChatRoomPage({
    Key? key,
    required this.participant,
    required this.chatId,
    //required this.userId,
  }) : super(key: key);

  final Participant participant;
  final String chatId;

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final ChatRoomController controller = Get.put(ChatRoomController(), permanent: true);

  final FocusNode focusNode = FocusNode();
  final TextEditingController _messageController = TextEditingController();
  String lastSeenUser = '';
  bool show = false;
  bool sendButton = false;
  LastSeenModel? lastSeenModel;

// 1. Audio recorder (created once)
/*
  late final FlutterSoundRecorder _audioRecorder;
*/

// 2. Recording flag
/*
  bool _isRecording = false;
*/

  @override
  void initState() {
    super.initState();
    _initializeChat();
    focusNode.addListener(_handleFocusChange);
  }

  void _initializeChat() {
    SocketService().activeChatId.value = int.parse(widget.chatId);
    controller.getAllMsg(chatId: widget.chatId);
    _getLastSeen();
  }

  Future<void> _getLastSeen() async {
    try {
      lastSeenModel = await ApiRepository.lastSeen(id: widget.participant.id.toString());

      if (lastSeenModel?.data?.isLastSeenAllowed == false) {
      //  lastSeenUser = "lastSeenHide";
        lastSeenUser = "lastSeenHide".tr;
      } else if (lastSeenModel?.data?.lastSeen == null) {
      //  lastSeenUser = "online";
        lastSeenUser = "online".tr;
      } else {
        lastSeenUser = timeago.format(lastSeenModel!.data!.lastSeen!.toLocal());
      }
      setState(() {});
    } catch (e) {
      print("Error fetching last seen: $e");
    }
  }

  // Future<void> _getLastSeen() async {
  //   try {
  //     lastSeenModel = await ApiRepository.lastSeen(
  //       id: widget.participant.id.toString(),
  //     );
  //     if (lastSeenModel?.data?.isLastSeenAllowed == false) {
  //       // User has hidden last seen
  //       lastSeenUser = "lastSeenHide".tr;
  //     } else if (lastSeenModel?.data?.lastSeen == null) {
  //       // User is currently online
  //       lastSeenUser = "online".tr;
  //     } else {
  //       // User has a last seen timestamp
  //       final seenTime = lastSeenModel!.data!.lastSeen!.toLocal();
  //       lastSeenUser = formatLastSeenn(seenTime);
  //     }
  //     setState(() {});
  //   }
  //   catch (e) {
  //     print("Error fetching last seen: $e");
  //   }
  // }


  void _handleFocusChange() {
    if (focusNode.hasFocus) {
      setState(() {
        show = false;
      });
    }
  }

  String formatTimestamp(DateTime timestamp) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(timestamp);

    if (difference.inDays == 0) {
      return 'today'.tr;
    } else if (difference.inDays == 1) {
      return 'yesterday'.tr;
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${"days_ago".tr}';
    } else {
      return DateFormat('d MMMM').format(timestamp);
    }
  }

  @override
  void dispose() {
    focusNode.removeListener(_handleFocusChange);
    _messageController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => controller.isLoading.value
            ? const Center(
          child: CircularProgressIndicator(strokeWidth: 1),
        ) : SafeArea(
          child: Scaffold(
            appBar: _buildCustomAppBar(context),
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Expanded(
                  child: _buildMessageList(),
                ),
                _buildMessageInput(),

               //  SizedBox(height: 30.ah),
               // _buildMessageInputt(),
               //  SizedBox(height: 10.ah),

              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildCustomAppBar(BuildContext context) {
    print("widget.participant.coverPhotoUrl${widget.participant.coverPhotoUrl}");
    return customAppbarForChat(
      userId:widget.participant.id.toString(),
      context: context,
      handle: lastSeenUser,
      name: widget.participant.fullName?.capitalizeFirst,
      imagepath: widget.participant.avatarUrl,
    );
  }

  Widget _buildMessageList() {
    return Obx(() => ListView.builder(
        reverse: true,
        itemCount: controller.allMsg.messages?.length ?? 0,
        itemBuilder: (context, index) {
          final message = controller.allMsg.messages![index];
          final isOwnMessage = message.senderId != widget.participant.id;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
             // SizedBox(height: 10.v),
              _buildTimestamp(index),
             SizedBox(height: 10.ah),
              isOwnMessage
                  ? OwnMessageCard(
                message: message,
                createdAt: message.createdAt!.toLocal(),
              ) :
              ReplyCard(
                message: message,
                createdAt: message.createdAt!.toLocal(),
              ),
            ],
          );
        },
      ),
    );
  }


  // Widget _buildMessageList() {
  //   return Obx(() => ListView.builder(
  //     reverse: true,
  //     itemCount: controller.allMessages.length,
  //     itemBuilder: (context, index) {
  //       final message = controller.allMessages[index];
  //       final isOwnMessage = message.senderId != widget.participant.id;
  //
  //       return Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           _buildTimestamp(index),
  //           SizedBox(height: 10.ah),
  //           isOwnMessage
  //               ? OwnMessageCard(
  //             message: message,
  //             createdAt: message.createdAt!.toLocal(),
  //           )
  //               : ReplyCard(
  //             message: message,
  //             createdAt: message.createdAt!.toLocal(),
  //           ),
  //         ],
  //       );
  //     },
  //   ));
  // }


  // Widget _buildMessageList() {
  //   return Obx(() {
  //     if (controller.isLoading.value) {
  //       return const Center(child: CircularProgressIndicator(strokeWidth: 1));
  //     }
  //     return ListView.builder(
  //       reverse: true,
  //       itemCount: controller.allMsg.messages?.length,
  //       itemBuilder: (context, index) {
  //         final message = controller.allMsg[index];
  //         final isOwnMessage = message.senderId != widget.participant.id;
  //
  //         return Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             _buildTimestamp(index),
  //             SizedBox(height: 10.ah),
  //             isOwnMessage
  //                 ? OwnMessageCard(message: message, createdAt: message.createdAt!.toLocal())
  //                 : ReplyCard(message: message, createdAt: message.createdAt!.toLocal()),
  //           ],
  //         );
  //       },
  //     );
  //   });
  // }

/*
  Widget _buildTimestamp(int index) {
    try {
      final currentMessage = controller.allMessages[index];
      final previousMessage = controller.allMessages[index + 1];

      if (formatTimestamp(currentMessage.createdAt!) !=
          formatTimestamp(previousMessage.createdAt!)) {
        return Text(
          formatTimestamp(currentMessage.createdAt!).capitalizeFirst!,
          style: TextStyle(
            fontSize: 15.adaptSize,
            fontWeight: FontWeight.w600,
            fontFamily: "Roboto",
          ),
        );
      }
    } catch (e) {
      return const SizedBox.shrink();
    }
    return const SizedBox.shrink();
  }
*/

  Widget _buildTimestamp(int index) {
    try {
      final currentMessage = controller.allMsg.messages![index];
      final previousMessage = controller.allMsg.messages![index + 1];

      if (formatTimestamp(currentMessage.createdAt!) != formatTimestamp(previousMessage.createdAt!)) {
        return Text(formatTimestamp(currentMessage.createdAt!).capitalizeFirst!,
          style: TextStyle(
            fontSize: 15.adaptSize,
            fontWeight: FontWeight.w600,
            fontFamily: "Roboto",
          ),
        );
      }
    } catch (e) {
      return const SizedBox.shrink();
    }
    return const SizedBox.shrink();
  }

  Widget _buildMessageInput() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.ah),
        child: Row(
          children: [
            SizedBox(width: 10.aw),
            _buildTextInput(),
            const Spacer(),
            _buildSendButton(),
            SizedBox(width: 10.aw),
          ],
        ),
      ),
    );
  }

  Widget _buildTextInput() {
    return Container(
      width: 305.aw,
      child: TextFormField(
        controller: _messageController,
        focusNode: focusNode,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        minLines: 1,
        onChanged: (value) {
          setState(() {
            sendButton = value.isNotEmpty;
          });
        },
        decoration: _inputDecoration(),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      hintText: "Messages".tr,
      hintStyle: TextStyle(
        color: Color(0xFFA8A8A8),
        fontSize: 20.adaptSize,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w500,
      ),
      prefixIconConstraints: BoxConstraints(
        maxHeight: 25.adaptSize,
      ),
      isDense: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 10.aw,
        vertical: 10.ah,
      ),
      fillColor: Colors.transparent,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.adaptSize),
        borderSide: BorderSide(
          color: Colors.black.withOpacity(.50),
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.adaptSize),
        borderSide: BorderSide(
          color: Colors.black.withOpacity(.50),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.adaptSize),
        borderSide: BorderSide(
          color: Colors.black.withOpacity(.50),
          width: 1,
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return CircleAvatar(
      radius: 20.adaptSize,
      backgroundColor: MyColor.primaryColor,
      child: IconButton(
        icon: const Icon(Icons.send, color: Colors.white),
        onPressed: sendButton
            ? () {
          controller.sendMessage(
            message: _messageController.text.trim(),
            chatId: widget.chatId,
          );
          _messageController.clear();
          FocusScope.of(context).unfocus();
          setState(() {
            sendButton = false;
          });
        }
        : null,
      ),
    );
  }
}

extension on MessageModel1 {
  operator [](int other) {}
}



// String formatLastSeenn(DateTime seenTime) {
//   final now = DateTime.now();
//   final difference = now.difference(seenTime);
//
//   if (difference.inMinutes < 1) {
//     return 'online'.tr;
//   } else if (difference.inMinutes < 60) {
//     return '${"Last_seen".tr} ${difference.inMinutes} ${"minute_ago".tr}'; // visades 5 min sedan
//   } else if (difference.inHours < 24) {
//     return '${"Last_seen".tr} ${difference.inHours} ${"hours_ago".tr}'; // visades 2 tim sedan
//   } else if (difference.inDays < 30) {
//     return '${"Last_seen".tr} ${difference.inDays} ${"days_ago".tr}'; // visades 3 dagar sedan
//   } else {
//     final monthsAgo = (difference.inDays / 30).floor();
//     return '${"Last_seen".tr} $monthsAgo ${"month_ago".tr}'; // visades 2 mån sedan
//   }
// }


/*
Widget _buildMessageInputt() {

  final ImagePicker _picker = ImagePicker();
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();

  // -----------------------------------------------------------------
  // 1. The whole pill (Container) – this is the Instagram “bubble”
  // -----------------------------------------------------------------
  return Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 8.ah, horizontal: 12.aw),
      child: Container(
        // Instagram-like pill shape
        decoration: BoxDecoration(
          //  color: const Color(0xFFF5F5F5),               // light-grey background
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30.adaptSize),

          border: Border.all(color: Colors.grey.shade400, width: 0.8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.aw, vertical: 6.ah),

        // -----------------------------------------------------------------
        // 2. Row that holds: Camera | TextField | Mic | Gallery | GIF
        // -----------------------------------------------------------------

        child: Row(
          children: [
            // ------------------- CAMERA (purple button) -------------------
            GestureDetector(
              // onTap: _captureMedia,
              onTap: _showImagePiker,
              child: Container(
                width: 36.adaptSize,
                height: 36.adaptSize,
                decoration: const BoxDecoration(
                  color: Color(0xFF9B59B6),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20.adaptSize,
                ),
              ),
            ),

            SizedBox(width: 8.aw),
            // ------------------- TEXT FIELD (expanded) -------------------

            Expanded(
              child: TextFormField(
                controller: _messageController,
                focusNode: focusNode,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                minLines: 1,
                onChanged: (value) {
                  setState(() => sendButton = value.isNotEmpty);
                },
                style: TextStyle(
                  fontSize: 16.adaptSize,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  // hintText: "Tillfälligt meddelande...".tr,
                  hintText: "Messages".tr,
                  hintStyle: TextStyle(
                    color: const Color(0xFFA8A8A8),
                    //fontSize: 16.adaptSize,
                    fontSize: 20.adaptSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  fillColor: Colors.transparent,
                ),
              ),
            ),

            SizedBox(width: 8.aw),

            // ------------------- RIGHT ICONS (mic, gallery, GIF) -------------------
            //  _iconButton(Icons.mic_none_outlined, _recordAudio),
            _iconButton(Icons.mic_none_outlined, _startVoiceRecording),

            SizedBox(width: 4.aw),
            _iconButton(Icons.photo_library_outlined, _pickFromGallery),

            SizedBox(width: 4.aw),
            _iconButton(Icons.gif_box_outlined, _pickGif),

            SizedBox(width: 8.aw),
            // ------------------- SEND BUTTON (outside the pill) -------------------
            _buildSendButton(),
          ],
        ),
      ),
    ),
  );
}

Future<CroppedFile?> imagePicker(
    {required ImageSource source, CropAspectRatio? cropAspectRatio}) async {
  final ImagePicker _picker = ImagePicker();
  CroppedFile? _croppedFile;
  final XFile? pickedFile = await _picker.pickImage(source: source);
  _croppedFile = await ImageCropper().cropImage(
    compressQuality: 50,
    sourcePath: pickedFile!.path,
    aspectRatio:
    cropAspectRatio ?? const CropAspectRatio(ratioX: 200, ratioY: 200),
    maxWidth: 600,
    maxHeight: 600,
  );
  if (_croppedFile != null) {
    setState(() {});
  }
  return _croppedFile;
}

void _showImagePiker() {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            color: Colors.white,
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: Text('gallery'.tr),
                    onTap: () async {
                      controller.coverPhoto = await imagePicker(
                        source: ImageSource.gallery,
                      );
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.video_camera_back_rounded),
                  title: Text('camera'.tr),
                  onTap: () async {
                    controller.coverPhoto = await imagePicker(
                      source: ImageSource.camera,
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      });
}


// Helper for the three right-side icons (keeps code DRY)
Widget _iconButton(IconData icon, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(20.adaptSize),
    child: Container(
      padding: EdgeInsets.all(6.adaptSize),
      child: Icon(icon, size: 24.adaptSize, color: Colors.black54),
    ),
  );
}

Future<void> _captureMedia() async {
  // final XFile? file = await _picker.pickImage(source: ImageSource.camera);  // Or pickVideo for video
  // if (file != null) {
  //   controller.sendMedia(chatId: widget.chatId, filePath: file.path, type: MessageType.image);  // Or video
  // }
}

Future<void> _pickFromGallery() async {
  // final XFile? file = await _picker.pickImage(source: ImageSource.gallery);  // Handle video similarly
  // if (file != null) {
  //   controller.sendMedia(chatId: widget.chatId, filePath: file.path, type: MessageType.image);
  // }
}

Future<void> _pickGif() async {
  // final gif = await GiphyPicker.pickGif(context: context, apiKey: 'YOUR_GIPHY_API_KEY');
  // if (gif?.url != null) {
  //   // Upload or directly send URL if backend allows
  //   controller.sendMessage(message: gif!.url, chatId: widget.chatId);  // Treat as text URL, or upload
  //   // Update to sendMedia if uploading
  // }
}

Future<void> _recordAudio() async {
  // await _recorder.startRecorder(toFile: 'audio.aac');
  // // Show recording UI, stop after user input
  // await Future.delayed(Duration(seconds: 10));  // Example; use a button to stop
  // String? path = await _recorder.stopRecorder();
  // if (path != null) {
  //   controller.sendMedia(chatId: widget.chatId, filePath: path, type: MessageType.audio);
  // }
}

Future<void> _sendPickedImage(String filePath) async {
  final controller = Get.find<ChatRoomController>();
  final success = await controller.sendMedia(
    chatId: widget.chatId,
    filePath: filePath,
    type: MessageType.audio,   // <-- audio, not image
  );

  if (success) {
    _messageController.clear();
  }
}

Future<void> _startVoiceRecording() async {
  if (_isRecording) {
    // STOP
    final path = await _audioRecorder.stopRecorder();
    _isRecording = false;
    if (path != null) {
      await _sendPickedImage(path);
    }
    setState(() {});
    return;
  }

  // START
  final dir = await getTemporaryDirectory();
  final filePath = '${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.aac';

  await _audioRecorder.startRecorder(
    toFile: filePath,
    codec: Codec.aacADTS,
  );
  _isRecording = true;
  setState(() {});
  // Optional: auto-stop after 30 seconds
  Timer(const Duration(seconds: 30), () {
    if (_isRecording) _startVoiceRecording();
  });
}*/
