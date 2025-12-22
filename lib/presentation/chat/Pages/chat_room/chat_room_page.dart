import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:audio_session/audio_session.dart';
import 'package:camera/camera.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/core/constants/my_colour.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/data/models/LastSeenModel.dart';
import 'package:frenly_app/socket_service/socket_service.dart';
import 'package:frenly_app/presentation/chat/Pages/chat_room/chat_room_controller.dart';
import 'package:frenly_app/presentation/chat/Pages/chat_room/chat_room_model.dart';
import 'package:frenly_app/presentation/chat/Pages/chats/chats_model.dart';
import '../../../../core/constants/app_dialogs.dart';
import '../../../../core/utils/pref_utils.dart';
import '../../CustomUI/OwnMessgaeCrad.dart';
import '../../CustomUI/ReplyCard.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_sound/flutter_sound.dart';

import '../chats/chats_controller.dart';   // <-- ADD THIS IMPORT

enum MessageType { text, image, video, audio, gif }

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
  //final ChatRoomController controller = Get.put(ChatRoomController());

  final ImagePicker _picker = ImagePicker();
  final FocusNode focusNode = FocusNode();
  final TextEditingController _messageController = TextEditingController();
  String lastSeenUser = '';
  bool show = false;
  bool sendButton = false;
  LastSeenModel? lastSeenModel;
  RxString statusText = "".obs; // last seen / online / offline
  RxBool lastSeenAllowed = true.obs;
  RxBool isOnline = false.obs;

// 1. Audio recorder (created once)
  late final FlutterSoundRecorder _audioRecorder;

// 2. Recording flag
  bool _isRecording = false;


  // @override
  // void initState() {
  //   super.initState();
  //   controller.currentParticipantId = widget.participant.id.toString();
  //   _initializeChat();
  //   _audioRecorder = FlutterSoundRecorder();
  //   _initAudio();
  //   focusNode.addListener(_handleFocusChange);
  // }

  @override
  void initState() {
    super.initState();
    final chatController = Get.find<ChatRoomController>();
    chatController.currentParticipantId = widget.participant.id.toString();
    _initializeChat();
    _audioRecorder = FlutterSoundRecorder();
    _initAudio();
    focusNode.addListener(_handleFocusChange);
  }

  @override
  void onReady() {
    ever(Get.locale!.obs, (_) {
      statusText.refresh();
    });
  }


  ///Pramod Code
  // void _initializeChat() {
  //   SocketService().activeChatId.value = int.parse(widget.chatId);
  //    controller.getAllMsg(chatId: widget.chatId);
  //   SocketService()._socket.emit("joinChat", chatId);
  //   SocketService().joinChatRoom(widget.chatId);
  //   _getLastSeen();
  // }

  Future<void> _initializeChat() async {
    if (!SocketService().socket.connected) {
      await SocketService().socketConnect();
    }
    SocketService().activeChatId.value = int.tryParse(widget.chatId) ?? -1;
   // controller.currentParticipantId = widget.participant.id.toString();
    controller.chatId = widget.chatId;
    controller.currentParticipantId = widget.participant.id.toString();
   await controller.getAllMsg(chatId: widget.chatId);
    SocketService().joinChat(widget.chatId);
    //_getLastSeen();
    _loadInitialLastSeen(); //NEW
  }

  // Future<void> _getLastSeen() async {
  //   try {
  //     lastSeenModel = await ApiRepository.lastSeen(id: widget.participant.id.toString());
  //
  //     if (lastSeenModel?.data?.isLastSeenAllowed == false) {
  //        // lastSeenUser = "lastSeenHide";
  //       ///New
  //      // lastSeenUser = "lastSeenHide".tr;
  //       lastSeenUser = "offline".tr;
  //      // lastSeenUser = "";
  //     } else if (lastSeenModel?.data?.lastSeen == null) {
  //     //  lastSeenUser = "online";
  //       lastSeenUser = "online".tr;
  //     } else {
  //       lastSeenUser = timeago.format(lastSeenModel!.data!.lastSeen!.toLocal());
  //     }
  //     setState(() {});
  //   } catch (e) {
  //     print("Error fetching last seen: $e");
  //   }
  // }

  ///Working
