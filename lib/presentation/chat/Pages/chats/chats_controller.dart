import 'package:get/get.dart';
import '../../../../data/data_sources/remote/api_client.dart';
import 'chats_model.dart';

class ChatScreenController extends GetxController{



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getchats();
  }


  ChatsModel chatsModel =ChatsModel();
  RxBool isLoading =false.obs;


  Future<void> getchats() async {
    isLoading.value=true;
    final response =await ApiClient().getRequest(endPoint: "chat");
    print("asdfghgfdsasdfgh${response}");
    chatsModel= ChatsModel.fromJson(response);
    isLoading.value=false;
  }


}