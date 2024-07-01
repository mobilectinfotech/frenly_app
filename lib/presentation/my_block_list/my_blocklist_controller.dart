
import 'package:get/get.dart';
import '../../../data/repositories/api_repository.dart';
import '../my_following/FollowingsModel.dart';
import 'BlockedUserListModel.dart';

class MyBlockListController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    myFollowers();
  }

  var followingsModelData =BlockedUserListModel().obs;
  BlockedUserListModel get  blockUserList => followingsModelData.value;
  RxBool isLoading = false.obs;

  Future<void> myFollowers() async {
    isLoading.value =true;
    try{
      final response = await ApiRepository.myBlockList();
      followingsModelData(response);
      followingsModelData.refresh();
    }catch(e){
      print("catch${e.toString()}");

    }
    isLoading.value =false;
  }


}