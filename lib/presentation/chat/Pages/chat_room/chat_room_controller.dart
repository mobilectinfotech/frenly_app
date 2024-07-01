import 'package:get/get.dart';
import '../../../../data/data_sources/remote/api_client.dart';
import '../../Model/msg_model.dart';
import '../chats/chats_controller.dart';
import 'chat_room_model.dart';

class ChatRoomController extends GetxController {

  MessageModel1 messageModel1 = MessageModel1(messages: []);
  GetSingleMsgModel? getSingleMsgModel = GetSingleMsgModel();
  List<SingleMessage> messages = [];

  var allMsgNOTUSE = MessageModel1(messages: []).obs;

  MessageModel1 get allMsg => allMsgNOTUSE.value;

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

  Future<bool> sendMessage(
      {required String message, required String chatId}) async {
    final response = await ApiClient().postRequest(
        endPoint: "message/${chatId}", body: {"content": "${message}"});
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
    chatScreenController.getchats();
    // TODO: implement onClose
    super.onClose();
    print("line 62");
  }
}
