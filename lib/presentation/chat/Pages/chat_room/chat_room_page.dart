import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
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
        lastSeenUser = "lastSeenHide";
      } else if (lastSeenModel?.data?.lastSeen == null) {
        lastSeenUser = "online";
      } else {
        lastSeenUser = timeago.format(lastSeenModel!.data!.lastSeen!.toLocal());
      }

      setState(() {});
    } catch (e) {
      print("Error fetching last seen: $e");
    }
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
      return '${difference.inDays} ${"days ago".tr}';
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
        )
            : SafeArea(
          child: Scaffold(
            appBar: _buildCustomAppBar(context),
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Expanded(
                  child: _buildMessageList(),
                ),
                _buildMessageInput(),
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
    return Obx(
          () => ListView.builder(
        reverse: true,
        itemCount: controller.allMsg.messages?.length ?? 0,
        itemBuilder: (context, index) {
          final message = controller.allMsg.messages![index];
          final isOwnMessage = message.senderId != widget.participant.id;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTimestamp(index),
              isOwnMessage
                  ? OwnMessageCard(
                message: message,
                createdAt: message.createdAt!.toLocal(),
              )
                  : 
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