/*
  Future<void> _loadInitialLastSeen() async {
    try {
      lastSeenModel = await ApiRepository.lastSeen(
        id: widget.participant.id.toString(),
      );
      controller.lastSeenAllowed.value =
          lastSeenModel?.data?.isLastSeenAllowed ?? true;
      if (!controller.lastSeenAllowed.value) {
        controller.statusText.value = "offline".tr;
        return;
      }

      final lastSeen = lastSeenModel?.data?.lastSeen;
      if (lastSeen == null) {
        controller.statusText.value = "online".tr;
      } else {
        final dt = lastSeen.toLocal();
        controller.statusText.value = formatLastSeen(dt);
      }
    } catch (e) {
      print("Error loading last seen: $e");
    }
  }
*/

  Future<void> _loadInitialLastSeen() async {
    try {
      lastSeenModel = await ApiRepository.lastSeen(
        id: widget.participant.id.toString(),
      );

      controller.lastSeenAllowed.value =
          lastSeenModel?.data?.isLastSeenAllowed ?? true;

      if (!controller.lastSeenAllowed.value) {
        controller.statusText.value = "offline"; // English
        return;
      }

      final lastSeen = lastSeenModel?.data?.lastSeen;

      if (lastSeen == null) {
        controller.statusText.value = "online"; // English
      } else {
        final dt = lastSeen.toLocal();
        final locale = Get.locale?.languageCode ?? "en";

        controller.statusText.value = timeago.format(
          dt,
          locale: locale,
        );
      }
    } catch (e) {
      print("Error loading last seen: $e");
    }
  }


  // String formatLastSeen(DateTime dt) {
  //   String lang = Get.locale?.languageCode ?? "en";
  //   return timeago.format(
  //     dt,
  //     locale: lang,
  //   );
  // }
  String formatLastSeen(DateTime dt) {
    final langCode = Get.locale?.languageCode;

    return timeago.format(
      dt,
      locale: langCode == 'swe' ? 'swe' : 'en',
    );
  }



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
    // leave current chat room
    SocketService().leaveChat(widget.chatId);
    SocketService().activeChatId.value = -1;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.isLoading.value
            ? Center(
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
                // _buildMessageInput(),
                // SizedBox(height: 30.ah),
                _buildMessageInputt(),
                SizedBox(height: 10.ah),
              ],
            ),
          ),
        ),
      ),
    );

  }

  // PreferredSizeWidget _buildCustomAppBar(BuildContext context) {
  //   print("widget.participant.coverPhotoUrl${widget.participant.coverPhotoUrl}");
  //   return customAppbarForChat(
  //     userId:widget.participant.id.toString(),
  //     context: context,
  //    // handle: lastSeenUser,
  //     handle: controller.statusText.value,
  //     name: widget.participant.fullName?.capitalizeFirst,
  //     imagepath: widget.participant.avatarUrl,
  //   );
  // }

  PreferredSizeWidget _buildCustomAppBar(BuildContext context) {
    final ChatScreenController controllerChat = Get.find<ChatScreenController>();
    final myUserId = int.parse(PrefUtils().getUserId());

    // // ✅ Find correct chat using chatId
    // final chat = controllerChat.chatsModel.value!.chats!
    //     .firstWhere((c) => c.id.toString() == widget.chatId);
    //
    // // ✅ Find other participant from that chat
    // final otherUser = chat.participants!
    //     .firstWhere((p) => p.id != myUserId);

    final chat = controllerChat.chatsModel.value?.chats
        ?.firstWhereOrNull((c) => c.id.toString() == widget.chatId);

    // 🔹 FALLBACK: notification se aaye ho
    final otherUser = chat != null
        ? chat.participants!.firstWhere((p) => p.id != myUserId)
        : widget.participant; // 👈 IMPORTANT

    return PreferredSize(
      preferredSize: Size.fromHeight(70),
      child: Obx(() {
        return customAppbarForChat(
          userId: widget.participant.id.toString(),
          context: context,
          //handle: lastSeenUser
          handle: controller.statusText.value, //LIVE STRING
          name: widget.participant.fullName?.capitalizeFirst,
         // imagepath: widget.participant.avatarUrl,
          imagepath: fixedAvatar(otherUser.avatarUrl),
          // imagepath: otherUser.avatarUrl, // ✅ CORRECT,
        );
      }),
    );
  }

  String? fixedAvatar(String? url) {
    if (url == null) return null;
    if (url.contains('https://www.frenly.se:4000/images/https')) {
      return url.replaceFirst(
        'https://www.frenly.se:4000/images/',
        '',
      );
    }
    return url;
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
                createdAt: message.createdAt!.toLocal()
              ):
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

  Widget _buildTimestamp(int index) {
    try {
      final currentMessage = controller.allMsg.messages![index];
      final previousMessage = controller.allMsg.messages![index + 1];

      if (formatTimestamp(currentMessage.createdAt!) != formatTimestamp(previousMessage.createdAt!)) {
        return Text(formatTimestamp(currentMessage.createdAt!).capitalizeFirst!,
          style: TextStyle(fontSize: 15.adaptSize,
            fontWeight: FontWeight.w600, fontFamily: "Roboto",
          ));
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

  Widget _buildMessageInputt() {
    final ImagePicker _picker = ImagePicker();
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.ah, horizontal: 12.aw),
        child: Container(
              decoration: BoxDecoration(
                 color: Colors.transparent,
                borderRadius: BorderRadius.circular(30.adaptSize),
                border: Border.all(color: Colors.grey.shade400, width: 0.8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.aw, vertical: 6.ah),

              child: Row(
                children: [
                  GestureDetector(
                    onTap: openWhatsappCamera,
                    // onTap: _captureMedia,
                   // onTap: _showImagePiker,
                   //  onTap: () async {
                   //    final result = await Get.to(() =>openWhatsappCamera());
                   //    if (result != null) {
                   //      if (result.endsWith(".mp4")) {
                   //        controller.sendMedia(chatId: widget.chatId, filePath: result, type: MessageType.video);
                   //      } else {
                   //        controller.sendMedia(chatId: widget.chatId, filePath: result, type: MessageType.image);
                   //      }
                   //    }
                   //    },
                    child: Container(
                      width: 36.adaptSize,
                      height: 36.adaptSize,
                      decoration: const BoxDecoration(
                       color:  MyColor.primaryColor,
                      //  color:Colors.pinkAccent,
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
                          fontSize: 15.adaptSize,
                        //  fontSize: 20.adaptSize,
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
                 //  _iconButton(Icons.mic_none_outlined, _recordAudio),
                //  _iconButton(Icons.mic_none_outlined, _startVoiceRecording),

            _iconButton(
              _isRecording ? Icons.mic_off : Icons.mic,
              _recordAudio,
              color: _isRecording ? Colors.red : Colors.black54,
            ),

           // _iconButton(Icons.photo_library_outlined, _pickFromGallery),
                  _iconButton(Icons.photo_library_outlined, _pickFromGallery),

                  _iconButton(Icons.videocam_outlined, _pickVideo),

            //SizedBox(width: 4.aw),
            _iconButton(Icons.gif_box_outlined, _pickGif),

            SizedBox(width: 8.aw),
             _buildSendButton(),
                ],
              ),
         ),
      ),
    );
  }

  // void openWhatsappCamera() async {
  //   final ok = await requestCameraPermissions();
  //   if (!ok) return;
  //   Get.to(() => WhatsappCameraScreen(
  //     onCapture: (path, isVideo){
  //       controller.sendMedia(
  //         chatId: widget.chatId,
  //         filePath: path,
  //         type: isVideo ? MessageType.video : MessageType.image,
  //       );
  //     },
  //   ));
  // }

  void openWhatsappCamera() async {
    final ok = await requestCameraPermissions();
    if (!ok) return;

    try {
      final result = await Get.to(() => WhatsappCameraScreen(
        onCapture: (path, isVideo) {
          controller.sendMedia(
            chatId: widget.chatId,
            filePath: path,
            type: isVideo ? MessageType.video : MessageType.image,
          );
        },
      ));
      if (result == null) print("Camera screen closed without capture");
    } catch (e) {
      print("openWhatsappCamera error: $e");
      AppDialog.taostMessage("Failed to open camera. Please restart app.");
    }
  }

  Future<bool> requestCameraPermissions() async {
    // Log initial statuses
    final initialCamera = await Permission.camera.status;
    final initialMic = await Permission.microphone.status;
    print("Initial Camera Status: $initialCamera");
    print("Initial Mic Status: $initialMic");

    if (initialCamera.isGranted && initialMic.isGranted) {
      print("✅ Permissions already granted");
      return true;
    }

    // Request only if needed
    final results = await [
      Permission.camera,
      Permission.microphone,
    ].request();

    final camera = results[Permission.camera]!;
    final mic = results[Permission.microphone]!;

    print("After Request - Camera: $camera, Mic: $mic");

    // iOS Delay: Wait for propagation (bug fix)
    await Future.delayed(const Duration(milliseconds: 500));

    if (camera.isGranted && mic.isGranted) {
      return true;
    }

    // Double-check for false denial
    final doubleCheckCamera = await Permission.camera.status;
    final doubleCheckMic = await Permission.microphone.status;
    print("Double-check - Camera: $doubleCheckCamera, Mic: $doubleCheckMic");

    if (doubleCheckCamera.isPermanentlyDenied || doubleCheckMic.isPermanentlyDenied) {
      AppDialog.taostMessage("Please enable Camera & Microphone in Settings");
      await openAppSettings();
      return false;
    }

    // Proceed if granted after delay (workaround)
    print("⚠️ False denial detected - proceeding anyway");
    return true;
  }

/*
  Future<bool> requestCameraPermissions() async {
    // iOS-safe: check first
    final cameraGranted = await Permission.camera.isGranted;
    final micGranted = await Permission.microphone.isGranted;

    if (cameraGranted && micGranted) {
      return true;
    }

    // Request only if not granted
    final results = await [
      Permission.camera,
      Permission.microphone,
    ].request();

    final camera = results[Permission.camera];
    final mic = results[Permission.microphone];

    if (camera == PermissionStatus.granted &&
        mic == PermissionStatus.granted) {
      return true;
    }

    // ❌ Only handle permanentlyDenied (NOT restricted)
    if (camera == PermissionStatus.permanentlyDenied ||
        mic == PermissionStatus.permanentlyDenied) {
      AppDialog.taostMessage(
        "Please enable Camera & Microphone access from Settings",
      );
      await openAppSettings();
    }

    return false;
  }
*/


  Future<CroppedFile?> imagePicker({required ImageSource source,
    CropAspectRatio? cropAspectRatio})
  async {
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
                      final picked = await imagePicker(source: ImageSource.gallery);

                      if (picked != null) {
                        await controller.sendMedia(
                          chatId: widget.chatId.toString(),
                          filePath: picked.path,
                          type: MessageType.image,
                        );
                      }
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.video_camera_back_rounded),
                    title: Text('camera'.tr),
                    // onTap: () async {
                    //   controller.coverPhoto = await imagePicker(
                    //     source: ImageSource.camera,
                    //   );
                    //   Navigator.of(context).pop();
                    // },

                    onTap: () async {
                      final picked = await imagePicker(source: ImageSource.camera);
                      if (picked != null) {
                        await controller.sendMedia(
                          chatId: widget.chatId.toString(),
                          filePath: picked.path,
                          type: MessageType.image,
                        );
                      }
                    Get.back();
                   // Get.back();
                  },
                  ),

                  ListTile(
                    leading: Icon(Icons.videocam),
                    title: Text("Record Video"),
                    onTap: () async {
                      await captureVideo();
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _iconButton(IconData icon, VoidCallback onTap, {
        Color color = Colors.black54,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.adaptSize),
      child: Container(
        padding: EdgeInsets.all(6.adaptSize),
        child: Icon(icon, size: 24.adaptSize, color: color),
      ),
    );
  }


  // Future<void> _captureMedia() async {
  //   final XFile? file = await _picker.pickImage(source: ImageSource.camera);
  //   if (file != null) {
  //     await controller.sendMedia(
  //       chatId: widget.chatId,
  //       filePath: file.path,
  //       type: MessageType.video,
  //     );
  //   }
  // }

/*
  Future<void> _captureMedia() async {
    final XFile? video = await _picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(minutes: 5),
    );

    if (video != null) {
      await controller.sendMedia(
        chatId: widget.chatId,
        filePath: video.path,
        type: MessageType.video,
      );
      return;
    }

    // fallback to photo if camera didn't record video
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      await controller.sendMedia(
        chatId: widget.chatId,
        filePath: photo.path,
        type: MessageType.image,
      );
    }
  }
*/

  Future<void> _captureMedia() async {
    final XFile? file = await _picker.pickMedia();

    if (file == null) return;

    if (file.path.toLowerCase().endsWith(".mp4")) {
      await controller.sendMedia(
        chatId: widget.chatId,
        filePath: file.path,
        type: MessageType.video,
      );
    } else {
      await controller.sendMedia(
        chatId: widget.chatId,
        filePath: file.path,
        type: MessageType.image,
      );
    }
  }

  Future<void> captureVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);

    if (video != null) {
      await controller.sendMedia(
        chatId: widget.chatId,
        filePath: video.path,
        type: MessageType.video,
      );
    }
  }

  // Future<void> _pickVideo() async {
  //   final XFile? file = await _picker.pickVideo(
  //     source: ImageSource.gallery,
  //     maxDuration: Duration(minutes: 5),
  //   );
  //
  //   if (file != null) {
  //     await controller.sendMedia(
  //       chatId: widget.chatId,
  //       filePath: file.path,
  //       type: MessageType.video,
  //     );
  //   }
  // }

  Future<void> _pickVideo() async {
    PermissionStatus status;

    if (Platform.isAndroid) {
      if (await DeviceInfoPlugin().androidInfo.then((v) => v.version.sdkInt) >= 33) {
        status = await Permission.videos.request();
      } else {
        status = await Permission.storage.request();
      }

      if (!status.isGranted) {
        AppDialog.taostMessage("Gallery permission required");
        return;
      }
    }

    final XFile? file = await _picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(minutes: 5),
    );

    if (file == null) {
      debugPrint("❌ Video picker returned null");
      return;
    }

    debugPrint("✅ Picked video path: ${file.path}");

    await controller.sendMedia(
      chatId: widget.chatId,
      filePath: file.path,
      type: MessageType.video,
    );
  }


  Future<void> _pickFromGallery() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      await controller.sendMedia(
        chatId: widget.chatId,
        filePath: file.path,
        type: MessageType.image,
      );
    }
  }

  Future<String> downloadGif(String url) async {
    final response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));
    final dir = await getTemporaryDirectory();
    final file = File("${dir.path}/${DateTime.now().millisecondsSinceEpoch}.gif");
    await file.writeAsBytes(response.data);
    return file.path;
  }

  Future<void> _pickGif() async {
    final gif = await GiphyPicker.pickGif(
      context: context,
      apiKey: 'hffmbZdBZrBpe9zrzw8AHJwlWNGJDGXt',
      showPreviewPage: false, // 🚀 remove preview
    );
    if (gif != null && gif.images.original != null) {
      final gifUrl = gif.images.original!.url!;
      final gifPath = await downloadGif(gifUrl);
      await controller.sendMedia(
        chatId: widget.chatId,
        filePath: gifPath,
        type: MessageType.gif,
      );
    }
  }

  // Future<void> _initAudio() async {
  //   await _audioRecorder.openRecorder();
  // }
  /*
  Future<void> _recordAudio() async {
    // 1️⃣ Request mic permission
    var status = await Permission.microphone.request();

    if (!status.isGranted) {
      AppDialog.taostMessage("Microphone permission required");
      return;
    }

    // 2️⃣ STOP recording
    if (_isRecording) {
      print('Reconding = ${_isRecording}');
      final path = await _audioRecorder.stopRecorder();
      _isRecording = false;

      if (path != null) {
        //⭐ GET DURATION BEFORE UPLOAD
        final duration = await controller.getAudioDuration(path);
        print("🎵 Duration before upload: $duration sec");

        await controller.sendMedia(
          chatId: widget.chatId,
          filePath: path,
          type: MessageType.audio,
        );
      }
      setState(() {});
      return;
    }

    // 3️⃣ START recording
    final dir = await getTemporaryDirectory();
   //final filePath = "${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.aac";
   //  final filePath = "${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a";
   //
   //  await _audioRecorder.startRecorder(toFile: filePath, codec: Codec.aacMP4,);


    final filePath = "${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.aac";
    await _audioRecorder.startRecorder(
      toFile: filePath,
      codec: Codec.aacADTS,   // 🔥 THIS FIXES JUST_AUDIO ERROR
    );


    _isRecording = true;
    setState(() {});
  }
*/


  // Future<void> _initAudio() async {
  //   try {
  //     await _audioRecorder.openRecorder();
  //     print("✅ Audio recorder initialized");
  //   } catch (e) {
  //     print("❌ Audio init error: $e");
  //   }
  // }


  // Updated _initAudio (add AVAudioSession config for iOS volume)
  Future<void> _initAudio() async {
    try {
      await _audioRecorder.openRecorder();
      print("✅ Audio recorder initialized");

      // 🔥 iOS VOLUME FIX: Set session category for full mic input
      // if (Platform.isIOS) {
      //   // final session = AVAudioSession.sharedInstance();
      //   // await session.setCategory(AVAudioSessionCategory.playAndRecord);
      //   // await session.setActive(true);
      //   print("✅ iOS AVAudioSession configured for full volume");
      // }
    } catch (e) {
      print("❌ Audio init error: $e");
    }
  }

