// import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../data/data_sources/remote/api_client.dart';
import '../../Model/msg_model.dart';
import '../chats/chats_controller.dart';
import 'chat_room_model.dart';
// import 'package:dio/dio.dart'; // for FormData

// enum MessageType { text, image, video, audio, gif }
class ChatRoomController extends GetxController {
  MessageModel1 messageModel1 = MessageModel1(messages: []);
  GetSingleMsgModel? getSingleMsgModel = GetSingleMsgModel();
  List<SingleMessage> messages = [];

  RxString statusText = "".obs;
  RxBool lastSeenAllowed = true.obs;
  RxBool isOnline = false.obs;

  late String currentParticipantId;



  var allMsgNOTUSE = MessageModel1(messages: []).obs;

  // MessageModel1 get allMsg => allMsgNOTUSE.value;

  MessageModel1 get allMsg => allMsgNOTUSE.value;
  set allMsg(MessageModel1 value) => allMsgNOTUSE.value = value;

  CroppedFile? coverPhoto;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  RxBool isLoading = false.obs;

  Future<void> getAllMsg({required String chatId}) async {
    isLoading.value = true;
    final response = await ApiClient().getRequest(endPoint: "message/$chatId");
    print("Apirty+${response}");

    messageModel1 = MessageModel1.fromJson(response);

    messages = MessageModel1.fromJson(response).messages!;
    var firstLoad = MessageModel1(messages: messages);
    allMsgNOTUSE(firstLoad);
    allMsgNOTUSE.refresh();
    isLoading.value = false;
  }

  ///Pramod COde
  // Future<bool> sendMessage({required String message, required String chatId}) async {
  //   final response = await ApiClient().postRequest(
  //       endPoint: "message/${chatId}",
  //       body: {"content": "${message}"});
  //
  //   var msggg = response["message"];
  //   SingleMessage getSingleMsgModel = SingleMessage.fromJson(msggg);
  //   allMsg.messages!.insert(0, getSingleMsgModel);
  //   allMsgNOTUSE.refresh();
  //   return true;
  // }


  Future<bool> sendMessage({required String message, required String chatId}) async {
    final response = await ApiClient().postRequest(
        endPoint: "message/$chatId",
        body: {"content": message});

    var msgData = response["message"];
    SingleMessage sentMessage = SingleMessage.fromJson(msgData);

    /// Insert into ChatRoom immediately
    allMsgNOTUSE.update((val) {
      val!.messages!.insert(0, sentMessage);
    });

    /// 🔥 UPDATE CHAT LIST (VERY IMPORTANT)
    final chatScreenController = Get.find<ChatScreenController>();

    final chat = chatScreenController.chatsModel.value?.chats
        ?.firstWhereOrNull((c) => c.id.toString() == chatId);

    if (chat != null) {
      chat.lastMessage?.content = message;                   // latest message text
      chat.lastMessage?.createdAt = DateTime.now();          // latest time
      chat.unreadCount = 0;                                  // own message → no unread
      chatScreenController.chatsModel.refresh();             // refresh UI
    }

    return true;
  }


  @override
  void dispose() {
  print("line 60");
    super.dispose();
    print("line 60");
  }

  ChatScreenController chatScreenController =Get.find<ChatScreenController>();

  @override
  void onClose() {
    print("line 61");
    // chatScreenController.getchats();
    // TODO: implement onClose
    super.onClose();
    print("line 62");
  }

  // void updateMessagesAsSeen(int chatId, List messageIds) {
  //   if (allMsgNOTUSE.value.messages == null) return;
  //   for (var msg in allMsgNOTUSE.value.messages!) {
  //     if (msg.chatId == chatId && messageIds.contains(msg.id)) {
  //       msg.isRead = true;
  //     }
  //   }
  //   allMsgNOTUSE.refresh(); // UI update
  // }

  void updateMessagesAsSeen(int chatId, List messageIds) {
    final list = allMsg.messages;
    if (list == null) return;

    for (var msg in list) {
      if (msg.chatId == chatId && messageIds.contains(msg.id)) {
        msg.isRead = true;
        msg.seen = true;   // <- VERY IMPORTANT
      }
    }

    allMsgNOTUSE.refresh();   // now UI will rebuild
  }


  // void updateUserStatus(int userId, bool isOnline, String? lastSeen) {
  //   try {
  //     final list = allMsg.messages;
  //     if (list == null) return;
  //
  //     for (var msg in list) {
  //       if (msg.senderId == userId) {
  //         msg.sender?.isOnline = isOnline ? 1 : 0;
  //         msg.sender?.lastSeen = lastSeen;
  //       }
  //     }
  //
  //     allMsgNOTUSE.refresh();
  //
  //     print("✅ USER STATUS UPDATED: user $userId → online: $isOnline, lastSeen: $lastSeen");
  //   } catch (e) {
  //     print("❌ Error in updateUserStatus: $e");
  //   }
  // }

