import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../core/utils/pref_utils.dart';
import '../data/data_sources/remote/api_client.dart';
import '../presentation/chat/Pages/chat_room/chat_room_controller.dart';
import '../presentation/chat/Pages/chat_room/chat_room_model.dart';
import '../presentation/chat/Pages/chats/chats_controller.dart';


///Pramod Code
/*
class SocketService {
  late IO.Socket _socket;
   RxInt activeChatId = 0.obs;

  Future<void> socketConnect() async {
    try {
      final headers = {
        'Authorization': 'Bearer ${PrefUtils().getAuthToken()}',
      };

      _socket = IO.io(
        ApiClient.mainUrl,
        <String, dynamic>{
          'transports': ['websocket'],
          'extraHeaders': headers,
          'autoConnect': false,
        },
      );

      _socket.connect();
      _addSocketListeners();
    } catch (e) {
      print('Socket connection failed: $e');
    }
  }
  Future<void> socketDisconnect() async {
    _socket.disconnect();
    print('Socket disconnected.');
  }

   void _addSocketListeners() {
    _socket.onConnect((_) => print('Socket connected successfully!'));
    _socket.onConnectError((data) => print('Connection Error: $data'));
    _socket.onDisconnect((_) => print('Socket disconnected.'));
    _socket.on('messageReceived', _handleMessageReceived);
  }
   void _handleMessageReceived(dynamic msg) {
    print('Message received: $msg');
    try {
      final SingleMessage message = SingleMessage.fromJson(msg);
       ChatRoomController chatRoomController ;
      try{
      chatRoomController = Get.find<ChatRoomController>();
      }catch(e){
        chatRoomController = Get.put(ChatRoomController());
      }

      if (message.chatId == activeChatId.value) {
        chatRoomController.allMsg.messages!.insert(0, message);
        chatRoomController.allMsgNOTUSE.refresh();
        //chatRoomController.addIncomingMessage(message);
      }

      final ChatScreenController chatScreenController = Get.find<ChatScreenController>();
      final chat = chatScreenController.chatsModel.value!.chats!.firstWhereOrNull(
            (c) => c.id == message.chatId,
      );

      if (chat != null) {
        chat.unreadCount = (chat.unreadCount ?? 0) + 1;
        chat.lastMessage?.content = message.content ?? 'No content';
        chat.lastMessage?.createdAt = message.createdAt;
        chatScreenController.chatsModel.refresh();
      } else {
        chatScreenController.getchats();
      }
    } catch (e) {
      print('Error processing message: $e');
    }
  }

}
*/


class SocketService {
  late IO.Socket _socket;
  IO.Socket get socket => _socket; // public getter if you ever need raw socket
  RxInt activeChatId = (-1).obs; // -1 means "no active chat"

  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  Future<void> socketConnect() async {
    try {
      final headers = {
        'Authorization': 'Bearer ${PrefUtils().getAuthToken()}',
      };

      _socket = IO.io(
        ApiClient.mainUrl,
        {
          'transports': ['websocket'],
          'extraHeaders': headers,
          'autoConnect': false,
        },
      );

      // IMPORTANT: add listeners BEFORE connecting
      _addSocketListeners();

      // Then connect
      _socket.connect();
    } catch (e) {
      print('Socket connection failed: $e');
    }
  }

  Future<void> socketDisconnect() async {
    try {
      _socket.disconnect();
      print('Socket disconnected.');
    } catch (e) {
      print('Socket disconnect failed: $e');
    }
  }

  void joinChat(dynamic chatId) {
    try {
      if (chatId == null) return;
      final cid = chatId.toString();
      activeChatId.value = int.tryParse(cid) ?? -1;
      _socket.emit("joinChat", cid);
      print("Joined chat room: $cid");
    } catch (e) {
      print("joinChat error: $e");
    }
  }

