import 'package:flutter/cupertino.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:frenly_app/presentation/user_profile_screen/user_profile_model.dart';
import 'package:get/get.dart';

class  MyProfileController extends GetxController{


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfile();
  }
  late BuildContext context;


  var getUserByIdModelData =GetUserByIdModel().obs;

  GetUserByIdModel get  getUserByIdModel => getUserByIdModelData.value;

  RxBool isLoading =false.obs;


  getProfile() async {
    isLoading.value =true;
    final response  =await ApiRepository.myProfile();
    getUserByIdModelData(response);
    getUserByIdModelData.refresh();

    isLoading.value =false;
  }


}