  void updateUserStatus(int userId, bool online, String? lastSeenUtc, bool isLastSeenAllowed) {

    if (userId.toString() != currentParticipantId) {
      return;
    }

    if (!isLastSeenAllowed) {
      statusText.value = "offline".tr;
      return;
    }

    if (online) {
      statusText.value = "online".tr;
    } else if (lastSeenUtc != null) {
      final dt = DateTime.parse(lastSeenUtc).toLocal();
      statusText.value = timeago.format(dt);
    }
  }





/*
  Future<bool> sendMedia({
    required String chatId,
    required String filePath,
    required MessageType type,
  }) async {
    try {
      // 1. Upload file
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });

      final uploadResponse = await ApiClient().postRequest(
        endPoint: "upload/chat-media",   // <-- YOUR BACKEND ENDPOINT
        body: formData,
      );

      final String? fileUrl = uploadResponse['url'] as String?;
      if (fileUrl == null) {
        Get.snackbar('Error', 'Upload failed');
        return false;
      }

      // 2. Send message with URL + type
      final messageResponse = await ApiClient().postRequest(
        endPoint: "message/$chatId",
        body: {
          "content": fileUrl,
          "type": type.toString().split('.').last, // "image", "audio", etc.
        },
      );

      final msgJson = messageResponse["message"];
      final newMsg = SingleMessage.fromJson(msgJson);

      allMsg.messages!.insert(0, newMsg);
      allMsgNOTUSE.refresh();

      return true;
    } catch (e) {
      Get.snackbar('Error', 'Send failed: $e');
      return false;
    }
  }
*/

}

// class ChatRoomController extends GetxController {
//   /// Reactive list of all messages in the chat
//   RxList<SingleMessage> allMessages = <SingleMessage>[].obs;
//
//   RxBool isLoading = false.obs;
//
//   /// Fetch messages for this chat
//   Future<void> getAllMsg({required String chatId}) async {
//     try {
//       isLoading.value = true;
//       final response = await ApiClient().getRequest(endPoint: "message/$chatId");
//       final model = MessageModel1.fromJson(response);
//
//       allMessages.assignAll(model.messages ?? []);
//     } catch (e) {
//       print("Error fetching messages: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   /// Send a message and immediately add it to the UI
//   Future<bool> sendMessage({
//     required String message,
//     required String chatId,
//   }) async {
//     try {
//       final response = await ApiClient().postRequest(
//         endPoint: "message/$chatId",
//         body: {"content": message},
//       );
//
//       final msg = SingleMessage.fromJson(response["message"]);
//       allMessages.insert(0, msg); // Instant UI update
//       return true;
//     } catch (e) {
//       print("Send message failed: $e");
//       return false;
//     }
//   }
//
//   /// Called by socket when a message is received
//   void addIncomingMessage(SingleMessage message) {
//     // Prevent duplicate inserts
//     final exists = allMessages.any((m) => m.id == message.id);
//     if (!exists) {
//       allMessages.insert(0, message);
//     }
//   }
//
//   /// Refresh chat list when closing chat
//   final ChatScreenController chatScreenController = Get.find();
//
//   @override
//   void onClose() {
//     super.onClose();
//     print("ChatRoomController closed");
//     chatScreenController.getchats();
//   }
// }

/*
import 'package:get/get.dart';
import '../../../../data/data_sources/remote/api_client.dart';
import '../chats/chats_controller.dart';
import 'chat_room_model.dart';

class ChatRoomController extends GetxController {
  // Make messages directly observable
  var allMsg = <SingleMessage>[].obs;

  RxBool isLoading = false.obs;

  ChatScreenController chatScreenController = Get.find<ChatScreenController>();

  @override
  void onInit() {
    super.onInit();
  }

  /// Fetch all messages for a chat
  Future<void> getAllMsg({required String chatId}) async {
    try {
      isLoading.value = true;

      final response = await ApiClient().getRequest(endPoint: "message/$chatId");
      print(response);

      final fetchedMessages = MessageModel1.fromJson(response).messages ?? [];

      // Assign messages to the observable list
      allMsg.assignAll(fetchedMessages.reversed.toList()); // reverse if needed

    } catch (e) {
      print("Error fetching messages: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Send a new message
  Future<bool> sendMessage({required String message, required String chatId}) async {
    try {
      final response = await ApiClient().postRequest(
        endPoint: "message/$chatId",
        body: {"content": message},
      );

      var msgJson = response["message"];
      final newMessage = SingleMessage.fromJson(msgJson);

      // Insert message at top of the list
      allMsg.insert(0, newMessage);

      return true;
    } catch (e) {
      print("Error sending message: $e");
      return false;
    }
  }

  /// Optional: Add incoming messages (e.g., from sockets)
  void addMessage(SingleMessage message) {
    allMsg.insert(0, message);
  }

  @override
  void onClose() {
    print("ChatRoomController closed");
    super.onClose();
  }

  @override
  void dispose() {
    print("ChatRoomController disposed");
    super.dispose();
  }
}
*/