  void leaveChat(dynamic chatId) {
    try {
      if (chatId == null) return;
      final cid = chatId.toString();
      if (activeChatId.value == int.tryParse(cid)) {
        activeChatId.value = -1;
      }
      _socket.emit("leaveChat", cid);
      void leaveChat(dynamic chatId) {
        try {
          if (chatId == null) return;
          final cid = chatId.toString();

          // reset active ID
          if (activeChatId.value == int.tryParse(cid)) {
            activeChatId.value = -1;
          }

          _socket.emit("leaveChat", cid);
          print("Left chat room: $cid");

        } catch (e) {
          print("leaveChat error: $e");
        }
      }

      print("Left chat room: $cid");
    } catch (e) {
      print("leaveChat error: $e");
    }
  }

  void _addSocketListeners() {
    _socket.onConnect((_) => print('Socket connected successfully!'));
    _socket.onConnectError((data) => print('Connection Error: $data'));
    _socket.onDisconnect((_) => print('Socket disconnected......'));
    // debug all events
    _socket.onAny((event, data) {
      print("🔔 SOCKET EVENT: $event => $data");
    });


    _socket.on('user_status_updated', (data) {
      print("USER STATUS UPDATED: $data");

      final int userId = data['userId'];
      final bool isOnline = data['isOnline'] == 1 || data['isOnline'] == true;
      final String? lastSeen = data['lastSeen'];
      final bool isLastSeenAllowed = data['isLastSeenAllowed'];

      if (Get.isRegistered<ChatRoomController>()) {
        final chatRoomController = Get.find<ChatRoomController>();
        chatRoomController.updateUserStatus(userId, isOnline, lastSeen,isLastSeenAllowed);
      }
    });


    _socket.on('messageReceived', _handleMessageReceived);

    _socket.on('message_seen', (data) {
      print("🔵MESSAGE SEEN EVENT (socket): $data");
      try {
        final int chatId = data['chatId'] is int ? data['chatId'] : int.parse("${data['chatId']}");
        final List messageIds = List.from(data['messageIds'] ?? []);
        if (Get.isRegistered<ChatRoomController>()) {
          final chatRoomController = Get.find<ChatRoomController>();
          chatRoomController.updateMessagesAsSeen(chatId, messageIds);
        }
      } catch (e) {
        print("Error processing message_seen event: $e");
      }
    });

    print("Socket listeners added.");

    _socket.off('user_status_updated');

    // _socket.on("my_last_seen_setting_changed", (data) {
    //   print("SOCKET: last seen setting changed => $data");
    //
    //   if (Get.isRegistered<ChatRoomController>()) {
    //     final controller = Get.find<ChatRoomController>();
    //
    //     controller.lastSeenAllowed.value = data["isLastSeenAllowed"];
    //
    //     if (!controller.lastSeenAllowed.value) {
    //       controller.statusText.value = "offline".tr;
    //     } else {
    //       // if allowed again, show last seen via API or previous state
    //       // optional: you can trigger a refresh here
    //     }
    //   }
    // });

  }

  void _handleMessageReceived(dynamic msg) {
    print('Message received: $msg');

    try {
      final SingleMessage message = SingleMessage.fromJson(msg);

      final chatRoomController = Get.isRegistered<ChatRoomController>()
          ? Get.find<ChatRoomController>()
          : null;

      if (message.chatId == activeChatId.value && chatRoomController != null) {
        chatRoomController.allMsgNOTUSE.update((val) {
          val!.messages!.insert(0, message);
        });
        return;
      }

      final chatScreenController = Get.find<ChatScreenController>();

      final chat = chatScreenController.chatsModel.value!.chats!
          .firstWhereOrNull((c) => c.id == message.chatId);

      if (chat != null) {
        chat.unreadCount = (chat.unreadCount ?? 0) + 1;
        chat.lastMessage?.content = message.content;
        chat.lastMessage?.createdAt = message.createdAt;
        chatScreenController.chatsModel.refresh();
      } else {
        chatScreenController.getchats();
      }
    } catch (e) {
      print('Error processing message: $e');
    }
  }
}