// Updated _recordAudio with bitrate/sampleRate for speed fix


  Future<void> _recordAudio() async {
    print("🔊 _recordAudio called - isRecording: $_isRecording");

    final hasPermission = await _ensureMicPermission();
    if (!hasPermission) {
      print("❌ Mic permission denied");
      return;
    }

    try {
      /// 🛑 STOP RECORDING
      if (_isRecording) {
        print('🛑 Stopping recording...');
        final path = await _audioRecorder.stopRecorder();
        _isRecording = false;

        if (path != null) {
          final duration = await controller.getAudioDuration(path);
          print("🎵 Duration: $duration sec");

          await controller.sendMedia(
            chatId: widget.chatId,
            filePath: path,
            type: MessageType.audio,
          );
          print("✅ Audio sent");
        }

        /// 🔥 MOST IMPORTANT LINE (FIX)
        await IOSAudioSessionHelper.prepareForPlayback();

        setState(() {});
        return;
      }

      /// ▶️ START RECORDING
      print('▶️ Starting recording...');

      /// 🔥 PREPARE iOS FOR RECORDING
      await IOSAudioSessionHelper.prepareForRecording();

      final dir = await getTemporaryDirectory();
      final filePath =
          "${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a";

      await _audioRecorder.startRecorder(
        toFile: filePath,
        codec: Codec.aacMP4,
        bitRate: 128000,
        numChannels: 1,
        sampleRate: 44100,
      );

      _isRecording = true;
      setState(() {});
      print("✅ Recording started");

    } catch (e) {
      print("❌ Recording error: $e");
      _isRecording = false;

      /// SAFETY: Reset session if error occurs
      await IOSAudioSessionHelper.prepareForPlayback();

      setState(() {});
      AppDialog.taostMessage("Recording failed");
    }
  }

  // Updated _ensureMicPermission with iOS workaround
  Future<bool> _ensureMicPermission() async {
    try {
      final status = await Permission.microphone.status;
      print("Current mic status: $status");

      if (status.isGranted) {
        print("✅ Mic already granted");
        return true;
      }

      // if (status.isPermanentlyDenied || status.isRestricted) {
      //   print("❌ Mic permanently denied/restricted");
      //   AppDialog.taostMessage("Please enable microphone in Settings");
      //   await openAppSettings();
      //   return false;
      // }

// 🔥TEMP DEV BYPASS: Comment out return false; to test recorder

      if (status.isPermanentlyDenied) {
        print("⚠️ DEV BYPASS: Assuming granted");
        return true;  // Remove in production
      }

      print("🔄 Requesting mic permission...");
      final result = await Permission.microphone.request();
      print("Request result: $result");

      // 🔥 ENHANCED iOS WORKAROUND: Delay + triple-check + dummy re-request
      if (Platform.isIOS) {
        await Future.delayed(const Duration(milliseconds: 800));  // Longer delay for sync
        final doubleCheck = await Permission.microphone.status;
        print("iOS double-check: $doubleCheck");

        if (doubleCheck.isGranted) {
          print("✅ iOS sync success - proceeding");
          return true;
        }

        // 🔥 FALLBACK: Dummy re-request to force iOS update (safe, no extra prompt)
        print("🔄 iOS fallback: Dummy re-request...");
        final fallback = await Permission.microphone.request();
        await Future.delayed(const Duration(milliseconds: 300));
        final tripleCheck = await Permission.microphone.status;
        print("Fallback result: $fallback, Triple-check: $tripleCheck");

        if (tripleCheck.isGranted) {
          print("✅ iOS fallback success - proceeding");
          return true;
        }
      }

      return result.isGranted;
    } catch (e) {
      print("❌ Permission error: $e");
      return false;
    }
  }



