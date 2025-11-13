import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:image_cropper/image_cropper.dart';
import '../../../../data/data_sources/remote/api_client.dart';
import '../../Model/msg_model.dart';
import '../chats/chats_controller.dart';
import 'chat_room_model.dart';
// import 'package:dio/dio.dart';   // for FormData


// enum MessageType { text, image, video, audio, gif }
class ChatRoomController extends GetxController {
  MessageModel1 messageModel1 = MessageModel1(messages: []);
  GetSingleMsgModel? getSingleMsgModel = GetSingleMsgModel();
  List<SingleMessage> messages = [];

  var allMsgNOTUSE = MessageModel1(messages: []).obs;

  MessageModel1 get allMsg => allMsgNOTUSE.value;

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
    print("${response}");
    messageModel1 = MessageModel1.fromJson(response);

    messages = MessageModel1.fromJson(response).messages!;
    var firstLoad = MessageModel1(messages: messages);
    allMsgNOTUSE(firstLoad);
    allMsgNOTUSE.refresh();
    isLoading.value = false;
  }

  Future<bool> sendMessage({required String message, required String chatId}) async {
    final response = await ApiClient().postRequest(
        endPoint: "message/${chatId}",
        body: {"content": "${message}"});

    var msggg = response["message"];
    SingleMessage getSingleMsgModel = SingleMessage.fromJson(msggg);
    allMsg.messages!.insert(0, getSingleMsgModel);
    allMsgNOTUSE.refresh();

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
