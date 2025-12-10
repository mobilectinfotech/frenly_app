import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
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
import '../../CustomUI/OwnMessgaeCrad.dart';
import '../../CustomUI/ReplyCard.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_sound/flutter_sound.dart';   // <-- ADD THIS IMPORT

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

  @override
  void initState() {
    super.initState();
    controller.currentParticipantId = widget.participant.id.toString();
    _initializeChat();
    _audioRecorder = FlutterSoundRecorder();
    _initAudio();
    focusNode.addListener(_handleFocusChange);
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
    controller.currentParticipantId = widget.participant.id.toString();
    controller.getAllMsg(chatId: widget.chatId);
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

  String formatLastSeen(DateTime dt) {
    String lang = Get.locale?.languageCode ?? "en";
    return timeago.format(
      dt,
      locale: lang,
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
    return PreferredSize(
      preferredSize: Size.fromHeight(70),
      child: Obx(() {
        return customAppbarForChat(
          userId: widget.participant.id.toString(),
          context: context,
          //handle: lastSeenUser
          handle: controller.statusText.value, //LIVE STRING
          name: widget.participant.fullName?.capitalizeFirst,
          imagepath: widget.participant.avatarUrl,
        );
      }),
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

  void openWhatsappCamera() {
    Get.to(() => WhatsappCameraScreen(
      onCapture: (path, isVideo){
        controller.sendMedia(
          chatId: widget.chatId,
          filePath: path,
          type: isVideo ? MessageType.video : MessageType.image,
        );
      },
    ));
  }


  Future<CroppedFile?> imagePicker(
      {required ImageSource source, CropAspectRatio? cropAspectRatio})
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

  Widget
  _iconButton(IconData icon, VoidCallback onTap, {
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

  Future<void> _pickVideo() async {
    final XFile? file = await _picker.pickVideo(
      source: ImageSource.gallery,
      maxDuration: Duration(minutes: 5),
    );

    if (file != null) {
      await controller.sendMedia(
        chatId: widget.chatId,
        filePath: file.path,
        type: MessageType.video,
      );
    }
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

  Future<void> _initAudio() async {
    await _audioRecorder.openRecorder();
  }

  Future<void> _recordAudio() async {
    // 1️⃣ Request mic permission
    var status = await Permission.microphone.request();

    if (!status.isGranted) {
      AppDialog.taostMessage("Microphone permission required");
      return;
    }

    // 2️⃣ STOP recording
    if (_isRecording) {
      final path = await _audioRecorder.stopRecorder();
      _isRecording = false;

      if (path != null) {
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
    final filePath = "${dir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.aac";

    await _audioRecorder.startRecorder(toFile: filePath);

    _isRecording = true;
    setState(() {});
  }

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
      codec: Codec.aacADTS,
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    initCamera();
  }

  Future initCamera() async {
    cameras = await availableCameras();
    await setupController(cameras!.first);
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
    await cam!.lockCaptureOrientation(DeviceOrientation.portraitUp);
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

  @override
  void dispose() {
    try {
      cam?.stopImageStream();
    } catch (_) {}

    timer?.cancel();
    cam?.dispose();
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
}




