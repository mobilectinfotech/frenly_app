import 'package:flutter/cupertino.dart';
import 'package:frenly_app/data/repositories/api_repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../auth/my_profile_view/my_profile_controller.dart';
class PostVideoController extends GetxController{


  TextEditingController titleController =TextEditingController();
  TextEditingController desController =TextEditingController();
  XFile? pikedVideo ;
  
  RxBool isLoading = false.obs;
  postVlog()async{
    isLoading.value=true;
  bool isPost = await ApiRepository.postVlog( photoPath: pikedVideo!.path, title: titleController.text, des: desController.text);
    isLoading.value=true;
    if(isPost){
      if(Get.isRegistered<MyProfileController>()) {
        Get.find<MyProfileController>().getProfile(); //pramod
      }
      Get.back();
    }
  }

  editVlog()async{
    isLoading.value=true;
    bool isPost = await ApiRepository.updateVlog(id: '', title: '', body: '', );
    isLoading.value=true;
    if(isPost){
      if(Get.isRegistered<MyProfileController>()) {
        Get.find<MyProfileController>().getProfile(); //done
      }

      Get.back();
    }
  }

}