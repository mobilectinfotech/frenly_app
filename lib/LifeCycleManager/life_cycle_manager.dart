// import 'package:flutter/material.dart';import 'package:velocity_x/velocity_x.dart';
// import 'package:get/get.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import '../core/utils/pref_utils.dart';
// import '../data/data_sources/remote/api_client.dart';
// import '../presentation/chat/Pages/chat_room/chat_room_controller.dart';
// import '../presentation/chat/Pages/chat_room/chat_room_model.dart';
// import '../presentation/chat/Pages/chats/chats_controller.dart';
//
// late IO.Socket sockettt;
// RxInt activeChatId = 0.obs;
//
// class LifeCycleManager extends StatefulWidget {
//   LifeCycleManager({Key? key, required this.child}) : super(key: key);
//
//   final Widget child;
//
//   @override
//   _LifeCycleManagerState createState() => _LifeCycleManagerState();
// }
//
// class _LifeCycleManagerState extends State<LifeCycleManager>
//     with WidgetsBindingObserver {
//   // ChatRoomController controller = Get.put(ChatRoomController(),permanent: true);
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     socketConnect();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//     print('AppLifecycleState: $state');
//     if (state == AppLifecycleState.inactive) {
//       socketDisConnect();
//     } else if (state == AppLifecycleState.hidden) {
//       socketDisConnect();
//     } else if (state == AppLifecycleState.paused) {
//       socketDisConnect();
//     } else if (state == AppLifecycleState.resumed) {
//       socketConnect();
//     } else {
//       socketDisConnect();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
// }
//
// Future<void> socketConnect() async {
//   Map<String, dynamic> headers = {
//     'Authorization': 'Bearer ${await PrefUtils().getAuthToken()}',
//     // Example header
//   };
//
//   sockettt = IO.io(
//     ApiClient.mainUrl, // Passing userId as a query parameter
//     <String, dynamic>{
//       "transports": ["websocket"],
//       "extraHeaders": headers,
//       "autoConnect": false,
//     },
//   );
//
//   sockettt.connect();
//
//   // Listeners
//   sockettt.onConnect((data) {
//     print("Socket connected successfully!");
//   });
//
//   sockettt.onConnectError((data) {
//     print("Connection Error: $data");
//   });
//
//   sockettt.onDisconnect((data) {
//     print("Socket disconnected.");
//   });
//
//   sockettt.on("messageReceived", (msg) {
//     print("messageReceived==>${msg.toString()}");
//     try {
//       SingleMessage getSingleMsgModel = SingleMessage.fromJson(msg);
//       if (getSingleMsgModel.chatId == activeChatId.value) {
//         Get.find<ChatRoomController>().allMsg.messages!.insert(0, getSingleMsgModel);
//         Get.find<ChatRoomController>().allMsgNOTUSE.refresh();
//       }
//
//       // ChatScreenController
//
//       bool b = true;
//       for (int i = 0; i < Get.find<ChatScreenController>().chatsModel.value!.chats!.length; i++) {
//         if (Get.find<ChatScreenController>().chatsModel.value!.chats![i].id == getSingleMsgModel.chatId) {
//           int unreadCount = Get.find<ChatScreenController>().chatsModel.value!.chats![i].unreadCount ?? 0;
//           unreadCount = unreadCount + 1;
//           Get.find<ChatScreenController>().chatsModel.value!.chats![i].unreadCount = unreadCount;
//           Get.find<ChatScreenController>().chatsModel.value!.chats![i].lastMessage?.content = getSingleMsgModel.content ?? "asdfghn";
//           Get.find<ChatScreenController>().chatsModel.value!.chats![i].lastMessage?.createdAt = getSingleMsgModel.createdAt;
//           Get.find<ChatScreenController>().chatsModel.refresh();
//           b = false;
//         }
//       }
//       if (b) {
//         Get.find<ChatScreenController>().getchats();
//       }
//
//
//     } catch (e) {
//       print("object${e.toString()}");
//     }
//   });
// }
//
// Future<void> socketDisConnect() async {
//   print("socketDisConnect_line117");
//   sockettt.disconnect(); // Disconnect the
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';import 'package:velocity_x/velocity_x.dart';
import '../presentation/chat/Pages/chat_room/chat_room_controller.dart';
import '../presentation/chat/Pages/chats/chats_controller.dart';
import '../socket_service/socket_service.dart';

class LifeCycleManager extends StatefulWidget {
  const LifeCycleManager({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}
class _LifeCycleManagerState extends State<LifeCycleManager> with WidgetsBindingObserver {
  final SocketService _socketService = SocketService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  //  _socketService.socketConnect();
    /// ensure socket is connected once at start
    SocketService().socketConnect();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        // _socketService.socketDisconnect();
       // break;
      // USER LEFT APP --> GO OFFLINE
     //  _socketService.socketDisconnect();
      break;

      case AppLifecycleState.resumed:
      /// ensure socket still alive
        if(!SocketService().socket.connected) {
          SocketService().socketConnect();
        }

        /// rejoin chat room
        if(Get.isRegistered<ChatRoomController>()){
          final c = Get.find<ChatRoomController>();
          SocketService().joinChat(c.chatId);
          SocketService().socket.emit("markSeen", {
            "chatId": c.chatId
          });
        }

      // // USER RETURNED --> GO ONLINE
      //   _socketService.socketConnect();
      //
      //   // REJOIN CHAT
      //   if(Get.isRegistered<ChatRoomController>()){
      //     final c = Get.find<ChatRoomController>();
      //     SocketService().joinChat(c.chatId);
      //     SocketService().socket.emit("markSeen", {
      //       "chatId": c.chatId
      //     });
      //   }

        break;
      default:
        _socketService.socketDisconnect();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _socketService.socketDisconnect();
    super.dispose();
  }
}