// // Updated _ensureMicPermission with iOS workaround
//   Future<bool> _ensureMicPermission() async {
//     try {
//       final status = await Permission.microphone.status;
//       print("Current mic status: $status");
//
//       if (status.isGranted) {
//         print("✅ Mic already granted");
//         return true;
//       }
//
//       // if (status.isPermanentlyDenied || status.isRestricted) {
//       //   print("❌ Mic permanently denied/restricted");
//       //   AppDialog.taostMessage("Please enable microphone in Settings");
//       //   await openAppSettings();
//       //   return false;
//       // }
//
// // 🔥TEMP DEV BYPASS: Comment out return false; to test recorder
//       if (status.isPermanentlyDenied) {  // For testing only
//         print("⚠️ DEV BYPASS: Assuming granted");
//         return true;  // Remove in production
//       }
//
//       print("🔄 Requesting mic permission...");
//       final result = await Permission.microphone.request();
//       print("Request result: $result");
//
//       // 🔥 ENHANCED iOS WORKAROUND: Delay + triple-check + dummy re-request
//       if (Platform.isIOS) {
//         await Future.delayed(const Duration(milliseconds: 800));  // Longer delay for sync
//         final doubleCheck = await Permission.microphone.status;
//         print("iOS double-check: $doubleCheck");
//
//         if (doubleCheck.isGranted) {
//           print("✅ iOS sync success - proceeding");
//           return true;
//         }
//
//         // 🔥 FALLBACK: Dummy re-request to force iOS update (safe, no extra prompt)
//         print("🔄 iOS fallback: Dummy re-request...");
//         final fallback = await Permission.microphone.request();
//         await Future.delayed(const Duration(milliseconds: 300));
//         final tripleCheck = await Permission.microphone.status;
//         print("Fallback result: $fallback, Triple-check: $tripleCheck");
//
//         if (tripleCheck.isGranted) {
//           print("✅ iOS fallback success - proceeding");
//           return true;
//         }
//       }
//
//       return result.isGranted;
//     } catch (e) {
//       print("❌ Permission error: $e");
//       return false;
//     }
//   }
//
// // _recordAudio unchanged (your version is good with logs)
//   Future<void> _recordAudio() async {
//     print("🔊 _recordAudio called - isRecording: $_isRecording");
//
//     final hasPermission = await _ensureMicPermission();
//     print("Permission check result: $hasPermission");
//     if (!hasPermission) {
//       print("❌ Permission denied - exiting");
//       return;
//     }
//
//     try {
//       if (_isRecording) {
//         print('🛑 Stopping recording...');
//         final path = await _audioRecorder.stopRecorder();
//         _isRecording = false;
//         print("Stop result: path = $path");
//
//         if (path != null) {
//           final duration = await controller.getAudioDuration(path);
//           print("🎵 Duration before upload: $duration sec");
//
//           await controller.sendMedia(
//             chatId: widget.chatId,
//             filePath: path,
//             type: MessageType.audio,
//           );
//           print("✅ Audio sent successfully");
//         } else {
//           print("❌ StopRecorder returned null path");
//         }
//         setState(() {});
//         return;
//       }
//
//       print('▶️ Starting recording...');
//       final dir = await getTemporaryDirectory();
//       final filePath = "${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a";
//       print("File path: $filePath");
//
//       await _audioRecorder.startRecorder(
//         toFile: filePath,
//         codec: Codec.aacMP4,
//       );
//       print("✅ StartRecorder success");
//
//       _isRecording = true;
//       setState(() {});
//     } catch (e) {
//       print("❌ Recording error: $e");
//       _isRecording = false;
//       setState(() {});
//       AppDialog.taostMessage("Recording failed: $e");
//     }
//   }


