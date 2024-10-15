import 'package:get/get.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';

import 'FollowersModel.dart';

class MyFollowersController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  var followingsModelData =FollowersModel().obs;
  FollowersModel get  followingsModel => followingsModelData.value;
  RxBool isLoading = false.obs;

  Future<void> myFollowers() async {
    isLoading.value =true;
    try{
      final response = await ApiRepository.myFollowers();
      followingsModelData(response);
      followingsModelData.refresh();
      print("fdsffssfsfsfs${followingsModel.followers?.length}");
    }catch(e){
      print("catch${e.toString()}");

    }
    isLoading.value =false;
  }








}