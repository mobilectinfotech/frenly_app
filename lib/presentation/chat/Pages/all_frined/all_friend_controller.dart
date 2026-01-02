import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/presentation/chat/Pages/all_frined/CreateChatModel.dart';
import 'package:get/get.dart';

import 'AllFriendsModel.dart';

class AllFriendController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  AllFriendsModel allFriendsModel = AllFriendsModel();

  RxBool isLoading =false.obs;
  getAllFriends() async {
    isLoading.value =true;
    allFriendsModel = await ApiRepository.getFriends();
    isLoading.value =false;
  }

  CreateChatModel createChatModel = CreateChatModel();
  RxBool isLoadingCreateChat =false.obs;

   createChat({required String userid }) async {
     isLoadingCreateChat.value =true;
      createChatModel = await ApiRepository.createChat(userId: userid);
     isLoadingCreateChat.value =false;
  }



}