/*  Future<void> _recordAudio() async {
    // 🔥 FIX: permission logic
    final hasPermission = await _ensureMicPermission();
    if (!hasPermission) return;

    // 🛑 STOP recording
    if (_isRecording) {
      print('object12345t');
      final path = await _audioRecorder.stopRecorder();
      _isRecording = false;

      if (path != null) {
        final duration = await controller.getAudioDuration(path);
        print("🎵 Duration before upload: $duration sec");

        await controller.sendMedia(
          chatId: widget.chatId,
          filePath: path,
          type: MessageType.audio,
        );
      }

      setState(() {});
      return;
    }

    // ▶️ START recording
    final dir = await getTemporaryDirectory();
    final filePath =
        "${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a";

    await _audioRecorder.startRecorder(
      toFile: filePath,
      codec: Codec.aacMP4, // ✅ correct for iOS + Android
    );

    _isRecording = true;
    setState(() {});
  }


  Future<bool> _ensureMicPermission() async {
    final status = await Permission.microphone.status;

    // ✅ Already granted
    if (status.isGranted) return true;

    // ❌ Permanently denied → Settings
    if (status.isPermanentlyDenied || status.isRestricted) {
      AppDialog.taostMessage(
        "Please enable microphone access from Settings",
      );
      await openAppSettings();
      return false;
    }

    // 🔁 Ask permission only once
    final result = await Permission.microphone.request();
    return result.isGranted;
  }*/


  Future<void> _sendPickedImage(String filePath) async {
    final controller = Get.find<ChatRoomController>();
    final success = await controller.sendMedia(
      chatId: widget.chatId,
      filePath: filePath,
      type: MessageType.image,   // <-- audio, not image
    );
    if (success) {
    //  controller.clear();
    }
  }

  Future<void> startVoiceRecording() async {
    if (_isRecording){
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
     // codec: Codec.aacADTS,
      codec: Codec.aacMP4,
    );

    _isRecording = true;
    setState(() {});
    // Optional: auto-stop after 30 seconds
    Timer(const Duration(seconds: 30), () {
      if (_isRecording) startVoiceRecording();
    });
  }
}

extension on MessageModel1 {
  operator [](int other) {}
}


// class WhatsappCameraScreen extends StatefulWidget {
//   final Function(String path, bool isVideo) onCapture;
//
//   const WhatsappCameraScreen({Key? key, required this.onCapture})
//       : super(key: key);
//
//   @override
//   State<WhatsappCameraScreen> createState() => _WhatsappCameraScreenState();
// }
//
// class _WhatsappCameraScreenState extends State<WhatsappCameraScreen> {
//   CameraController? cam;
//   List<CameraDescription>? cameras;
//
//   bool recording = false;
//   bool isVideoMode = false;
//
//   Timer? timer;
//   int seconds = 0;
//
//   @override
//   void initState() {
//     super.initState();
//
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);
//
//     initCamera();
//   }
//
//   Future initCamera() async {
//     cameras = await availableCameras();
//     await setupController(cameras!.first);
//   }
//
//   Future setupController(CameraDescription camera) async {
//     cam?.dispose();
//
//     cam = CameraController(
//       camera,
//       ResolutionPreset.high,
//       enableAudio: true,
//       imageFormatGroup: ImageFormatGroup.jpeg,
//     );
//
//     await cam!.initialize();
//
//     cam!.lockCaptureOrientation(DeviceOrientation.portraitUp);
//
//     if (mounted) setState(() {});
//   }
//
//   Future switchCamera() async {
//     if (cameras == null) return;
//
//     final lens = cam!.description.lensDirection == CameraLensDirection.back
//         ? CameraLensDirection.front
//         : CameraLensDirection.back;
//
//     final camera = cameras!.firstWhere((c) => c.lensDirection == lens);
//     await setupController(camera);
//   }
//
//   // PHOTO CAPTURE
//   Future capturePhoto() async {
//     try {
//       final file = await cam!.takePicture();
//       widget.onCapture(file.path, false);
//       Get.back();
//     } catch (_) {}
//   }
//
//   // START RECORDING
//   Future startRecording() async {
//     try {
//       await cam!.startVideoRecording();
//       recording = true;
//       seconds = 0;
//
//       timer = Timer.periodic(const Duration(seconds: 1), (_) {
//         setState(() => seconds++);
//       });
//
//       setState(() {});
//     } catch (_) {}
//   }
//
//   // STOP RECORDING
//   Future stopRecording() async {
//     try {
//       final file = await cam!.stopVideoRecording();
//       recording = false;
//
//       timer?.cancel();
//       widget.onCapture(file.path, true);
//       Get.back();
//     } catch (_) {}
//   }
//
//   @override
//   void dispose() {
//     timer?.cancel();
//     cam?.dispose();
//
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (cam == null || !cam!.value.isInitialized) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           /// FULL CAMERA PREVIEW
//           Positioned.fill(
//             child: AspectRatio(
//               aspectRatio: cam!.value.aspectRatio,
//               child: CameraPreview(cam!),
//             ),
//           ),
//
//           /// RECORDING TIME
//           if (recording)
//             Positioned(
//               top: 60,
//               left: 0,
//               right: 0,
//               child: Center(
//                 child: Text(
//                   "$seconds s",
//                   style: const TextStyle(color: Colors.red, fontSize: 24),
//                 ),
//               ),
//             ),
//
//           /// SWITCH CAMERA
//           Positioned(
//             top: 50,
//             right: 20,
//             child: GestureDetector(
//               onTap: switchCamera,
//               child: const CircleAvatar(
//                 backgroundColor: Colors.black45,
//                 child: Icon(Icons.cameraswitch, color: Colors.white),
//               ),
//             ),
//           ),
//
//           /// PHOTO / VIDEO MODE SWITCH
//           Positioned(
//             bottom: 50,
//             left: 30,
//             child: GestureDetector(
//               onTap: () {
//                 setState(() => isVideoMode = !isVideoMode);
//               },
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//                 decoration: BoxDecoration(
//                   color: Colors.black54,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   isVideoMode ? "Video" : "Photo",
//                   style: const TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//             ),
//           ),
//
//           /// MAIN BIG BUTTON
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               padding: const EdgeInsets.only(bottom: 40),
//               child: GestureDetector(
//                 onTap: () {
//                   if (!isVideoMode) {
//                     capturePhoto();
//                   } else {
//                     if (!recording) {
//                       startRecording();
//                     } else {
//                       stopRecording();
//                     }
//                   }
//                 },
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 200),
//                   width: 80,
//                   height: 80,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: isVideoMode
//                         ? (recording ? Colors.red : Colors.white.withOpacity(0.2))
//                         : Colors.white.withOpacity(0.2),
//                     border: Border.all(
//                       color: recording ? Colors.red : Colors.white,
//                       width: 6,
//                     ),
//                   ),
//                   child: Icon(
//                     isVideoMode
//                         ? (recording ? Icons.stop : Icons.fiber_manual_record)
//                         : Icons.camera_alt,
//                     color: Colors.white,
//                     size: 36,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