// class SocketService {
//   late IO.Socket _socket;
//   RxInt activeChatId = 0.obs;
//
//   static final SocketService _instance = SocketService._internal();
//   factory SocketService() => _instance;
//   SocketService._internal();
//
//
//   Future<void> socketConnect() async {
//     try {
//       final headers = {
//         'Authorization': 'Bearer ${PrefUtils().getAuthToken()}',
//       };
//
//       _socket = IO.io(
//         ApiClient.mainUrl,
//         {
//           'transports': ['websocket'],
//           'extraHeaders': headers,
//           'autoConnect': false,
//         },
//       );
//
//       _socket.connect();
//       _addSocketListeners();
//
//     } catch (e) {
//       print('Socket connection failed: $e');
//     }
//   }
//
//   Future<void> socketDisconnect() async {
//     _socket.disconnect();
//     print('Socket disconnected.');
//   }
//
//   void _addSocketListeners() {
//     _socket.onConnect((_) => print('Socket connected successfully!'));
//     _socket.onConnectError((data) => print('Connection Error: $data'));
//     _socket.onDisconnect((_) => print('Socket disconnected.'));
//     _socket.on('messageReceived', _handleMessageReceived);
//     _socket.on('message_seen', (data) {
//       print("🔵MESSAGE SEEN EVENT: $data");
//
//       int chatId = data['chatId'];
//       List messageIds = data['messageIds'];
//       final chatRoomController = Get.find<ChatRoomController>();
//       chatRoomController.updateMessagesAsSeen(chatId, messageIds);
//     });
//
//     print("qwert+$_handleMessageReceived");
//   }
//
//   // void _handleMessageReceived(dynamic msg) {
//   //   try {
//   //     final message = SingleMessage.fromJson(msg);
//   //
//   //     final chatRoomController = Get.isRegistered<ChatRoomController>()
//   //         ? Get.find<ChatRoomController>()
//   //         : null;
//   //
//   //     // If user is in the same chat room → realtime add
//   //     if (message.chatId == activeChatId.value && chatRoomController != null) {
//   //       chatRoomController.allMsgNOTUSE.update((val) {
//   //         val!.messages!.insert(0, message);
//   //       });
//   //     }
//   //
//   //     // Update chat list (realtime)
//   //     final chatScreenController = Get.find<ChatScreenController>();
//   //
//   //     final chat = chatScreenController.chatsModel.value?.chats
//   //         ?.firstWhereOrNull((c) => c.id == message.chatId);
//   //
//   //     if (chat != null) {
//   //       chat.lastMessage?.content = message.content;
//   //       chat.lastMessage?.createdAt = message.createdAt;
//   //       //chat.unreadCount = chat.id == activeChatId.value ? 0 : (chat.unreadCount ?? 0) + 1;
//   //       if (message.chatId == SocketService().activeChatId.value) {
//   //         chat.unreadCount = 0;  // inside current chatroom
//   //       } else {
//   //         chat.unreadCount = (chat.unreadCount ?? 0) + 1; // outside chatroom
//   //       }
//   //
//   //       chatScreenController.chatsModel.update((val) {});
//   //     }
//   //   } catch (e) {
//   //     print("Socket error: $e");
//   //   }
//   // }
//
//
//   void _handleMessageReceived(dynamic msg) {
//     print('Messabvsfdgbdzge received: $msg');
//
//     try {
//       final SingleMessage message = SingleMessage.fromJson(msg);
//
//       /// Check if ChatRoomController exists
//       final chatRoomController = Get.isRegistered<ChatRoomController>()
//           ? Get.find<ChatRoomController>()
//           : null;
//
//       /// If user is in SAME chatRoom
//       if (message.chatId == activeChatId.value && chatRoomController != null) {
//
//         chatRoomController.allMsgNOTUSE.update((val) {
//           val!.messages!.insert(0, message);
//         });
//
//         return; /// Do NOT update unreadCount
//       }
//
//       /// User is NOT in this chat → update chat list
//       final chatScreenController = Get.find<ChatScreenController>();
//
//       final chat = chatScreenController.chatsModel.value!.chats!
//           .firstWhereOrNull((c) => c.id == message.chatId);
//
//       if (chat != null) {
//         chat.unreadCount = (chat.unreadCount ?? 0) + 1;
//         chat.lastMessage?.content = message.content;
//         chat.lastMessage?.createdAt = message.createdAt;
//         chatScreenController.chatsModel.refresh();
//       } else {
//         chatScreenController.getchats();
//       }
//
//     } catch (e) {
//       print('Error processing message: $e');
//     }
//   }
// }

