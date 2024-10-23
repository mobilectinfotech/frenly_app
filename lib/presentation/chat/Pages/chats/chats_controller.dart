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

  Rxn<ChatsModel> chatsModel =Rxn(null);
  RxBool isLoading =false.obs;

  //
  Future<void> getchats() async {
    isLoading.value=true;
    final response =await ApiClient().getRequest(endPoint: "chat");

    chatsModel.value = ChatsModel.fromJson(response);
    isLoading.value=false;
  }


}