///Kal Raat Ka
/*class WhatsappCameraScreen extends StatefulWidget {
  final Function(String path, bool isVideo) onCapture;

  const WhatsappCameraScreen({Key? key, required this.onCapture})
      : super(key: key);

  @override
  State<WhatsappCameraScreen> createState() => _WhatsappCameraScreenState();
}

class _WhatsappCameraScreenState extends State<WhatsappCameraScreen> {
  CameraController? cam;
  List<CameraDescription>? cameras;
  bool recording = false;
  Timer? timer;
  int seconds = 0;
  bool isLoading = true;  // Loading state
  String? errorMessage;   // Error state
  int retryCount = 0;     // Retry logic

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _initWithRetry();  // Use retry wrapper
  }

  Future<void> _initWithRetry() async {
    for (int i = 0; i < 3 && errorMessage == null; i++) {  // Retry up to 3x
      try {
        await initCamera();
        if (cameras != null && cameras!.isNotEmpty && cam != null && cam!.value.isInitialized) {
          setState(() {
            isLoading = false;
            errorMessage = null;
          });
          return;
        }
      } catch (e) {
        print("Camera init attempt $i failed: $e");
        setState(() {
          errorMessage = "Camera access failed. Retrying...";
          isLoading = false;
        });
        await Future.delayed(const Duration(seconds: 1));  // Delay before retry
      }
      retryCount++;
    }
    // Final failure
    setState(() {
      errorMessage = "Camera unavailable. Please check permissions and restart app.";
      isLoading = false;
    });
    Future.delayed(const Duration(seconds: 2), () => Get.back());  // Auto-close
  }

  Future initCamera() async {
    try {
      cameras = await availableCameras();  // Wrapped: This throws on denial
      if (cameras == null || cameras!.isEmpty) {
        throw Exception("No cameras available");
      }
      await setupController(cameras!.first);
    } catch (e) {
      print("initCamera error: $e");
      rethrow;  // Bubble to retry
    }
  }

  Future setupController(CameraDescription camera) async {
    try {
      cam?.dispose();  // Safe dispose

      cam = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: true,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await cam!.initialize();  // Wrapped: Native crash point
      await cam!.setFlashMode(FlashMode.off);

      if (mounted) setState(() {});  // Safe setState
    } catch (e) {
      print("setupController error: $e");
      rethrow;  // Bubble to retry
    }
  }

  Future switchCamera() async {
    if (cameras == null) return;

    final lens = cam!.description.lensDirection == CameraLensDirection.back
        ? CameraLensDirection.front
        : CameraLensDirection.back;

    final camera = cameras!.firstWhere((c) => c.lensDirection == lens);
    await setupController(camera);
  }

  Future capturePhoto() async {
    try {
      final file = await cam!.takePicture();
      await cam?.dispose();
      widget.onCapture(file.path, false);
      Get.back();
    } catch (_) {}
  }

  Future startRecording() async {
    try {
      await cam!.startVideoRecording();
      recording = true;
      seconds = 0;
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() => seconds++);
      });
      setState(() {});
    } catch (_) {}
  }

  Future stopRecording() async {
    try {
      final file = await cam!.stopVideoRecording();
      timer?.cancel();
      recording = false;
      await cam?.dispose();
      widget.onCapture(file.path, true);
      Get.back();
    } catch (_) {}
  }

  @override
  void dispose() {
    // Restore orientation (VERY IMPORTANT on iOS)
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    timer?.cancel();

    if (cam != null) {
      if (cam!.value.isStreamingImages) {
        cam!.stopImageStream();
      }
      cam!.dispose();
      cam = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(Icons.camera, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _initWithRetry,  // Retry button
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      );
    }

    if (cam == null || !cam!.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // --- CAMERA PREVIEW FULL SCREEN, NO BLACK BARS ---
          Positioned.fill(
            child: Center(
              child: Transform.rotate(
                angle: cam!.description.sensorOrientation * 3.1415926535 / 180,
                child: FittedBox(
                  fit: cam!.description.lensDirection == CameraLensDirection.front
                      ? BoxFit.none
                      : BoxFit.none,
                  child: SizedBox(
                    width: cam!.value.previewSize!.height,
                    height: cam!.value.previewSize!.width,
                    child: Transform.scale(
                      scale: cam!.description.lensDirection == CameraLensDirection.front ? 0.8 : 1.0,
                      child: CameraPreview(cam!),
                    ),
                  ),
                ),
              ),
            ),
          ),

          if (recording)
            Positioned(
              top: 80.adaptSize,
              left: 0.adaptSize,
              right: 0.adaptSize,
              child: Center(
                child: Text(
                  "$seconds s",
                  style: TextStyle(color: Colors.red, fontSize: 22.fSize),
                ),
              ),
            ),

          Positioned(
            top: 60.adaptSize,
            right: 20.adaptSize,
            child: GestureDetector(
              onTap: switchCamera,
              child: const CircleAvatar(
                backgroundColor: Colors.black45,
                child: Icon(Icons.cameraswitch, color: Colors.white),
              ),
            ),
          ),

          Positioned(
            top: 60.adaptSize,
            left: 20.adaptSize,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: CircleAvatar(
                backgroundColor: Colors.black45,
                child: Icon(Icons.close, color: Colors.white, size: 30.adaptSize),
              ),
            ),
          ),

          Positioned(
            bottom: 150.adaptSize,
            left: 15.adaptSize,
            right: 0.adaptSize,
            child: Center(
              child: Text(
                "Tap_to_capture_Hold_video".tr,
                style: TextStyle(color: Colors.white70, fontSize: 14.fSize),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(bottom: 70.adaptSize),
              child: GestureDetector(
                onTap: () {
                  if (!recording) capturePhoto();
                },
                onLongPress: startRecording,
                onLongPressUp: stopRecording,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: recording ? 85 : 70,
                  height: recording ? 85 : 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(recording ? 0.1 : 0.2),
                    border: Border.all(
                      color: recording ? Colors.red : Colors.white,
                      width: recording ? 6 : 4,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/

///Naya Working
class WhatsappCameraScreen extends StatefulWidget {
  final Function(String path, bool isVideo) onCapture;

  const WhatsappCameraScreen({Key? key, required this.onCapture})
      : super(key: key);

  @override
  State<WhatsappCameraScreen> createState() => _WhatsappCameraScreenState();
}

class _WhatsappCameraScreenState extends State<WhatsappCameraScreen> {
  CameraController? cam;
  List<CameraDescription>? cameras;
  bool recording = false;
  Timer? timer;
  int seconds = 0;
  bool isLoading = true;
  String? errorMessage;
  int retryCount = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _initWithRetry();
  }

  Future<void> _initWithRetry() async {
    for (int i = 0; i < 3 && errorMessage == null; i++) {
      try {
        await initCamera();
        if (cameras != null && cameras!.isNotEmpty && cam != null && cam!.value.isInitialized) {
          setState(() {
            isLoading = false;
            errorMessage = null;
          });
          return;
        }
      } catch (e) {
        print("Camera init attempt $i failed: $e");
        setState(() {
          errorMessage = "Camera access failed. Retrying...";
          isLoading = false;
        });
        await Future.delayed(const Duration(seconds: 1));
      }
      retryCount++;
    }
    setState(() {
      errorMessage = "Camera unavailable. Please check permissions and restart app.";
      isLoading = false;
    });
    Future.delayed(const Duration(seconds: 2),() => Get.back());
  }

  Future initCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras == null || cameras!.isEmpty) {
        throw Exception("No cameras available");
      }
      await setupController(cameras!.first);
    } catch (e) {
      print("initCamera error: $e");
      rethrow;
    }
  }

  Future setupController(CameraDescription camera) async {
    try {
      cam?.dispose();

      cam = CameraController(
        camera,
       // ResolutionPreset.high,
        ResolutionPreset.medium,  // 🔥 FIX: Medium instead of high (reduces buffer demand, fixes overflow)
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await cam!.initialize();
      await cam!.setFlashMode(FlashMode.off);
      await cam!.lockCaptureOrientation(DeviceOrientation.portraitUp); ///yeelagayabaadm

      if (mounted) setState(() {});
    } catch (e) {
      print("setupController error: $e");
      rethrow;
    }

  }

  Future switchCamera() async {
    if (cameras == null) return;

    final lens = cam!.description.lensDirection == CameraLensDirection.back
        ? CameraLensDirection.front
        : CameraLensDirection.back;
    final camera = cameras!.firstWhere((c) => c.lensDirection == lens);
    await setupController(camera);
  }

  Future capturePhoto() async {
    try {
      final file = await cam!.takePicture();
      // await cam?.dispose();
      widget.onCapture(file.path, false);
      Get.back();
    } catch (_) {}
  }

  // Future startRecording() async {
  //   try {
  //     await cam!.startVideoRecording();
  //     recording = true;
  //     seconds = 0;
  //     timer = Timer.periodic(const Duration(seconds: 1), (_) {
  //       setState(() => seconds++);
  //     });
  //     setState(() {});
  //   } catch (_) {}
  // }

  Future startRecording() async {
    try {
      await cam?.dispose();

      cam = CameraController(
        cam!.description,
        ResolutionPreset.high,
        enableAudio: true, // 🔥 mic only for video
      );

      await cam!.initialize();
      await cam!.startVideoRecording();
      recording = true;
      seconds = 0;
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() => seconds++);
      });

      setState(() {});
    } catch (e) {
      print("Video record error: $e");
    }
  }

  Future stopRecording() async {
    try {
      final file = await cam!.stopVideoRecording();
      timer?.cancel();
      recording = false;
      widget.onCapture(file.path, true);
      Get.back();
    } catch (_) {}
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    timer?.cancel();
    if (cam != null) {
      if (cam!.value.isStreamingImages) {
        cam!.stopImageStream();
      }
      cam!.dispose();
      cam = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.camera, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _initWithRetry,
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      );
    }
    if (cam == null || !cam!.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 🔥 FIXED SYNTAX: Proper nesting for Transform child
         /* Positioned.fill(
            child: OverflowBox(
              maxHeight: double.infinity,
              maxWidth: double.infinity,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: cam!.value.previewSize!.height,
                  height: cam!.value.previewSize!.width,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..scale(
                        cam!.description.lensDirection == CameraLensDirection.front ? -1.0 : 1.0,
                        cam!.description.lensDirection == CameraLensDirection.front ? 1.0 : 1.0,
                      )
                      ..rotateZ(cam!.description.sensorOrientation * math.pi / 180.0),
                    child: CameraPreview(cam!),  // 🔥 MOVED: Inside Transform
                  ),
                ),
              ),
            ),
          ),*/

          Positioned.fill(
            child: AspectRatio(
              aspectRatio: cam!.value.aspectRatio,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateZ(
                    GetPlatform.isAndroid ? math.pi / 2 : 0,
                  )
                  ..scale(
                    cam!.description.lensDirection == CameraLensDirection.front
                        ? -1.0
                        : 1.0,
                    1.0,
                  ),
                child: CameraPreview(cam!),
              ),
            ),
          ),

          ///This Belove Code Camera is Proper in IOS Working
         /* Positioned.fill(
            child: SizedBox(
              width: Get.width,
              height: Get.height,
              child: cam!.description.lensDirection == CameraLensDirection.back
                  ? CameraPreview(cam!)
                  : Transform(
                alignment: Alignment.topCenter,
                transform: Matrix4.rotationY(
                  GetPlatform.isAndroid ? math.pi : 0,
                ),
                child: CameraPreview(cam!),
              ),
            ),
          ),*/

          if (recording)
            Positioned(
              top: 80.adaptSize,
              left: 0.adaptSize,
              right: 0.adaptSize,
              child: Center(
                child: Text(
                  "$seconds s",
                  style: TextStyle(color: Colors.red, fontSize: 22.fSize),
                ),
              ),
            ),

          Positioned(
            top: 60.adaptSize,
            right: 20.adaptSize,
            child: GestureDetector(
              onTap: switchCamera,
              child: const CircleAvatar(
                backgroundColor: Colors.black45,
                child: Icon(Icons.cameraswitch, color: Colors.white),
              ),
            ),
          ),

          Positioned(
            top: 60.adaptSize,
            left: 20.adaptSize,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: CircleAvatar(
                backgroundColor: Colors.black45,
                child: Icon(Icons.close, color: Colors.white, size: 30.adaptSize),
              ),
            ),
          ),

          Positioned(
            bottom: 150.adaptSize,
            left: 15.adaptSize,
            right: 0.adaptSize,
            child: Center(
              child: Text("Tap_to_capture_Hold_video".tr,
                style: TextStyle(color: Colors.white70, fontSize: 14.fSize),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(bottom: 70.adaptSize),
              child: GestureDetector(
                onTap: () {
                  if (!recording) capturePhoto();
                },
                onLongPress: startRecording,
                onLongPressUp: stopRecording,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: recording ? 85 : 70,
                  height: recording ? 85 : 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(recording ? 0.1 : 0.2),
                    border: Border.all(
                      color: recording ? Colors.red : Colors.white,
                      width: recording ? 6 : 4,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}





class IOSAudioSessionHelper {
  /// Call BEFORE recording
  static Future<void> prepareForRecording() async {
    if (!Platform.isIOS) return;

    final session = await AudioSession.instance;
    await session.configure(
       AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
        avAudioSessionMode: AVAudioSessionMode.defaultMode,
        avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.defaultToSpeaker |
        AVAudioSessionCategoryOptions.allowBluetooth,
      ),
    );
    await session.setActive(true);
  }

  /// Call AFTER recording (VERY IMPORTANT)
  static Future<void> prepareForPlayback() async {
    if (!Platform.isIOS) return;

    final session = await AudioSession.instance;
    await session.configure(
      const AudioSessionConfiguration.music(),
    );
    await session.setActive(true);
  }
}



/*
class WhatsappCameraScreen extends StatefulWidget {
  final Function(String path, bool isVideo) onCapture;

  const WhatsappCameraScreen({Key? key, required this.onCapture})
      : super(key: key);

  @override
  State<WhatsappCameraScreen> createState() => _WhatsappCameraScreenState();
}

class _WhatsappCameraScreenState extends State<WhatsappCameraScreen> {
  CameraController? cam;
  List<CameraDescription>? cameras;
  bool recording = false;
  Timer? timer;
  int seconds = 0;

  @override
  void initState() {
    super.initState();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    initCamera();
  }

  // Future initCamera() async {
  //   cameras = await availableCameras();
  //   await setupController(cameras!.first);
  // }


  Future initCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras == null || cameras!.isEmpty) return;
      await setupController(cameras!.first);
    } catch (e) {
      Get.back();
    }
  }


  Future setupController(CameraDescription camera) async {
    cam?.dispose();

    cam = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: true,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await cam!.initialize();
    await cam!.setFlashMode(FlashMode.off); // forces sensor reset

  //  await cam!.lockCaptureOrientation(DeviceOrientation.portraitUp);
  //   cam = CameraController(
  //     camera,
  //     ResolutionPreset.high,
  //     enableAudio: true,
  //   );
  //
 //   await cam!.initialize();
    // if (mounted) setState(() {});

    if (mounted) setState(() {});
  }

  Future switchCamera() async {
    if (cameras == null) return;

    final lens = cam!.description.lensDirection == CameraLensDirection.back
        ? CameraLensDirection.front
        : CameraLensDirection.back;

    final camera = cameras!.firstWhere((c) => c.lensDirection == lens);
    await setupController(camera);
  }

  Future capturePhoto() async {
    try {
      final file = await cam!.takePicture();
      await cam?.dispose();
      widget.onCapture(file.path, false);
      Get.back();
    } catch (_) {}
  }

  Future startRecording() async {
    try {
      await cam!.startVideoRecording();
      recording = true;
      seconds = 0;
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() => seconds++);
      });
      setState(() {});
    } catch (_) {}
  }

  Future stopRecording() async {
    try {
      final file = await cam!.stopVideoRecording();
      timer?.cancel();
      recording = false;
      await cam?.dispose();
      widget.onCapture(file.path, true);
      Get.back();
    } catch (_) {}
  }

  // @override
  // void dispose() {
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.portraitUp,
  //   ]);
  //
  //   try {
  //     cam?.stopImageStream();
  //   } catch (_) {}
  //
  //   timer?.cancel();
  //   cam?.dispose();
  //  //  if (cam != null) {
  //  //    cam!.dispose();
  //  //  }
  //   super.dispose();
  // }


  @override
  void dispose() {
    // 🔁 Restore orientation (VERY IMPORTANT on iOS)
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    timer?.cancel();

    if (cam != null) {
      if (cam!.value.isStreamingImages) {
        cam!.stopImageStream();
      }
      cam!.dispose();
      cam = null;
    }

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (cam == null || !cam!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Positioned.fill(
          //   child: Center(
          //     child: Transform.rotate(
          //       angle: cam!.description.lensDirection == CameraLensDirection.front
          //           ? -cam!.description.sensorOrientation * 3.1415926535 / 180
          //           : cam!.description.sensorOrientation * 3.1415926535 / 180,
          //       child: AspectRatio(
          //         aspectRatio: cam!.value.aspectRatio,
          //         child: SizedBox(
          //             width: cam!.value.previewSize!.height,
          //             height: cam!.value.previewSize!.width,
          //             child: CameraPreview(cam!)),
          //       ),
          //     ),
          //   ),
          // ),


          // --- CAMERA PREVIEW FULL SCREEN, NO BLACK BARS ---
          Positioned.fill(
            child: Center(
              child: Transform.rotate(
                angle: cam!.description.sensorOrientation * 3.1415926535 / 180,
                child: FittedBox(
                  fit:  cam!.description.lensDirection == CameraLensDirection.front
                      ? BoxFit.none
                      : BoxFit.none,
                  child: SizedBox(
                    width: cam!.value.previewSize!.height,
                    height: cam!.value.previewSize!.width,
                    child: Transform.scale(
                        scale: cam!.description.lensDirection == CameraLensDirection.front ? 0.8 : 1.0,
                        child: CameraPreview(cam!)),
                  ),
                ),
              ),
            ),
          ),

          // Positioned.fill(
          //   child: Center(
          //     child: Transform.rotate(
          //       angle: (cam!.description.sensorOrientation * 3.1415926535 / 180),
          //       child: FittedBox(
          //         fit: BoxFit.fitHeight,
          //         child: SizedBox(
          //           width: cam!.value.previewSize!.height.adaptSize,
          //           height: cam!.value.previewSize!.height.adaptSize,
          //           child: CameraPreview(cam!),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          if (recording)
            Positioned(
              top: 80.adaptSize,
              left: 0.adaptSize,
              right: 0.adaptSize,
              child: Center(
                child: Text(
                  "$seconds s",
                  style:TextStyle(color: Colors.red, fontSize: 22.fSize),
                ),
              ),
            ),

          Positioned(
            top: 60.adaptSize,
            right: 20.adaptSize,
            child: GestureDetector(
              onTap: switchCamera,
              child: const CircleAvatar(
                backgroundColor: Colors.black45,
                child: Icon(Icons.cameraswitch, color: Colors.white),
              ),
            ),
          ),

          Positioned(
            top: 60.adaptSize,
            left: 20.adaptSize,
            child: GestureDetector(
              onTap:(){
                Get.back();
              },
              child:CircleAvatar(
                backgroundColor: Colors.black45,
                child: Icon(Icons.close, color: Colors.white,size: 30.adaptSize),
              ),
            ),
          ),

          Positioned(
            bottom: 150.adaptSize,
            left: 15.adaptSize,
            right:0.adaptSize,
            child: Center(
              child: Text("Tap_to_capture_Hold_video".tr,
                style: TextStyle(color: Colors.white70, fontSize: 14.fSize),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(bottom: 70.adaptSize,),
              child: GestureDetector(
                onTap: () {
                if (!recording) capturePhoto();
              //     if (!recording) {
              //       startRecording();
              //     } else {
              //       stopRecording();
              //     }
                },
                onLongPress: startRecording,
                onLongPressUp: stopRecording,
                child: AnimatedContainer(
                  duration:  Duration(milliseconds: 200),
                  width: recording ? 85 : 70,
                  height: recording ? 85 : 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(recording ? 0.1 : 0.2),
                    border: Border.all(
                      color: recording ? Colors.red : Colors.white,
                      width: recording ? 6 : 4,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/


// <?xml version="1.0" encoding="UTF-8"?>
// <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
// <plist version="1.0">
// <dict>
// <key>CADisableMinimumFrameDurationOnPhone</key>
// <true/>
// <key>CFBundleDevelopmentRegion</key>
// <string>$(DEVELOPMENT_LANGUAGE)</string>
// <key>CFBundleDisplayName</key>
// <string>Frenly</string>
// <key>CFBundleExecutable</key>
// <string>$(EXECUTABLE_NAME)</string>
// <key>CFBundleIdentifier</key>
// <string>com.cti.frenly</string>
// <key>CFBundleInfoDictionaryVersion</key>
// <string>6.0</string>
// <key>CFBundleName</key>
// <string>Frenly</string>
// <key>CFBundlePackageType</key>
// <string>APPL</string>
// <key>CFBundleShortVersionString</key>
// <string>$(FLUTTER_BUILD_NAME)</string>
// <key>CFBundleSignature</key>
// <string>????</string>
// <key>CFBundleVersion</key>
// <string>$(FLUTTER_BUILD_NUMBER)</string>
// <key>LSRequiresIPhoneOS</key>
// <true/>
// <key>NSCameraUsageDescription</key>
// <string>To capture profile photo please grant camera access</string>
// <key>NSPhotoLibraryUsageDescription</key>
// <string>App needs access to photo lib for profile images</string>
// <key>UIApplicationSupportsIndirectInputEvents</key>
// <true/>
// <key>UILaunchStoryboardName</key>
// <string>LaunchScreen</string>
// <key>UIMainStoryboardFile</key>
// <string>Main</string>
// <key>UISupportedInterfaceOrientations</key>
// <array>
// <string>UIInterfaceOrientationPortrait</string>
// <string>UIInterfaceOrientationLandscapeLeft</string>
// <string>UIInterfaceOrientationLandscapeRight</string>
// </array>
// <key>UISupportedInterfaceOrientations~ipad</key>
// <array>
// <string>UIInterfaceOrientationPortrait</string>
// <string>UIInterfaceOrientationPortraitUpsideDown</string>
// <string>UIInterfaceOrientationLandscapeLeft</string>
// <string>UIInterfaceOrientationLandscapeRight</string>
// </array>
// </dict>
// </plist>

