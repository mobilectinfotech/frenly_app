import 'package:flutter/material.dart';
import 'package:frenly_app/Widgets/custom_appbar.dart';
import 'package:frenly_app/core/constants/my_colour.dart';
import 'package:frenly_app/core/utils/pref_utils.dart';
import 'package:frenly_app/core/utils/size_utils.dart';
import 'package:frenly_app/data/data_sources/remote/api_client.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:intl/intl.dart';
import '../../../../Widgets/custom_image_view.dart';
import '../../../../core/utils/calculateTimeDifference.dart';
import '../../../../data/models/LastSeenModel.dart';
import '../../CustomUI/OwnMessgaeCrad.dart';
import '../../CustomUI/ReplyCard.dart';
import 'chat_room_controller.dart';
import '../chats/chats_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'chat_room_model.dart';
import 'package:get/get.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage(
      {Key? key, required this.participant, required this.chatId})
      : super(key: key);

  final Participant participant;
  final String chatId;

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  ChatRoomController controller = Get.put(ChatRoomController());

  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  final TextEditingController _controller = TextEditingController();

  Future<void> getLastSeen() async {
    lastSeenModel =
        await ApiRepository.lastSeen(id: "${widget.participant.id}");
    setState(() {});
  }

  @override
  void initState() {
    getLastSeen();
    super.initState();
    controller.getAllMsg(chatId: widget.chatId);
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    connect();
  }

  late IO.Socket socket;
  int coiubt = 0;

  Future<void> connect() async {
    Map<String, dynamic> headers = {
      'Authorization': 'Bearer ${PrefUtils().getAuthToken()}', // Example header
    };
    socket = IO.io(
      ApiClient.mainUrl,
      <String, dynamic>{
        "transports": ["websocket"],
        "extraHeaders": headers,
        "autoConnect": false,
      },
    );
    socket.connect();
    socket.onConnect((data) {
      socket.on("messageReceived", (msg) {
        print("messageReceived${coiubt++}");
        try {
          SingleMessage getSingleMsgModel = SingleMessage.fromJson(msg);
          controller.allMsg.messages!.insert(0, getSingleMsgModel);
          controller.allMsgNOTUSE.refresh();
        } catch (e, log) {
          print("catch==>${e.toString()}");
        }
      });
    });
  }

  LastSeenModel? lastSeenModel;

  @override
  void dispose() {
    socket.disconnect(); // Disconnect the socket when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Scaffold(
                  appBar: customAppbarForChat(
                      context: context,
                      handle: lastSeenModel?.data?.isLastSeenAllowed == false
                          ? ""
                          : lastSeenModel!.data?.lastSeen == null
                              ? "Online"
                              : calculateTimeDifference(
                                  "${lastSeenModel!.data?.lastSeen}"),
                      name: "${widget.participant.fullName}".capitalizeFirst,
                      imagepath: widget.participant.avatarUrl),
                  backgroundColor: Colors.transparent,
                  body: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Expanded(
                          // height: MediaQuery.of(context).size.height - 150,
                          child: Obx(
                            () => ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: flipAxis(Axis.horizontal),
                              reverse: true,
                              itemCount: controller.allMsg.messages!.length,
                              itemBuilder: (context, index) {
                                DateTime? currentDate = controller
                                    .allMsg.messages![index].createdAt;
                                DateTime? previousDate = index > 0
                                    ? controller
                                        .allMsg.messages![index - 1].createdAt
                                    : null;
                                if (currentDate == null) {
                                  return const SizedBox
                                      .shrink(); // Skip if datetime is null
                                }

                                bool showDate = previousDate == null ||
                                    currentDate.year != previousDate.year ||
                                    currentDate.month != previousDate.month ||
                                    currentDate.day != previousDate.day;

                                DateTime today = DateTime.now();
                                DateTime yesterday =
                                    DateTime.now().subtract(Duration(days: 1));

                                //today Yesterday logic
                                String formattedDate;

                                if (currentDate.year == today.year &&
                                    currentDate.month == today.month &&
                                    currentDate.day == today.day) {
                                  formattedDate = 'Today';
                                } else if (currentDate.year == yesterday.year &&
                                    currentDate.month == yesterday.month &&
                                    currentDate.day == yesterday.day) {
                                  formattedDate = 'Yesterday';
                                } else {
                                  formattedDate =
                                      DateFormat.yMMMMd().format(currentDate);
                                }
                                //insert date  in chat logic end

                                if ("${controller.allMsg.messages![index].senderId}" !=
                                    "${widget.participant.id}") {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (false)
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            formattedDate,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      OwnMessageCard(
                                        message:
                                            controller.allMsg.messages![index],
                                        createdAt: controller
                                            .allMsg.messages![index].createdAt!
                                            .toLocal(),
                                      ),
                                    ],
                                  );
                                } else {
                                  return ReplyCard(
                                    message: controller.allMsg.messages![index],
                                    createdAt: controller
                                        .allMsg.messages![index].createdAt!
                                        .toLocal(),
                                  );
                                }
                                // if (messages[index].type == "source") {
                                //   return OwnMessageCard(
                                //     message: messages[index].message,
                                //     time: messages[index].time,
                                //   );
                                // } else {

                                // }
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10.aw,
                                    ),
                                    Container(
                                      width: 305.aw,
                                      child: TextFormField(
                                        controller: _controller,
                                        focusNode: focusNode,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 5,
                                        minLines: 1,
                                        onChanged: (value) {
                                          if (value.length > 0) {
                                            setState(() {
                                              sendButton = true;
                                            });
                                          } else {
                                            setState(() {
                                              sendButton = false;
                                            });
                                          }
                                        },
                                        decoration: decoration,
                                      ),
                                    ),
                                    Spacer(),
                                    CircleAvatar(
                                      radius: 20.adaptSize,
                                      backgroundColor: MyColor.primaryColor,
                                      child: IconButton(
                                          icon: const Icon(
                                            Icons.send,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            if (sendButton) {
                                              controller.sendMessage(
                                                  message: _controller.text,
                                                  chatId: widget.chatId);
                                              _controller.clear();
                                              setState(() {
                                                sendButton = false;
                                              });
                                            }
                                          }
                                          // onPressed: () {
                                          //   if (sendButton) {
                                          //     controller.sendMessage(
                                          //         message: sendMsgController.text,
                                          //         chatId: widget.chatId);
                                          //     controller.sendMsgController.clear();
                                          //     setState(() {
                                          //       sendButton = false;
                                          //     });
                                          //   }
                                          // },
                                          ),
                                    ),
                                    SizedBox(
                                      width: 10.aw,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.ah,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  InputDecoration get decoration => InputDecoration(
        hintText: "Message",
        hintStyle: TextStyle(
          color: Color(0xFFA8A8A8),
          fontSize: 20.adaptSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),

        // prefixIcon: CustomImageView(imagePath: "assets/icon/smaily.svg",height: 60.adaptSize,onTap: () {
        //   EmojiPickerWidget();
        // },),
        prefixIconConstraints: BoxConstraints(
          maxHeight: 25.adaptSize,
        ),

//  suffixIcon: suffix,
        // suffixIconConstraints: suffixConstraints,
        isDense: true,

        // contentPadding: EdgeInsets.symmetric(horizontal: 30.aw, vertical: 10.v,),
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

  Widget iconCreation(IconData icons, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }
}
