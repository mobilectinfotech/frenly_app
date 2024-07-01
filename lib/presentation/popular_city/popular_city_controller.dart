
import 'package:frenly_app/data/models/LiveUserModel.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_model.dart';
import 'package:get/get.dart';

class PopularController extends GetxController{


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfile();
  }

  LiveUserModel liveUserModel = LiveUserModel();

  RxBool isLoading =false.obs;


  getProfile() async {
    isLoading.value =true;
    liveUserModel =await ApiRepository.liveUser();
    isLoading.value =false;
  }


}