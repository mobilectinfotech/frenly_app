
import 'package:get/get.dart';
import '../../../data/repositories/api_repository.dart';
import 'FollowingsModel.dart';

class MyFollowingsController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    myFollowers();
  }

  var followingsModelData =FollowingsModel().obs;
  FollowingsModel get  followingsModel => followingsModelData.value;
  RxBool isLoading = false.obs;

  Future<void> myFollowers() async {
    isLoading.value =true;
    try{
      final response = await ApiRepository.myFollowings();
      followingsModelData(response);
      followingsModelData.refresh();
    }catch(e){
      print("catch${e.toString()}");

    }
    isLoading.value =false;
  }


}