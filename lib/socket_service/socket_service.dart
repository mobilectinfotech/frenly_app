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
  RxInt activeChatId = 0.obs;

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

  // void _handleMessageReceived(dynamic msg) {
  //   try {
  //     final message = SingleMessage.fromJson(msg);
  //
  //     final chatRoomController = Get.isRegistered<ChatRoomController>()
  //         ? Get.find<ChatRoomController>()
  //         : null;
  //
  //     // If user is in the same chat room → realtime add
  //     if (message.chatId == activeChatId.value && chatRoomController != null) {
  //       chatRoomController.allMsgNOTUSE.update((val) {
  //         val!.messages!.insert(0, message);
  //       });
  //     }
  //
  //     // Update chat list (realtime)
  //     final chatScreenController = Get.find<ChatScreenController>();
  //
  //     final chat = chatScreenController.chatsModel.value?.chats
  //         ?.firstWhereOrNull((c) => c.id == message.chatId);
  //
  //     if (chat != null) {
  //       chat.lastMessage?.content = message.content;
  //       chat.lastMessage?.createdAt = message.createdAt;
  //       //chat.unreadCount = chat.id == activeChatId.value ? 0 : (chat.unreadCount ?? 0) + 1;
  //       if (message.chatId == SocketService().activeChatId.value) {
  //         chat.unreadCount = 0;  // inside current chatroom
  //       } else {
  //         chat.unreadCount = (chat.unreadCount ?? 0) + 1; // outside chatroom
  //       }
  //
  //       chatScreenController.chatsModel.update((val) {});
  //     }
  //   } catch (e) {
  //     print("Socket error: $e");
  //   }
  // }


  void _handleMessageReceived(dynamic msg) {
    print('Message received: $msg');

    try {
      final SingleMessage message = SingleMessage.fromJson(msg);

      /// Check if ChatRoomController exists
      final chatRoomController = Get.isRegistered<ChatRoomController>()
          ? Get.find<ChatRoomController>()
          : null;

      /// If user is in SAME chatRoom
      if (message.chatId == activeChatId.value && chatRoomController != null) {

        chatRoomController.allMsgNOTUSE.update((val) {
          val!.messages!.insert(0, message);
        });

        return; /// Do NOT update unreadCount
      }

      /// User is NOT in this chat → update chat list
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

