import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../core/utils/pref_utils.dart';
import '../data/data_sources/remote/api_client.dart';
import '../presentation/chat/Pages/chat_room/chat_room_controller.dart';
import '../presentation/chat/Pages/chat_room/chat_room_model.dart';
import '../presentation/chat/Pages/chats/chats_controller.dart';



class SocketService {
  late IO.Socket _socket;
   RxInt activeChatId = 0.obs;

  Future<void> socketConnect() async {
    try {
      final headers = {
        'Authorization': 'Bearer ${await PrefUtils().getAuthToken()}',
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
